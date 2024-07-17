if Debug then Debug.beginFile "Game/Stations/Moon/MoonDamage" end
OnInit.map("MoonDamage", function(require)
    function Trig_MoonDamage_Func003A()
        UnitDamageTargetBJ(gg_unit_h03T_0209, GetEnumUnit(), 5.00, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL)
    end

    function Trig_MoonDamage_Actions()
        udg_TempUnitGroup = GetUnitsInRectAll(gg_rct_MoonRect)
        ForGroupBJ(udg_TempUnitGroup, Trig_MoonDamage_Func003A)
        DestroyGroup(udg_TempUnitGroup)
    end

    --===========================================================================
    gg_trg_MoonDamage = CreateTrigger()
    TriggerRegisterTimerExpireEventBJ(gg_trg_MoonDamage, udg_MoonDamageTimer)
    TriggerAddAction(gg_trg_MoonDamage, Trig_MoonDamage_Actions)
end)
if Debug then Debug.endFile() end
