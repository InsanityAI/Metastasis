if Debug then Debug.beginFile "Commands/Test/UseItemSlot" end
OnInit.trig("UseItemSlot", function(require)
    ---@return boolean
    function Trig_UseItemSlot_Conditions()
        if (not (udg_TESTING == true)) then
            return false
        end
        return true
    end

    function Trig_UseItemSlot_Actions()
        --Call UnitUseItem(playerhero[first number typed], itemslot of second number typed)
        --^Second has a unit in between, which is the target if the item needs targetting and it is itself
        UnitUseItem(udg_Playerhero[S2I(SubStringBJ(GetEventPlayerChatString(), 10, 10))],
            UnitItemInSlotBJ(udg_Playerhero[S2I(SubStringBJ(GetEventPlayerChatString(), 10, 10))],
                S2I(SubStringBJ(GetEventPlayerChatString(), 12, 15))))
        UnitUseItemTarget(udg_Playerhero[S2I(SubStringBJ(GetEventPlayerChatString(), 10, 10))],
            UnitItemInSlotBJ(udg_Playerhero[S2I(SubStringBJ(GetEventPlayerChatString(), 10, 10))],
                S2I(SubStringBJ(GetEventPlayerChatString(), 12, 15))),
            udg_Playerhero[S2I(SubStringBJ(GetEventPlayerChatString(), 10, 10))])
        --call DisplayTextToForce( GetPlayersAll(), SubStringBJ(GetEventPlayerChatString(), 10, 11))// Debug msg
        --call DisplayTextToForce( GetPlayersAll(), SubStringBJ(GetEventPlayerChatString(), 12, 15))// Debug msg
    end

    --===========================================================================
    local i            = 0 ---@type integer
    gg_trg_UseItemSlot = CreateTrigger()

    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_UseItemSlot, Player(i), "-useitem", false)
        i = i + 1
    end

    TriggerAddCondition(gg_trg_UseItemSlot, Condition(Trig_UseItemSlot_Conditions))
    TriggerAddAction(gg_trg_UseItemSlot, Trig_UseItemSlot_Actions)
end)
if Debug then Debug.endFile() end
