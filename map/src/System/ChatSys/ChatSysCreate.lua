if Debug then Debug.beginFile "System/ChatSys/ChatSysCreate" end
OnInit.map("ChatSysCreate", function(require)
    ---@return boolean
    function Trig_ChatSysCreate_Conditions()
        if (not (SubStringBJ(GetEventPlayerChatString(), 1, 12) == "-creategroup")) then
            return false
        end
        if (not (IsPlayerInForce(GetTriggerPlayer(), udg_DeadGroup) ~= true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ChatSysCreate_Func003C()
        if (not (CountPlayersInForceBJ(udg_TempPlayerGroup) == 0)) then
            return false
        end
        return true
    end

    function Trig_ChatSysCreate_Actions()
        udg_TempString = SubStringBJ(GetEventPlayerChatString(), 14, 99)
        udg_TempPlayerGroup = LoadForceHandle(LS(), GetHandleId(udg_ChatGroupStore), StringHash(udg_TempString))

        if (Trig_ChatSysCreate_Func003C()) then
            udg_TempPlayerGroup = CreateForce()
            ForceAddPlayerSimple(GetTriggerPlayer(), udg_TempPlayerGroup)
            SaveForceHandle(LS(), GetHandleId(udg_ChatGroupStore), StringHash(udg_TempString), udg_TempPlayerGroup)
            SaveInteger(LS(), GetHandleId(gg_trg_ChatGroupAdd), StringHash(udg_TempString),
                GetConvertedPlayerId(GetTriggerPlayer()))
            DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 30, "TRIGSTR_1559")
        else
            DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 30, "TRIGSTR_1558")
        end
    end

    --===========================================================================

    local i              = 0 ---@type integer
    gg_trg_ChatSysCreate = CreateTrigger()
    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_ChatSysCreate, Player(i), "-creategroup", false)
        i = i + 1
    end
    TriggerAddCondition(gg_trg_ChatSysCreate, Condition(Trig_ChatSysCreate_Conditions))
    TriggerAddAction(gg_trg_ChatSysCreate, Trig_ChatSysCreate_Actions)
end)
if Debug then Debug.endFile() end
