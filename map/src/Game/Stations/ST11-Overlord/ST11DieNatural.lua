if Debug then Debug.beginFile "Game/Stations/ST11/ST11DieNeutral" end
OnInit.trig("ST11DieNeutral", function(require)
    ---@return boolean
    function Trig_ST11DieNatural_Conditions()
        if (not (GetUnitTypeId(GetDyingUnit()) == FourCC('h04G'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ST11DieNatural_Func006Func002Func001Func003C()
        if ((GetUnitTypeId(GetEnumUnit()) == FourCC('h002'))) then
            return true
        end
        if ((GetUnitTypeId(GetEnumUnit()) == FourCC('h02L'))) then
            return true
        end
        if ((GetUnitTypeId(GetEnumUnit()) == FourCC('h02H'))) then
            return true
        end
        if ((GetUnitTypeId(GetEnumUnit()) == FourCC('h02Q'))) then
            return true
        end
        if ((GetUnitTypeId(GetEnumUnit()) == FourCC('h03J'))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_ST11DieNatural_Func006Func002Func001C()
        if (not Trig_ST11DieNatural_Func006Func002Func001Func003C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ST11DieNatural_Func006Func002C()
        if (not (GetUnitTypeId(GetEnumUnit()) ~= FourCC('h04G'))) then
            return false
        end
        return true
    end

    function Trig_ST11DieNatural_Func006A()
        -- If not equal to space overlord unit, then change ownership
        if (Trig_ST11DieNatural_Func006Func002C()) then
            if (Trig_ST11DieNatural_Func006Func002Func001C()) then
                SetUnitOwner(GetEnumUnit(), Player(PLAYER_NEUTRAL_PASSIVE), false)
            else
                SetUnitOwner(GetEnumUnit(), Player(PLAYER_NEUTRAL_AGGRESSIVE), false)
            end
        else
        end
    end

    function Trig_ST11DieNatural_Func011A()
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_MASKED, gg_rct_OverlordRect)
    end

    function Trig_ST11DieNatural_Func012A()
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
    end

    function Trig_ST11DieNatural_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        -- NewStuff
        udg_TempUnitGroup = GetUnitsOfPlayerAll(udg_Mutant)
        ForGroupBJ(udg_TempUnitGroup, Trig_ST11DieNatural_Func006A)
        DestroyGroup(udg_TempUnitGroup)
        SetUnitOwner(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)], udg_Mutant, false)
        -- NewStuff
        KillUnit(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)])
        ForForce(GetPlayersAll(), Trig_ST11DieNatural_Func011A)
        ForGroupBJ(GetUnitsInRectAll(gg_rct_OverlordRect), Trig_ST11DieNatural_Func012A)
        RectOfDoom(gg_rct_OverlordRect)
    end

    --===========================================================================
    gg_trg_ST11DieNatural = CreateTrigger()
    DisableTrigger(gg_trg_ST11DieNatural)
    TriggerRegisterAnyUnitEventBJ(gg_trg_ST11DieNatural, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_ST11DieNatural, Condition(Trig_ST11DieNatural_Conditions))
    TriggerAddAction(gg_trg_ST11DieNatural, Trig_ST11DieNatural_Actions)
end)
if Debug then Debug.endFile() end
