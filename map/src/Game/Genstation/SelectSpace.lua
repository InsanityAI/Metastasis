if Debug then Debug.beginFile "Libraries/Genstation/SelectSpace" end
OnInit.triggggg("Libraries/Genstation/SelectSpace", function()
    ---@return boolean
    function Trig_SelectSpace_Func001C()
        if ((GetSpellAbilityId() == FourCC('A073'))) then
            return true
        end
        if ((GetSpellAbilityId() == FourCC('A085'))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_SelectSpace_Conditions()
        if (not Trig_SelectSpace_Func001C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SelectSpace_Func005C()
        if (not (GetOwningPlayer(GetSpellAbilityUnit()) == Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return false
        end
        return true
    end

    function Trig_SelectSpace_Actions()
        udg_TempUnit = LoadUnitHandle(LS(), GetHandleId(GetSpellAbilityUnit()), StringHash("space"))
        udg_TempPoint = GetUnitLoc(udg_TempUnit)
        if (Trig_SelectSpace_Func005C()) then
            PanCameraToTimedLocForPlayer(udg_Parasite, udg_TempPoint, 0)
            SelectUnitForPlayerSingle(udg_TempUnit, udg_Parasite)
        else
            PanCameraToTimedLocForPlayer(GetOwningPlayer(GetSpellAbilityUnit()), udg_TempPoint, 0)
            SelectUnitForPlayerSingle(udg_TempUnit, GetOwningPlayer(GetSpellAbilityUnit()))
        end
        RemoveLocation(udg_TempPoint)
    end

    gg_trg_SelectSpace = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_SelectSpace, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_SelectSpace, Condition(Trig_SelectSpace_Conditions))
    TriggerAddAction(gg_trg_SelectSpace, Trig_SelectSpace_Actions)
end)
if Debug then Debug.endFile() end
