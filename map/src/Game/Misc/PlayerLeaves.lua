if Debug then Debug.beginFile "Game/Misc/PlayerLeaves" end
OnInit.map("PlayerLeaves", function(require)
    require "StateTable"
    function NIFPO_Sort()
        if IsPlayerHuman(GetEnumPlayer()) then
            ForceAddPlayer(udg_TempPlayerGroup, GetEnumPlayer())
        end
    end

    ---@return player
    function NoninfectedForcePickOne()
        local p ---@type player

        udg_TempPlayerGroup = CreateForce()
        ForForce(GetPlayersAll(), NIFPO_Sort)
        p = ForcePickRandomPlayer(udg_TempPlayerGroup)
        DestroyForce(udg_TempPlayerGroup)
        return p
    end

    function Trig_PlayerLeaves_Actions()
        local p ---@type player
        local b                                                   = IsUnitDeadBJ(udg_Playerhero
            [GetConvertedPlayerId(GetTriggerPlayer())]) ---@type boolean

        udg_Player_Left[GetConvertedPlayerId(GetTriggerPlayer())] = true
        DisplayTextToForce(GetPlayersAll(),
            (udg_OriginalName[GetConvertedPlayerId(GetTriggerPlayer())] + "|cff408080 has left the game!|r"))
        KillUnit(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())])                       --Kill leaver's playerhero unit
        UnitAddAbility(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())], FourCC('A02T')) --And stay dead
        StateTable.SetPlayerState(GetTriggerPlayer(), State.Left)

        --If less than 90 seconds passed AND player who left is alien, mutant, or android
        if TimerGetElapsed(udg_GameTimer) <= 90.0 and (IsPlayerMainInfected(GetTriggerPlayer()) or udg_HiddenAndroid == GetTriggerPlayer()) then
            if udg_Mutant == GetTriggerPlayer() then
                DisplayTextToForce(GetPlayersAll(), "Reassigning a new mutant...")
                p = NoninfectedForcePickOne()
                if p ~= nil then
                    udg_Mutant = p
                    StateTable.SetPlayerRole(udg_Mutant, Role.Mutant)
                    DisplayTextToPlayer(p, 0, 0,
                        "|cffFF0000You are now the mutant. Seek out all enemies and destroy them.")
                    CreateNUnitsAtLoc(1, FourCC('e031'), p, udg_HoldZone, bj_UNIT_FACING) --Was GetEnumUnit()
                    --If it doesn't work, also add the ability on the playerhero unit
                else
                    DisplayTextToForce(GetPlayersAll(), "Not enough players for a new mutant.")
                end
            end

            if udg_Parasite == GetTriggerPlayer() then
                DisplayTextToForce(GetPlayersAll(), "Reassigning a new alien...")
                p = NoninfectedForcePickOne()
                if p ~= nil then
                    udg_Parasite = p
                    StateTable.SetPlayerRole(udg_Parasite, Role.Alien)
                    DisplayTextToPlayer(p, 0, 0,
                        "|cffFF0000You are now the alien. Seek out all enemies and destroy them.")
                    SetPlayerAllianceStateBJ(Player(bj_PLAYER_NEUTRAL_EXTRA), p, bj_ALLIANCE_ALLIED_ADVUNITS)
                else
                    DisplayTextToForce(GetPlayersAll(), "Not enough players for a new alien.")
                end
            end

            if udg_HiddenAndroid == GetTriggerPlayer() then
                DisplayTextToForce(GetPlayersAll(), "Reassigning a new android...")
                p = NoninfectedForcePickOne()
                if p ~= nil then
                    udg_HiddenAndroid = p
                    StateTable.SetPlayerRole(udg_HiddenAndroid, Role.Android)
                    DisplayTextToPlayer(p, 0, 0,
                        "|cffFF0000You are now the android. Protect the humans and eliminate the alien threat.")
                else
                    DisplayTextToForce(GetPlayersAll(), "Not enough players for a new android.")
                end
            end
        end
    end

    --===========================================================================
    local i             = 0 ---@type integer
    gg_trg_PlayerLeaves = CreateTrigger()
    while i <= 11 do
        TriggerRegisterPlayerEventLeave(gg_trg_PlayerLeaves, Player(i))
        i = i + 1
    end
    TriggerAddAction(gg_trg_PlayerLeaves, Trig_PlayerLeaves_Actions)
end)
if Debug then Debug.endFile() end
