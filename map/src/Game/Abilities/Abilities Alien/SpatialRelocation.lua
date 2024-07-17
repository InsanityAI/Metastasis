if Debug then Debug.beginFile "Game/Abilities/Alien/SpatialRelocation" end
OnInit.trig("SpatialRelocation", function(require)
    ---@return boolean
    function Trig_SpatialRelocation_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A03C'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SpatialRelocation_Func015C()
        if (not (GetOwningPlayer(GetSpellAbilityUnit()) == Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return false
        end
        return true
    end

    function Trig_SpatialRelocation_Actions()
        udg_TempUnit3 = GetSpellAbilityUnit()
        SetUnitScalePercent(GetSpellAbilityUnit(), 25.00, 25.00, 25.00)
        udg_TempPoint = GetRandomLocInRect(gg_rct_Space)
        udg_TempPoint2 = GetUnitLoc(GetSpellAbilityUnit())
        AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl")
        SFXThreadClean()
        AddSpecialEffectLocBJ(udg_TempPoint2, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl")
        SFXThreadClean()
        SetUnitPositionLoc(GetSpellAbilityUnit(), udg_TempPoint2)
        UnitAddTypeBJ(UNIT_TYPE_FLYING, GetSpellAbilityUnit())
        SetUnitPositionLoc(GetSpellAbilityUnit(), udg_TempPoint)
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 6
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            udg_TempItem = UnitItemInSlotBJ(GetSpellAbilityUnit(), GetForLoopIndexA())
            SetItemVisibleBJ(false, udg_TempItem)
            SetItemPositionLoc(udg_TempItem, udg_HoldZone)
            SaveItemHandle(LS(), GetHandleId(GetSpellAbilityUnit()), StringHash("ihold" .. I2S(bj_forLoopAIndex)),
                udg_TempItem)
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        if (Trig_SpatialRelocation_Func015C()) then
            PanCameraToTimedLocForPlayer(udg_Parasite, udg_TempPoint, 0)
        else
            PanCameraToTimedLocForPlayer(GetOwningPlayer(GetSpellAbilityUnit()), udg_TempPoint, 0)
        end
        RemoveLocation(udg_TempPoint)
        RemoveLocation(udg_TempPoint2)
        udg_TempUnitType = FourCC('e00M')
        udg_TempPlayer = GetOwningPlayer(GetSpellAbilityUnit())
        ExecuteFunc("AlienRequirementRemove")
        SetUnitMoveSpeed(GetSpellAbilityUnit(), (GetUnitDefaultMoveSpeed(GetSpellAbilityUnit()) / 2.00))
        UnitAddAbilityBJ(FourCC('A03B'), udg_TempUnit3)
        UnitAddAbilityBJ(FourCC('A03H'), udg_TempUnit3)
        UnitAddAbilityBJ(FourCC('A03G'), udg_TempUnit3)
        UnitRemoveAbilityBJ(FourCC('A03I'), udg_TempUnit3)
        UnitRemoveAbilityBJ(FourCC('A02S'), udg_TempUnit3)
        UnitRemoveAbilityBJ(FourCC('A02X'), udg_TempUnit3)
        UnitRemoveAbilityBJ(FourCC('A03C'), udg_TempUnit3)
    end

    --===========================================================================
    gg_trg_SpatialRelocation = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_SpatialRelocation, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_SpatialRelocation, Condition(Trig_SpatialRelocation_Conditions))
    TriggerAddAction(gg_trg_SpatialRelocation, Trig_SpatialRelocation_Actions)
end)
if Debug then Debug.endFile() end
