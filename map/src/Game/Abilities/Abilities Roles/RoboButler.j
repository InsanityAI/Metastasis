library RoboButler requires Timeout 
    globals
        private integer BUTLER_KEY = 1
    endglobals

    private function move takes nothing returns nothing 
        local Table t = Timeout.getData() 
        local RoboButler butler = t[BUTLER_KEY] 

        local real angle = bj_RADTODEG * Atan2(GetUnitY(butler.butler) -GetUnitY(butler.owner), GetUnitX(butler.butler) -GetUnitX(butler.owner)) 
        local real x = GetUnitX(butler.owner) + 75.0 * CosBJ(angle) 
        local real y = GetUnitY(butler.owner) + 75.0 * SinBJ(angle) 
        
        //Remove if owner is dead or missing 
        if not UnitAlive(butler.owner) or butler.owner == null then 
            call RemoveUnit(butler.butler) 
            call Timeout.stop(t, true) 
            return 
        endif 

        //Will not follow spacial alien into space.  
        //Instead will magically stay at the same spot, and warp to spacial alien when it boards.   
        if not RectContainsCoords(gg_rct_Space, x, y) then 
            call SetUnitX(butler.butler, x) 
            call SetUnitY(butler.butler, y) 
        endif 

        //TODO: rewrite this when appropriate 
        if GetOwningPlayer(butler.owner) == Player(bj_PLAYER_NEUTRAL_EXTRA) or GetUnitTypeId(butler.owner) == 'h01D' or udg_Player_IsMasquerading[GetConvertedPlayerId(GetOwningPlayer(butler.owner))] or GetUnitAbilityLevel(butler.owner, 'A08D') >= 1 then 
            //The alien is in alien form or the mutant is a stalker. Cloaking will be applied.   
            call UnitAddAbility(butler.butler, UnitAbilityIds_GHOST) 
        else 
            call UnitRemoveAbility(butler.butler, UnitAbilityIds_GHOST) 
        endif 
    endfunction 

    struct RoboButler 
        readonly unit owner 
        readonly unit butler 

        public method show takes boolean show returns nothing 
            if show then 
                call UnitAddAbility(this.butler, UnitAbilityIds_GHOST) 
            else 
                call UnitRemoveAbility(this.butler, UnitAbilityIds_GHOST) 
            endif 
        endmethod 

        static method create takes unit hero returns thistype 
            local thistype this = thistype.allocate() 
            set this.owner = hero 
            set this.butler = CreateUnit(GetOwningPlayer(hero), UnitIds_CEO_BUTLER, GetUnitX(hero), GetUnitY(hero), bj_UNIT_FACING) 
            return this 
        endmethod 
    endstruct 

    public function Bind takes unit hero returns RoboButler 
        local Table t = Timeout.start(0.04, true, function move) 
        local RoboButler butler = RoboButler.create(hero) 
        call t.save(BUTLER_KEY, butler) 
        return butler 
    endfunction 
endlibrary 
