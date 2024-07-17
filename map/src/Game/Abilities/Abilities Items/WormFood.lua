if Debug then Debug.beginFile "Game/Abilities/Items/WormFood" end
OnInit.trig("WormFood", function(require)
    ---@return boolean
    function Trig_WormFood_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A03W'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_WormFood_Func003Func001Func001Func001C()
        if (not (GetOwningPlayer(GetSpellAbilityUnit()) == GetOwningPlayer(gg_unit_n006_0218))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_WormFood_Func003Func001Func001C()
        if (not (GetUnitTypeId(GetSpellTargetUnit()) == FourCC('n006'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_WormFood_Func003Func001C()
        if (not (GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h02E'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_WormFood_Func003C()
        if (not (GetUnitTypeId(GetSpellTargetUnit()) == FourCC('n003'))) then
            return false
        end
        if (not (GetOwningPlayer(GetSpellTargetUnit()) == Player(PLAYER_NEUTRAL_PASSIVE))) then
            return false
        end
        return true
    end

    function Trig_WormFood_Actions()
        if (Trig_WormFood_Func003C()) then
            SetUnitOwner(GetSpellTargetUnit(), GetOwningPlayer(GetSpellAbilityUnit()), true)
            IssueTargetOrderBJ(GetSpellTargetUnit(), "move", GetSpellAbilityUnit())
        else
            if (Trig_WormFood_Func003Func001C()) then
                SetUnitOwner(GetSpellTargetUnit(), GetOwningPlayer(GetSpellAbilityUnit()), true)
                IssueTargetOrderBJ(GetSpellTargetUnit(), "move", GetSpellAbilityUnit())
                UnitApplyTimedLife(GetSpellTargetUnit(), FourCC('Broa'), 25)
            else
                if (Trig_WormFood_Func003Func001Func001C()) then
                    if (Trig_WormFood_Func003Func001Func001Func001C()) then
                        udg_TempPoint = GetUnitLoc(GetSpellTargetUnit())
                        CreateTextTagLocBJ("TRIGSTR_5372", udg_TempPoint, 0, 10, 100, 100, 100, 0)
                        ShowTextTagForceBJ(true, GetLastCreatedTextTag(), GetPlayersAll())
                        SetTextTagVelocityBJ(GetLastCreatedTextTag(), 32.00, 90)
                        SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
                        SetTextTagLifespanBJ(GetLastCreatedTextTag(), 7.00)
                        SetTextTagFadepointBJ(GetLastCreatedTextTag(), 5.00)
                        RemoveLocation(udg_TempPoint)
                        SetUnitOwner(GetSpellTargetUnit(), GetOwningPlayer(GetSpellAbilityUnit()), true)
                        IssueTargetOrderBJ(GetSpellTargetUnit(), "move", GetSpellAbilityUnit())
                    else
                        udg_TempPoint = GetUnitLoc(GetSpellTargetUnit())
                        CreateTextTagLocBJ("TRIGSTR_5373", udg_TempPoint, 0, 10, 100, 100, 100, 0)
                        ShowTextTagForceBJ(true, GetLastCreatedTextTag(), GetPlayersAll())
                        SetTextTagVelocityBJ(GetLastCreatedTextTag(), 32.00, 90)
                        SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
                        SetTextTagLifespanBJ(GetLastCreatedTextTag(), 7.00)
                        SetTextTagFadepointBJ(GetLastCreatedTextTag(), 5.00)
                        RemoveLocation(udg_TempPoint)
                        SetUnitOwner(GetSpellTargetUnit(), GetOwningPlayer(GetSpellAbilityUnit()), true)
                        IssueTargetOrderBJ(GetSpellTargetUnit(), "move", GetSpellAbilityUnit())
                    end
                else
                end
            end
        end
    end

    --===========================================================================
    gg_trg_WormFood = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_WormFood, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_WormFood, Condition(Trig_WormFood_Conditions))
    TriggerAddAction(gg_trg_WormFood, Trig_WormFood_Actions)
end)
if Debug then Debug.endFile() end
