if Debug then Debug.beginFile "System/ChatSys/ChatGroupList" end
OnInit.trig("ChatGroupList", function(require)
    require "PlayerColor"
    ---@return boolean
    function Trig_ChatGroupList_Conditions()
        if (not (IsPlayerInForce(GetTriggerPlayer(), udg_DeadGroup) ~= true)) then
            return false
        end
        if (not (SubStringBJ(GetEventPlayerChatString(), 1, 5) == "-list")) then
            return false
        end
        return true
    end

    function Trig_ChatGroupList_Func007Func002A()
        DisplayTextToPlayer(GetTriggerPlayer(), 0, 0,
            PlayerColor[GetEnumPlayer()] .. GetPlayerName(GetEnumPlayer()) .. "|r")
    end

    ---@return boolean
    function Trig_ChatGroupList_Func007C()
        if (not (IsPlayerInForce(GetTriggerPlayer(), udg_TempPlayerGroup) == true)) then
            return false
        end
        return true
    end

    function Trig_ChatGroupList_Actions()
        ExecuteFunc("ClearArguments")
        ExecuteFunc("ParseEnteredString")
        udg_TempPlayerGroup = LoadForceHandle(LS(), GetHandleId(udg_ChatGroupStore), StringHash(udg_arguments[2]))
        udg_TempString = udg_arguments[2]
        if (Trig_ChatGroupList_Func007C()) then
            DisplayTextToPlayer(GetTriggerPlayer(), 0, 0,
                ("|cff808000Players in group |cff0080C0" .. (udg_TempString .. "|r:")))
            ForForce(udg_TempPlayerGroup, Trig_ChatGroupList_Func007Func002A)
        else
        end
    end

    --===========================================================================
    local i              = 0 ---@type integer
    gg_trg_ChatGroupList = CreateTrigger()
    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_ChatGroupList, Player(i), "-list", false)
        i = i + 1
    end
    TriggerAddCondition(gg_trg_ChatGroupList, Condition(Trig_ChatGroupList_Conditions))
    TriggerAddAction(gg_trg_ChatGroupList, Trig_ChatGroupList_Actions)
end)
if Debug then Debug.endFile() end
