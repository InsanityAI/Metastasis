function Trig_News_Func002C takes nothing returns boolean
    if ( not ( udg_NewsString[udg_TempInt3] == "" ) ) then
        return false
    endif
    return true
endfunction

function Trig_News_Actions takes nothing returns nothing
    set udg_TempInt3 = GetRandomInt(1, 12)
    if ( Trig_News_Func002C() ) then
        call TriggerExecute( gg_trg_News )
        return
    else
    endif
    call DisplayTextToForce( GetPlayersAll(), ( "|cff00FF00KIRZ95 News: |r" + udg_NewsString[udg_TempInt3] ) )
    set udg_NewsString[udg_TempInt3] = ""
    call StartTimerBJ( udg_RandomEvent, false, GetRandomReal(10.00, 300.00) )
endfunction

//===========================================================================
function InitTrig_News takes nothing returns nothing
    set gg_trg_News = CreateTrigger(  )
    call DisableTrigger( gg_trg_News )
    call TriggerAddAction( gg_trg_News, function Trig_News_Actions )
endfunction

