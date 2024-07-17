if Debug then Debug.beginFile "Game/Abilities/Suits/DeterministricInvigoration" end
OnInit.trig("DeterministricInvigoration", function(require)
    ---@return boolean
    function Trig_Deterministic_Invigoration_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A09Q'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Deterministic_Invigoration_Func005Func003C()
        if (not (udg_TempUnit ~= udg_TempUnit2)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Deterministic_Invigoration_Func005Func007C()
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h02O'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h016'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h014'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h011'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h012'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h049'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h017'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h04S'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h00G'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h03Z'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h023'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h019'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h00O'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h00P'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h00Q'))) then
            return true
        end
        if ((GetUnitTypeId(udg_TempUnit2) == FourCC('h00R'))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_Deterministic_Invigoration_Func005C()
        if (not Trig_Deterministic_Invigoration_Func005Func007C()) then
            return false
        end
        return true
    end

    function Trig_Deterministic_Invigoration_Actions()
        udg_TempUnit = GetTriggerUnit()
        udg_TempUnit2 = GetSpellTargetUnit()
        if (Trig_Deterministic_Invigoration_Func005C()) then
        else
            UnitAddAbilityBJ(FourCC('A0A0'), udg_TempUnit)
            -- If casted on an ally
            if (Trig_Deterministic_Invigoration_Func005Func003C()) then
                -- Add buffs to target
                UnitAddAbilityBJ(FourCC('A09W'), udg_TempUnit2)
                UnitAddAbilityBJ(FourCC('A09V'), udg_TempUnit2)
            else
            end
            udg_GuardInvigorationSelf[GetConvertedPlayerId(GetOwningPlayer(udg_TempUnit))] = udg_TempUnit
            udg_GuardInvigorationAlly[GetConvertedPlayerId(GetOwningPlayer(udg_TempUnit))] = udg_TempUnit2
            StartTimerBJ(udg_GuardInvigorationExpiration[GetConvertedPlayerId(GetOwningPlayer(udg_TempUnit))], false,
                8.00)
        end
    end

    --===========================================================================
    gg_trg_Deterministic_Invigoration = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Deterministic_Invigoration, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Deterministic_Invigoration, Condition(Trig_Deterministic_Invigoration_Conditions))
    TriggerAddAction(gg_trg_Deterministic_Invigoration, Trig_Deterministic_Invigoration_Actions)
end)
if Debug then Debug.endFile() end
