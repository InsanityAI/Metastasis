library ProxyKill requires SFXLib, Timeout
    globals
        private unit globalKiller
    endglobals

    private function PermaDeathDelayedKill takes nothing returns nothing
        local Table timerData = Timeout.complete()
        call KillUnit(timerData.unit[0])
    endfunction

    public function PermanentDeath takes unit killer, unit victim returns nothing 
        local Table timerData = Timeout.start(0.01, false, function PermaDeathDelayedKill)
        local integer i = 5 
        call ShowUnit(victim, true)
        call UnitRemoveBuffs(victim, true, true) 
        call UnitAddAbility(victim, 'A02T') //AndStayDead 
        call UnitRemoveAbility(victim, 'A04T') //Alien regen core 
        call UnitRemoveAbility(victim, 'A04U') //Spawn regen core 
        call SetUnitInvulnerable(victim, false)
        call SetUnitState(victim, UNIT_STATE_LIFE, 1.00)
        call UnitDamageTarget(killer, victim, 421337, true, false, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
        loop 
            exitwhen i < 0 
            call RemoveItem(UnitItemInSlot(victim, i)) 
            set i = i - 1 
        endloop 
        call SFXLib_UnitExplode(victim)
        set timerData.unit[0] = victim
    endfunction 

    private function PermanentDeathAtRectEnum takes nothing returns nothing
        call PermanentDeath(globalKiller, GetEnumUnit())
    endfunction

    public function PermanentDeathAtRect takes unit killer, rect areaOfDeath returns nothing
        local group thisGroup = CreateGroup()
        call GroupEnumUnitsInRect(thisGroup, areaOfDeath, null)
        set globalKiller = killer
        call ForGroup(thisGroup, function PermanentDeathAtRectEnum)
        call DestroyGroup(thisGroup)
        set thisGroup = null
    endfunction
endlibrary