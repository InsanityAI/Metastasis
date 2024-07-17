if Debug then Debug.beginFile "Game/Allignment/Android/AndroidChat" end
OnInit.map("AndroidChat", function(require)
    ---@return boolean
    function Trig_AndroidChat_Conditions()
        if (not (GetTriggerPlayer() == udg_HiddenAndroid)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AndroidChat_Func014Func002Func003Func001C()
        if (not (UnitHasItem(GetEnumUnit(), udg_Android_MemoryCard) == true)) then
            return false
        end
        return true
    end

    function Trig_AndroidChat_Func014Func002Func003A()
        if (Trig_AndroidChat_Func014Func002Func003Func001C()) then
            udg_Android_MemoryCardOwner = GetEnumUnit()
        else
        end
    end

    ---@return boolean
    function Trig_AndroidChat_Func014Func002C()
        if (not (UnitHasItem(udg_Android_MemoryCardOwner, udg_Android_MemoryCard) == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AndroidChat_Func014C()
        if (not (CheckItemStatus(udg_Android_MemoryCard, bj_ITEM_STATUS_OWNED) == true)) then
            return false
        end
        return true
    end

    function Trig_AndroidChat_Actions()
        if (Trig_AndroidChat_Func014C()) then
            if (Trig_AndroidChat_Func014Func002C()) then
                udg_TempPoint = GetUnitLoc(udg_Android_MemoryCardOwner)
            else
                udg_TempUnitGroup = GetUnitsInRectAll(GetPlayableMapRect())
                ForGroupBJ(udg_TempUnitGroup, Trig_AndroidChat_Func014Func002Func003A)
                udg_TempPoint = GetUnitLoc(udg_Android_MemoryCardOwner)
                DestroyGroup(udg_TempUnitGroup)
            end
        else
            udg_TempPoint = GetItemLoc(udg_Android_MemoryCard)
        end
        CreateTextTagLocBJ(GetEventPlayerChatString(), udg_TempPoint, 0, 8.00, 100, 100, 100, 0)
        SetTextTagVelocityBJ(GetLastCreatedTextTag(), 32.00, 90)
        SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
        SetTextTagLifespanBJ(GetLastCreatedTextTag(), 5)
        SetTextTagFadepointBJ(GetLastCreatedTextTag(), 4)
        ShowTextTagForceBJ(false, GetLastCreatedTextTag(), GetPlayersAll())
        if IsLocationVisibleToPlayer(udg_TempPoint, GetLocalPlayer()) then
            SetTextTagVisibility(bj_lastCreatedTextTag, true)
        end
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_AndroidChat = CreateTrigger()
    DisableTrigger(gg_trg_AndroidChat)
    TriggerRegisterPlayerChatEvent(gg_trg_AndroidChat, Player(0), "", false)
    TriggerRegisterPlayerChatEvent(gg_trg_AndroidChat, Player(1), "", false)
    TriggerRegisterPlayerChatEvent(gg_trg_AndroidChat, Player(2), "", false)
    TriggerRegisterPlayerChatEvent(gg_trg_AndroidChat, Player(3), "", false)
    TriggerRegisterPlayerChatEvent(gg_trg_AndroidChat, Player(4), "", false)
    TriggerRegisterPlayerChatEvent(gg_trg_AndroidChat, Player(5), "", false)
    TriggerRegisterPlayerChatEvent(gg_trg_AndroidChat, Player(6), "", false)
    TriggerRegisterPlayerChatEvent(gg_trg_AndroidChat, Player(7), "", false)
    TriggerRegisterPlayerChatEvent(gg_trg_AndroidChat, Player(8), "", false)
    TriggerRegisterPlayerChatEvent(gg_trg_AndroidChat, Player(9), "", false)
    TriggerRegisterPlayerChatEvent(gg_trg_AndroidChat, Player(10), "", false)
    TriggerRegisterPlayerChatEvent(gg_trg_AndroidChat, Player(11), "", false)
    TriggerAddCondition(gg_trg_AndroidChat, Condition(Trig_AndroidChat_Conditions))
    TriggerAddAction(gg_trg_AndroidChat, Trig_AndroidChat_Actions)
end)
if Debug then Debug.endFile() end
