if Debug then Debug.beginFile "Game/Abilities/Alien/AlienBoard" end
OnInit.trig("AlienBoard", function(require)
    ---@return boolean
    function Trig_AlienBoard_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A03B'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AlienBoard_Func004Func001Func002Func001Func001Func001Func001Func001Func001Func001Func001Func001C()
        if (not (GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h03T'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AlienBoard_Func004Func001Func002Func001Func001Func001Func001Func001Func001Func001Func001C()
        if (not (GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h04G'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AlienBoard_Func004Func001Func002Func001Func001Func001Func001Func001Func001Func001C()
        if (not (GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h029'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AlienBoard_Func004Func001Func002Func001Func001Func001Func001Func001Func001C()
        if (not (GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h009'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AlienBoard_Func004Func001Func002Func001Func001Func001Func001Func001C()
        if (not (GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h003'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AlienBoard_Func004Func001Func002Func001Func001Func001Func001C()
        if (not (GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h008'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AlienBoard_Func004Func001Func002Func001Func001Func001C()
        if (not (GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h007'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AlienBoard_Func004Func001Func002Func001Func001C()
        if (not (GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h005'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AlienBoard_Func004Func001Func002Func001C()
        if (not (GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h00X'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AlienBoard_Func004Func001Func002C()
        if (not (GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h02B'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AlienBoard_Func004Func001Func003C()
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h04G'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h02B'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h00X'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h005'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h007'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h008'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h03T'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h003'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h009'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h029'))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_AlienBoard_Func004Func001C()
        if (not Trig_AlienBoard_Func004Func001Func003C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AlienBoard_Func004Func002C()
        if IsUnitExplorer(GetSpellTargetUnit()) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_AlienBoard_Func004C()
        if (not Trig_AlienBoard_Func004Func002C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AlienBoard_Func011C()
        if (not (GetOwningPlayer(udg_TempUnit3) == Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AlienBoard_Func014C()
        if (not (GetOwningPlayer(udg_TempUnit3) == Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return false
        end
        return true
    end

    function Trig_AlienBoard_Actions()
        udg_TempUnit3 = GetSpellAbilityUnit()
        if (Trig_AlienBoard_Func004C()) then
            udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
            udg_TempPoint2 = GetRectCenter(udg_Spaceship_EnterExit
                [GetUnitUserData(udg_SS_Landed[GetUnitUserData(GetSpellTargetUnit())])])
        else
            if (Trig_AlienBoard_Func004Func001C()) then
                if (Trig_AlienBoard_Func004Func001Func002C()) then
                    udg_TempPoint2 = GetRectCenter(gg_rct_PirateABEnter)
                else
                    if (Trig_AlienBoard_Func004Func001Func002Func001C()) then
                        udg_TempPoint2 = GetRectCenter(gg_rct_ST5EscapePod)
                    else
                        if (Trig_AlienBoard_Func004Func001Func002Func001Func001C()) then
                            udg_TempPoint2 = GetRectCenter(gg_rct_ST2)
                        else
                            if (Trig_AlienBoard_Func004Func001Func002Func001Func001Func001C()) then
                                udg_TempPoint2 = GetRectCenter(gg_rct_ST3EscapePod)
                            else
                                if (Trig_AlienBoard_Func004Func001Func002Func001Func001Func001Func001C()) then
                                    udg_TempPoint2 = GetRectCenter(gg_rct_PlanetEscapePod)
                                else
                                    if (Trig_AlienBoard_Func004Func001Func002Func001Func001Func001Func001Func001C()) then
                                        udg_TempPoint2 = GetRectCenter(gg_rct_ST1EscapePod)
                                    else
                                        if (Trig_AlienBoard_Func004Func001Func002Func001Func001Func001Func001Func001Func001C()) then
                                            udg_TempPoint2 = GetRectCenter(gg_rct_ST4EscapePod)
                                        else
                                            if (Trig_AlienBoard_Func004Func001Func002Func001Func001Func001Func001Func001Func001Func001C()) then
                                                udg_TempPoint2 = GetRectCenter(gg_rct_LostStation)
                                            else
                                                if (Trig_AlienBoard_Func004Func001Func002Func001Func001Func001Func001Func001Func001Func001Func001C()) then
                                                    udg_TempPoint2 = GetRectCenter(gg_rct_OverlordPod)
                                                else
                                                    if (Trig_AlienBoard_Func004Func001Func002Func001Func001Func001Func001Func001Func001Func001Func001Func001C()) then
                                                        udg_TempPoint2 = GetRectCenter(gg_rct_MoonEscapePod)
                                                    else
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
            else
                return
            end
        end
        AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl")
        SFXThreadClean()
        AddSpecialEffectLocBJ(udg_TempPoint2, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl")
        SFXThreadClean()
        SetUnitPositionLoc(udg_TempUnit3, udg_TempPoint2)
        UnitRemoveTypeBJ(UNIT_TYPE_FLYING, udg_TempUnit3)
        if (Trig_AlienBoard_Func011C()) then
            PanCameraToTimedLocForPlayer(udg_Parasite, udg_TempPoint2, 0)
        else
            PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_TempUnit3), udg_TempPoint2, 0)
        end
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 6
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            udg_TempItem = LoadItemHandle(LS(), GetHandleId(udg_TempUnit3), StringHash("ihold" .. I2S(bj_forLoopAIndex)))
            SetItemVisibleBJ(true, udg_TempItem)
            UnitAddItemSwapped(udg_TempItem, udg_TempUnit3)
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        SetUnitMoveSpeed(udg_TempUnit3, (GetUnitDefaultMoveSpeed(udg_TempUnit3) / 1.00))
        if (Trig_AlienBoard_Func014C()) then
            UnitAddAbilityBJ(FourCC('A02S'), udg_TempUnit3)
            UnitAddAbilityBJ(FourCC('A03I'), udg_TempUnit3)
            SetUnitScalePercent(udg_TempUnit3, 100.00, 100.00, 100.00)
        else
            UnitAddAbilityBJ(FourCC('A02X'), udg_TempUnit3)
            SetUnitScalePercent(udg_TempUnit3, 85.00, 85.00, 85.00)
        end
        UnitAddAbilityBJ(FourCC('A03C'), udg_TempUnit3)
        UnitAddAbilityBJ(FourCC('AInv'), udg_TempUnit3)
        UnitRemoveAbilityBJ(FourCC('A03B'), udg_TempUnit3)
        UnitRemoveAbilityBJ(FourCC('A03H'), udg_TempUnit3)
        UnitRemoveAbilityBJ(FourCC('A03G'), udg_TempUnit3)
        udg_TempUnitType = FourCC('e00M')
        udg_TempPlayer = GetOwningPlayer(udg_TempUnit3)
        udg_TempReal = 60.00
        ExecuteFunc("AlienRequirementRestore")
        UnitAddAbilityForPeriod(udg_TempUnit3, FourCC('Avul'), 3.0)
    end

    --===========================================================================
    gg_trg_AlienBoard = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_AlienBoard, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_AlienBoard, Condition(Trig_AlienBoard_Conditions))
    TriggerAddAction(gg_trg_AlienBoard, Trig_AlienBoard_Actions)
end)
if Debug then Debug.endFile() end
