if Debug then Debug.beginFile "Commands/Clear" end
OnInit.map("Clear", function(require)
    function Trig_Clear_Actions()
        if GetTriggerPlayer() == GetLocalPlayer() then
            ClearTextMessages()
        end
    end

    --===========================================================================
    local i      = 0 ---@type integer
    gg_trg_Clear = CreateTrigger()
    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_Clear, Player(i), "-clear", true)
        i = i + 1
    end
    TriggerAddAction(gg_trg_Clear, Trig_Clear_Actions)
end)
if Debug then Debug.endFile() end
