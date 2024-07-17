if Debug then Debug.beginFile "System/DeadChatSys" end
OnInit.final("DeadChatSys", function(require)
    ChatBoard = nil ---@type multiboard
    ChatLog   = __jarray("") ---@type string[]
    RowOn     = 1 ---@type integer

    function ChatConverter()
        local p      = GetTriggerPlayer() ---@type player
        local s      = GetEventPlayerChatString() ---@type string
        local maxrow = 39 ---@type integer
        local r      = RowOn ---@type integer
        local i      = 1 ---@type integer
        if IsPlayerInForce(p, udg_DeadGroup) and SubString(s, 0, 1) ~= "-" then
            if RowOn > maxrow then
                RowOn = maxrow
                while i <= maxrow do
                    ChatLog[i - 1] = ChatLog[i]
                    i = i + 1
                end
            end
            ChatLog[RowOn] = "|cffFF8000" .. udg_OriginalName[GetConvertedPlayerId(p)] .. "|r: " .. s
            i = 1
            while i <= RowOn do
                MultiboardSetItemValueBJ(ChatBoard, 1, i, ChatLog[i])
                i = i + 1
            end
            RowOn = RowOn + 1
        end
    end

    ChatBoard = CreateMultiboardBJ(1, 40, "Dead Player Chat")
    MultiboardSetItemWidthBJ(ChatBoard, 1, 0, 100.00)
    MultiboardSetItemStyleBJ(ChatBoard, 1, 0, true, false)
    MultiboardDisplay(ChatBoard, false)

    --===========================================================================

    local i = 0 ---@type integer
    gg_trg_ChatConverter = CreateTrigger()
    while i <= 11 do
        if GetPlayerController(Player(i)) == MAP_CONTROL_USER then
            TriggerRegisterPlayerChatEvent(gg_trg_ChatConverter, Player(i), "", false)
        end
        i = i + 1
    end
    TriggerAddAction(gg_trg_ChatConverter, ChatConverter)
end)
if Debug then Debug.endFile() end
