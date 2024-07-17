if Debug then Debug.beginFile "Game/Misc/SlugglyShip" end
OnInit.trig("SlugglyShip", function(require)
    ---@return boolean
    function Trig_Slugglyship_Func002Func001Func001C()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I018'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Slugglyship_Func002Func001C()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I015'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Slugglyship_Func002C()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I013'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Slugglyship_Func003C()
        if (not (GetItemLevel(GetManipulatedItem()) == 7)) then
            return false
        end
        return true
    end

    function Trig_Slugglyship_Actions()
        if (Trig_Slugglyship_Func002C()) then
            udg_TempPoint = GetUnitLoc(GetManipulatingUnit())
            CreateTextTagLocBJ("TRIGSTR_2323", udg_TempPoint, 0, 10, 100, 100, 100, 0)
            ShowTextTagForceBJ(true, GetLastCreatedTextTag(), GetPlayersAll())
            SetTextTagVelocityBJ(GetLastCreatedTextTag(), 32.00, 90)
            SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
            SetTextTagLifespanBJ(GetLastCreatedTextTag(), 7.00)
            SetTextTagFadepointBJ(GetLastCreatedTextTag(), 5.00)
            RemoveLocation(udg_TempPoint)
            return
        else
            if (Trig_Slugglyship_Func002Func001C()) then
                udg_TempPoint = GetUnitLoc(GetManipulatingUnit())
                CreateTextTagLocBJ("TRIGSTR_2343", udg_TempPoint, 0, 10, 100, 100, 100, 0)
                ShowTextTagForceBJ(true, GetLastCreatedTextTag(), GetPlayersAll())
                SetTextTagVelocityBJ(GetLastCreatedTextTag(), 32.00, 90)
                SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
                SetTextTagLifespanBJ(GetLastCreatedTextTag(), 7.00)
                SetTextTagFadepointBJ(GetLastCreatedTextTag(), 5.00)
                RemoveLocation(udg_TempPoint)
                UnitRemoveItemSwapped(GetManipulatedItem(), gg_unit_n006_0218)
                return
            else
                if (Trig_Slugglyship_Func002Func001Func001C()) then
                    DestroyTrigger(GetTriggeringTrigger())
                    udg_TempPoint = GetUnitLoc(GetManipulatingUnit())
                    CreateTextTagLocBJ("TRIGSTR_2340", udg_TempPoint, 0, 10, 100, 100, 100, 0)
                    ShowTextTagForceBJ(true, GetLastCreatedTextTag(), GetPlayersAll())
                    SetTextTagVelocityBJ(GetLastCreatedTextTag(), 32.00, 90)
                    SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
                    SetTextTagLifespanBJ(GetLastCreatedTextTag(), 7.00)
                    SetTextTagFadepointBJ(GetLastCreatedTextTag(), 5.00)
                    RemoveLocation(udg_TempPoint)
                    PolledWait(7.00)
                    udg_TempPoint = GetUnitLoc(gg_unit_n006_0218)
                    CreateTextTagLocBJ("TRIGSTR_2341", udg_TempPoint, 0, 10, 100, 100, 100, 0)
                    ShowTextTagForceBJ(true, GetLastCreatedTextTag(), GetPlayersAll())
                    SetTextTagVelocityBJ(GetLastCreatedTextTag(), 32.00, 90)
                    SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
                    SetTextTagLifespanBJ(GetLastCreatedTextTag(), 7.00)
                    SetTextTagFadepointBJ(GetLastCreatedTextTag(), 5.00)
                    AddSpecialEffectLocBJ(udg_TempPoint, "war3mapImported\\AncientExplode.mdx")
                    SFXThreadClean()
                    RemoveLocation(udg_TempPoint)
                    PolledWait(4.00)
                    SetUnitPositionLoc(gg_unit_h03J_0180, GetRandomLocInRect(gg_rct_Space))
                    udg_TempPoint = GetUnitLoc(gg_unit_n006_0218)
                    CreateTextTagLocBJ("TRIGSTR_2342", udg_TempPoint, 0, 10, 100, 100, 100, 0)
                    ShowTextTagForceBJ(true, GetLastCreatedTextTag(), GetPlayersAll())
                    SetTextTagVelocityBJ(GetLastCreatedTextTag(), 32.00, 90)
                    SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
                    SetTextTagLifespanBJ(GetLastCreatedTextTag(), 7.00)
                    SetTextTagFadepointBJ(GetLastCreatedTextTag(), 5.00)
                    AddSpecialEffectLocBJ(udg_TempPoint, "war3mapImported\\AncientExplode.mdx")
                    CreateNUnitsAtLoc(12, FourCC('nshe'), Player(PLAYER_NEUTRAL_PASSIVE), GetRectCenter(gg_rct_SS13),
                        bj_UNIT_FACING)
                    SFXThreadClean()
                    RemoveLocation(udg_TempPoint)
                    udg_TempUnit = gg_unit_h03K_0181
                    udg_TempUnit2 = gg_unit_h03J_0180
                    udg_TempUnit3 = gg_unit_h004_0179
                    udg_TempRect = gg_rct_SS13
                    udg_TempRect2 = gg_rct_SS13EE
                    udg_TempRect3 = gg_rct_SS13Control
                    udg_SS_Harbor[GetUnitUserData(gg_unit_h03K_0181)] = nil
                    udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h03K_0181)] = 0
                    Spaceship_Build(udg_TempUnit, udg_TempUnit2, udg_TempUnit3, udg_TempRect, udg_TempRect2,
                        udg_TempRect3, 26)
                    return
                else
                end
            end
        end
        if (Trig_Slugglyship_Func003C()) then
            udg_TempPoint = GetUnitLoc(GetManipulatingUnit())
            CreateTextTagLocBJ("TRIGSTR_2321", udg_TempPoint, 0, 10, 100, 100, 100, 0)
            ShowTextTagForceBJ(true, GetLastCreatedTextTag(), GetPlayersAll())
            SetTextTagVelocityBJ(GetLastCreatedTextTag(), 32.00, 90)
            SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
            SetTextTagLifespanBJ(GetLastCreatedTextTag(), 7.00)
            SetTextTagFadepointBJ(GetLastCreatedTextTag(), 5.00)
            RemoveLocation(udg_TempPoint)
        else
            udg_TempPoint = GetUnitLoc(GetManipulatingUnit())
            CreateTextTagLocBJ("TRIGSTR_2322", udg_TempPoint, 0, 10, 100, 100, 100, 0)
            ShowTextTagForceBJ(true, GetLastCreatedTextTag(), GetPlayersAll())
            SetTextTagVelocityBJ(GetLastCreatedTextTag(), 32.00, 90)
            SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
            SetTextTagLifespanBJ(GetLastCreatedTextTag(), 7.00)
            SetTextTagFadepointBJ(GetLastCreatedTextTag(), 5.00)
            RemoveLocation(udg_TempPoint)
        end
        UnitRemoveItemSwapped(GetManipulatedItem(), gg_unit_n006_0218)
    end

    --===========================================================================
    gg_trg_Slugglyship = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_Slugglyship, gg_unit_n006_0218, EVENT_UNIT_PICKUP_ITEM)
    TriggerAddAction(gg_trg_Slugglyship, Trig_Slugglyship_Actions)
end)
if Debug then Debug.endFile() end
