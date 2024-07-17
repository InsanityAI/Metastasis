if Debug then Debug.beginFile "Game/Stations/ST4/ST4DefenseDrone1Loss" end
OnInit.map("ST4DefenseDrone1Loss", function(require)
    ---@return boolean
    function Trig_ST4DefenseDrone1Loss_Conditions()
        if (not (GetUnitPointValue(GetTriggerUnit()) ~= 37)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ST4DefenseDrone1Loss_Func003C()
        if (not (GetOwningPlayer(gg_unit_h00B_0032) == GetOwningPlayer(GetTriggerUnit()))) then
            return false
        end
        return true
    end

    function Trig_ST4DefenseDrone1Loss_Actions()
        if (Trig_ST4DefenseDrone1Loss_Func003C()) then
            SetUnitOwner(gg_unit_h00B_0032, Player(PLAYER_NEUTRAL_PASSIVE), false)
        else
        end
    end

    --===========================================================================
    gg_trg_ST4DefenseDrone1Loss = CreateTrigger()
    TriggerRegisterLeaveRectSimple(gg_trg_ST4DefenseDrone1Loss, gg_rct_DD1)
    TriggerAddCondition(gg_trg_ST4DefenseDrone1Loss, Condition(Trig_ST4DefenseDrone1Loss_Conditions))
    TriggerAddAction(gg_trg_ST4DefenseDrone1Loss, Trig_ST4DefenseDrone1Loss_Actions)
end)
if Debug then Debug.endFile() end
