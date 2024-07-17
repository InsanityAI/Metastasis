if Debug then Debug.beginFile "Game/Stations/Planet/SnoeglayDeath" end
OnInit.map("SnoeglayDeath", function(require)
    ---@return boolean
    function Trig_Snoeglay_Death_Func001C()
        if ((GetUnitTypeId(GetDyingUnit()) == FourCC('n003'))) then
            return true
        end
        if ((GetUnitTypeId(GetDyingUnit()) == FourCC('h02E'))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_Snoeglay_Death_Conditions()
        if (not Trig_Snoeglay_Death_Func001C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Snoeglay_Death_Func003C()
        if (not (GetOwningPlayer(GetKillingUnitBJ()) == Player(PLAYER_NEUTRAL_AGGRESSIVE))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Snoeglay_Death_Func004C()
        if (not (udg_DeadSnoeglays == 15)) then
            return false
        end
        if (not (GetOwningPlayer(GetKillingUnitBJ()) ~= Player(PLAYER_NEUTRAL_AGGRESSIVE))) then
            return false
        end
        if (not (GetRandomInt(1, 2) == 1)) then
            return false
        end
        return true
    end

    function Trig_Snoeglay_Death_Actions()
        if (Trig_Snoeglay_Death_Func003C()) then
            udg_TempPoint = GetRandomLocInRect(gg_rct_Planet)
            CreateNUnitsAtLoc(1, FourCC('n003'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING)
            RemoveLocation(udg_TempPoint)
        else
            udg_DeadSnoeglays = (udg_DeadSnoeglays + 1)
        end
        if (Trig_Snoeglay_Death_Func004C()) then
            udg_TempPoint = GetUnitLoc(GetDyingUnit())
            AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosTarget.mdl")
            SFXThreadClean()
            CreateNUnitsAtLoc(1, FourCC('n005'), Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING)
            UnitAddAbilityBJ(FourCC('Arav'), GetLastCreatedUnit())
            SetUnitFlyHeightBJ(GetLastCreatedUnit(), 2000.00, 0.00)
            SetUnitFlyHeightBJ(GetLastCreatedUnit(), 0.00, 1000.00)
            RemoveLocation(udg_TempPoint)
            DestroyTrigger(GetTriggeringTrigger())
        else
            DoNothing()
        end
    end

    --===========================================================================
    gg_trg_Snoeglay_Death = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Snoeglay_Death, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Snoeglay_Death, Condition(Trig_Snoeglay_Death_Conditions))
    TriggerAddAction(gg_trg_Snoeglay_Death, Trig_Snoeglay_Death_Actions)
end)
if Debug then Debug.endFile() end
