if Debug then Debug.beginFile "Game/Suits/SuitsDrop" end
OnInit.map("SuitsDrop", function(require)
    ---@return boolean
    function Trig_SuitsDrop_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A0AF'))) then
            return false
        end
        if (not (udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] == GetTriggerUnit())) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SuitsDrop_Func013C()
        if (not (GetUnitTypeId(udg_TempUnit) == FourCC('h04K'))) then
            return false
        end
        return true
    end

    function Trig_SuitsDrop_Actions()
        udg_TempUnit = GetSpellAbilityUnit()
        udg_TempItem = udg_Player_Suit[GetConvertedPlayerId(GetOwningPlayer(udg_TempUnit))]
        udg_TempReal = GetUnitLifePercent(udg_TempUnit)
        SetItemUserData(udg_TempItem, 0)
        SetItemVisibleBJ(true, udg_TempItem)
        udg_TempPoint = GetUnitLoc(udg_TempUnit)
        SetItemPositionLoc(udg_TempItem, udg_TempPoint)
        RemoveLocation(udg_TempPoint)
        UnitAddItemSwapped(udg_TempItem, udg_TempUnit)
        if (Trig_SuitsDrop_Func013C()) then
            if HaveSavedHandle(LS(), GetHandleId(udg_TempUnit), StringHash("Suit_SlivGroup")) then
                DestroyGroup(LoadGroupHandle(LS(), GetHandleId(udg_TempUnit), StringHash("Suit_SlivGroup")))
            end
        else
        end
        UnitAddAbilityBJ(FourCC('S001'), udg_TempUnit)
        SetUnitAbilityLevelSwapped(FourCC('S001'), udg_TempUnit, 1)
        SetUnitLifePercentBJ(udg_TempUnit, udg_TempReal)
        udg_TempUnit = GetSpellAbilityUnit()
        ExecuteFunc("SuitRoleAbilityReAdd")
    end

    --===========================================================================
    gg_trg_SuitsDrop = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_SuitsDrop, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_SuitsDrop, Condition(Trig_SuitsDrop_Conditions))
    TriggerAddAction(gg_trg_SuitsDrop, Trig_SuitsDrop_Actions)
end)
if Debug then Debug.endFile() end
