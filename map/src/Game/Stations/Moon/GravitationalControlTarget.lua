if Debug then Debug.beginFile "Game/Stations/Moon/GravitationalControlTarget" end
OnInit.map("GravitationalControlTarget", function(require)
    ---@return boolean
    function Trig_GravitationalControlTarget_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A02V'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_GravitationalControlTarget_Func004Func001C()
        if ((RectContainsLoc(gg_rct_Space, udg_TempPoint) == false)) then
            return true
        end
        if ((IsUnitIdType(GetUnitTypeId(GetSpellTargetUnit()), UNIT_TYPE_STRUCTURE) == true)) then
            return true
        end
        if ((GetSpellTargetUnit() == gg_unit_h03T_0209)) then
            return true
        end
        if ((GetSpellTargetUnit() == gg_unit_h008_0196)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_GravitationalControlTarget_Func004C()
        if (not Trig_GravitationalControlTarget_Func004Func001C()) then
            return false
        end
        return true
    end

    function Trig_GravitationalControlTarget_Actions()
        udg_TempPoint = GetUnitLoc(GetSpellTargetUnit())
        if (Trig_GravitationalControlTarget_Func004C()) then
            DisplayTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0, "|cffFF0000ERROR: Invalid target.|r")
            IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop")
            ForceUIKeyBJ(GetOwningPlayer(GetSpellAbilityUnit()), "J")
            RemoveLocation(udg_TempPoint)
            return
        else
        end
        udg_GravitationalControl_Target = GetSpellTargetUnit()
        ForceUIKeyBJ(GetOwningPlayer(GetSpellAbilityUnit()), "K")
        DisplayTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0,
            "|cff00FF00Target accepted. Select correction angle.|r")
    end

    --===========================================================================
    gg_trg_GravitationalControlTarget = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_GravitationalControlTarget, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_GravitationalControlTarget, Condition(Trig_GravitationalControlTarget_Conditions))
    TriggerAddAction(gg_trg_GravitationalControlTarget, Trig_GravitationalControlTarget_Actions)
end)
if Debug then Debug.endFile() end
