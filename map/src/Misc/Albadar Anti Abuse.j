function Trig_Albadar_Anti_Abuse_Conditions takes nothing returns boolean
    if ( not ( udg_ace_Existence == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Albadar_Anti_Abuse_Actions takes nothing returns nothing
    call SetUnitPositionLoc( GetTriggerUnit(), GetRectCenter(gg_rct_TransportationPlatform) )
endfunction

//===========================================================================
function InitTrig_Albadar_Anti_Abuse takes nothing returns nothing
    set gg_trg_Albadar_Anti_Abuse = CreateTrigger(  )
    call TriggerRegisterEnterRectSimple( gg_trg_Albadar_Anti_Abuse, gg_rct_SS12 )
    call TriggerAddCondition( gg_trg_Albadar_Anti_Abuse, Condition( function Trig_Albadar_Anti_Abuse_Conditions ) )
    call TriggerAddAction( gg_trg_Albadar_Anti_Abuse, function Trig_Albadar_Anti_Abuse_Actions )
endfunction

