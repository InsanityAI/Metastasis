library Space requires CompositeGameSpace, SimpleGameSpace, Table
    globals
        public CompositeGameSpace Space
        public SimpleGameSpace JustSpace

        private Table visibilityMods // table<player, fogmodifier>
        private boolean tempShow
    endglobals

    public function ShowSpaceForPlayer takes player thisPlayer, boolean show returns nothing
        local fogmodifier fogModifier

        if visibilityMods.stores(thisPlayer) then
            set fogModifier = visibilityMods.fogmodifier.get(thisPlayer)
            call FogModifierStop(fogModifier)
            call DestroyFogModifier(fogModifier)
        endif

        if show then
            set fogModifier = CreateFogModifierRect(thisPlayer, FOG_OF_WAR_VISIBLE)
        else
            set fogModifier = CreateFogModifierRect(thisPlayer, FOG_OF_WAR_MASKED)
        endif
        call FogModifierStart(fogModifier)
        call visibilityMods.fogmodifier.store(thisPlayer, fogModifier)
    endfunction

    private function ShowSpaceForPlayerEnum takes nothing returns nothing
        call ShowSpaceForPlayer(GetEnumPlayer(), tempShow)
    endfunction

    public function ShowSpace takes boolean show returns nothing
        set tempShow = show
        call ForForce(GetPlayersAll(), function ShowSpaceForPlayerEnum)
    endfunction
    
    public function EnterSpace takes GameSpace gameSpace returns nothing
        call Space.addGameSpace(gameSpace)
    endfunction

    public function LeaveSpace takes GameSpace gameSpace returns nothing
        call Space.removeGameSpace(gameSpace)
    endfunction

    public function Initialize takes nothing returns Station
        set Space = CompositeGameSpace.create()
        set JustSpace = SimpleGameSpace.create()
        call JustSpace.addRect(gg_rct_Space)
        call Space.addGameSpace(JustSpace)
        call Space.initialize()
        call ShowSpace(true)
        // TODO: check if GetPlayersAll encapsulates neutrals - So pirates and drones can see all of space
        //call CreateFogModifierRectBJ( true, Player(PLAYER_NEUTRAL_AGGRESSIVE), FOG_OF_WAR_VISIBLE, gg_rct_Space )
    endfunction
endlibrary