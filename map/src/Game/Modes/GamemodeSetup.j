library GamemodeSetup initializer init requires StandardMode, VotingDialog, Timeout, Table, UserNotifications
    globals 
        private force userPlayers

        private Table gamemodeMap //table<MultiOptionDialogButtonOption, Gamemode>
        private MultiOptionDialogButtonOption GAMEMODE_STANDARD_OPTION

        public Gamemode gamemode
    endglobals

    private function initializeGamemode takes nothing returns nothing
        call gamemode.StartSetup()
        call gamemode.EndSetup()
        call gamemode.StartGame()
    endfunction

    private function votingDone takes Table selectedOptions returns nothing //table<MultiOptionDialogButtonOption[]> 
        local Table options = selectedOptions.getKeys()
        local integer i = options[0]

        if i > 0 then
            set gamemode = gamemodeMap[selectedOptions[options[i]]]
            set i = i - 1
        endif

        call DestroyForce(userPlayers)
        call initializeGamemode()
    endfunction

    private function gamemodeOptionStandardPreview takes player thisPlayer returns nothing 
        call UserNotif(thisPlayer, "|cff00FFFFStandard|r: The original gamemode. Alien(s) vs Mutant vs Humans, last standing faction wins.")
    endfunction

    private function gamemodeButton takes nothing returns MultiOptionDialogButton
        local MultiOptionDialogButton btn = MultiOptionDialogButton.create()
        local Table options = Table.create()
        set options[0] = gamemodeOptionStandard()

        set btn.prefix = "Gamemode: "
        set btn.options = options
        return btn
    endfunction

    private function commitButton takes nothing returns DialogButton
        local DialogButton btn = DialogButton.create()
        set btn.text = "Vote for this setup!"
        set btn.hotkey = -1
        return btn
    endfunction

    private function enumUsers takes nothing returns boolean
        return GetPlayerSlotState(GetFilterPlayer()) == PLAYER_SLOT_STATE_PLAYING and GetPlayerController(GetFilterPlayer()) == MAP_CONTROL_USER
    endfunction

    private function startVoting takes nothing returns nothing
        local VotingDialog votingDialog = VotingDialog.create()
        local filterfunc enumUsersFilter = Filter(function enumUsers)
        local Table setupButtons = Table.create()//table<MultiOptionDialogButton, boolean>

        set setupButtons.boolean[gamemodeButton()] = true

        set votingDialog.votingDoneCallback = votingDone
        set votingDialog.title = "Game Setup"
        set votingDialog.commitButton = commitButton()
        set votingDialog.buttons = setupButtons
        
        call ForceEnumPlayers(userForce, enumUsersFilter)
        call DestroyBoolExpr(enumUsersFilter)
        call VotingDialog_Enqueue(votingDialog, GetPlayersAll())
        //Don't destroy userForce, it's being used until voting is done!
    endfunction

    private function init takes nothing returns nothing
        set gamemodeMap = Table.create()
        set userPlayers = CreateForce()
        call Timeout.start(0.00, false, function startVoting)

        set GAMEMODE_STANDARD_OPTION = MultiOptionDialogButtonOption.create()
        set GAMEMODE_STANDARD_OPTION.name = "Standard"
        set GAMEMODE_STANDARD_OPTION.previewCallback = gamemodeOptionStandardPreview
        set gamemodeMap[GAMEMODE_STANDARD_OPTION] = StandardMode.create()
    endfunction
endlibrary