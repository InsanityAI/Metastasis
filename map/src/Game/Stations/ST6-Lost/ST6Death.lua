if Debug then Debug.beginFile "Game/Stations/ST6/ST6Death" end
OnInit.map("ST6Death", function(require)
    function Trig_ST6Death_Func001A()
        UnitAddAbilityBJ(FourCC('A02T'), GetEnumUnit())
        UnitRemoveBuffsBJ(bj_REMOVEBUFFS_ALL, GetEnumUnit())
        UnitRemoveAbilityBJ(FourCC('A04T'), GetEnumUnit())
        UnitRemoveAbilityBJ(FourCC('A04U'), GetEnumUnit())
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 6
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            RemoveItem(UnitItemInSlotBJ(GetEnumUnit(), GetForLoopIndexA()))
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        MoogleKillUnit(GetEnumUnit(), GetKillingUnit())
        udg_TempPoint = GetUnitLoc(GetEnumUnit())
        CreateNUnitsAtLoc(1, FourCC('e001'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING)
        SetUnitAnimation(GetLastCreatedUnit(), "death")
        RemoveLocation(udg_TempPoint)
    end

    function Trig_ST6Death_Func002A()
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_MASKED, gg_rct_LostStation)
    end

    function Trig_ST6Death_Actions()
        ForGroupBJ(GetUnitsInRectAll(gg_rct_LostStation), Trig_ST6Death_Func001A)
        ForForce(GetPlayersAll(), Trig_ST6Death_Func002A)
        RectOfDoom(gg_rct_LostStation)
    end

    --===========================================================================
    gg_trg_ST6Death = CreateTrigger()
    TriggerAddAction(gg_trg_ST6Death, Trig_ST6Death_Actions)
end)
if Debug then Debug.endFile() end
