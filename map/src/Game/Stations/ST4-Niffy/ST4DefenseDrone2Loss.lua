if Debug then Debug.beginFile "Game/Stations/ST4/ST4DefenseDrone2Loss" end
OnInit.map("ST4DefenseDrone2Loss", function(require)



---@return boolean
function Trig_ST4DefenseDrone2Loss_Conditions()
    if ( not ( GetUnitPointValue(GetTriggerUnit()) ~= 37 ) ) then
        return false
    end
    if ( not ( GetUnitTypeId(GetTriggerUnit()) ~= FourCC('h00B') ) ) then
        return false
    end
    return true
end

---@return boolean
function Trig_ST4DefenseDrone2Loss_Func004C()
    if ( not ( GetOwningPlayer(gg_unit_h00B_0031) == GetOwningPlayer(GetTriggerUnit()) ) ) then
        return false
    end
    return true
end

function Trig_ST4DefenseDrone2Loss_Actions()
    if ( Trig_ST4DefenseDrone2Loss_Func004C() ) then
        SetUnitOwner( gg_unit_h00B_0031, Player(PLAYER_NEUTRAL_PASSIVE), false )
    else
    end
end

--===========================================================================
    gg_trg_ST4DefenseDrone2Loss = CreateTrigger(  )
    TriggerRegisterLeaveRectSimple( gg_trg_ST4DefenseDrone2Loss, gg_rct_DD2 )
    TriggerAddCondition( gg_trg_ST4DefenseDrone2Loss, Condition( Trig_ST4DefenseDrone2Loss_Conditions ) )
    TriggerAddAction( gg_trg_ST4DefenseDrone2Loss, Trig_ST4DefenseDrone2Loss_Actions )
end)
if Debug then Debug.endFile() end
