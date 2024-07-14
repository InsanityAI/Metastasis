function Trig_MoonDamage_Func003A takes nothing returns nothing
    call UnitDamageTargetBJ( gg_unit_h03T_0209, GetEnumUnit(), 5.00, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL )
endfunction

function Trig_MoonDamage_Actions takes nothing returns nothing
    set udg_TempUnitGroup = GetUnitsInRectAll(gg_rct_MoonRect)
    call ForGroupBJ( udg_TempUnitGroup, function Trig_MoonDamage_Func003A )
        call DestroyGroup( udg_TempUnitGroup )
endfunction

//===========================================================================
function InitTrig_MoonDamage takes nothing returns nothing
    set gg_trg_MoonDamage = CreateTrigger(  )
    call TriggerRegisterTimerExpireEventBJ( gg_trg_MoonDamage, udg_MoonDamageTimer )
    call TriggerAddAction( gg_trg_MoonDamage, function Trig_MoonDamage_Actions )
endfunction

