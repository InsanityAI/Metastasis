if Debug then Debug.beginFile "Game/Allignment/Mutant/NoMutantTK" end
OnInit.map("NoMutantTK", function(require)



---@return boolean
function Trig_NoMutantTK_Func002Func003Func002C()
    if ( ( udg_Player_IsMutantSpawn[GetConvertedPlayerId(udg_EscapePod_Owner[GetUnitUserData(GetAttackedUnitBJ())])] == true ) ) then
        return true
    end
    if ( ( udg_EscapePod_Owner[GetUnitUserData(GetAttackedUnitBJ())] == udg_Mutant ) ) then
        return true
    end
    return false
end

---@return boolean
function Trig_NoMutantTK_Func002Func003C()
    if ( not ( GetUnitTypeId(GetAttackedUnitBJ()) == FourCC('h02P') ) ) then
        return false
    end
    if ( not Trig_NoMutantTK_Func002Func003Func002C() ) then
        return false
    end
    return true
end

---@return boolean
function Trig_NoMutantTK_Func002C()
    if ( ( udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetAttackedUnitBJ()))] == true ) ) then
        return true
    end
    if ( ( GetOwningPlayer(GetAttackedUnitBJ()) == udg_Mutant ) ) then
        return true
    end
    if ( Trig_NoMutantTK_Func002Func003C() ) then
        return true
    end
    return false
end

---@return boolean
function Trig_NoMutantTK_Conditions()
    if ( not ( udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetAttacker()))] == true ) ) then
        return false
    end
    if ( not Trig_NoMutantTK_Func002C() ) then
        return false
    end
    return true
end

function Trig_NoMutantTK_Actions()
    IssueImmediateOrderBJ( GetAttacker(), "stop" )
    DisplayTimedTextToPlayer(GetOwningPlayer(GetAttacker()), 0, 0, 30, "|cffFF0000You cannot attack your fellow mutant!|r")
end

--===========================================================================
    gg_trg_NoMutantTK = CreateTrigger(  )
    TriggerRegisterAnyUnitEventBJ( gg_trg_NoMutantTK, EVENT_PLAYER_UNIT_ATTACKED )
    TriggerAddCondition( gg_trg_NoMutantTK, Condition( Trig_NoMutantTK_Conditions ) )
    TriggerAddAction( gg_trg_NoMutantTK, Trig_NoMutantTK_Actions )
end)
if Debug then Debug.endFile() end
