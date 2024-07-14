function Trig_RandomEventsTimer_Func002Func002C takes nothing returns boolean
    if ( not ( udg_RandomEvent_On[udg_TempInt] != true ) ) then
        return false
    endif
    return true
endfunction

function Trig_RandomEventsTimer_Actions takes nothing returns nothing
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 100
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        set udg_TempInt = GetRandomInt(1, 16)
        if ( Trig_RandomEventsTimer_Func002Func002C() ) then
            set bj_forLoopAIndex = 1000
        else
        endif
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    call TriggerExecute( udg_RandomEvent_Trigger[udg_TempInt] )
endfunction

//===========================================================================
function InitTrig_RandomEventsTimer takes nothing returns nothing
    set gg_trg_RandomEventsTimer = CreateTrigger(  )
    call TriggerRegisterTimerExpireEventBJ( gg_trg_RandomEventsTimer, udg_RandomEvent )
    call TriggerAddAction( gg_trg_RandomEventsTimer, function Trig_RandomEventsTimer_Actions )
endfunction

