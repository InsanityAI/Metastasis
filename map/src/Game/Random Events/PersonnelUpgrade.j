function Trig_PersonnelUpgrade_Func003C takes nothing returns boolean
    if ( not ( IsUnitAliveBJ(gg_unit_h009_0029) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_PersonnelUpgrade_Actions takes nothing returns nothing
    call DestroyTrigger(GetTriggeringTrigger())
    set udg_RandomEvent_On[8] = true
    if ( Trig_PersonnelUpgrade_Func003C() ) then
        call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_4205" )
        call StartTimerBJ( udg_RandomEvent, false, GetRandomReal(10.00, 1200.00) )
        call EnableTrigger( gg_trg_PersonnelUpgradeEnter )
        call EnableTrigger( gg_trg_PersonnelUpgradeDialog )
        set udg_TempPoint = GetRectCenter(gg_rct_PersonnelUpgrade)
        call PingMinimapLocForForce( GetPlayersAll(), udg_TempPoint, 12.00 )
        call RemoveLocation(udg_TempPoint)
    else
        call StartTimerBJ( udg_RandomEvent, false, GetRandomReal(10.00, 120.00) )
    endif
endfunction

//===========================================================================
function InitTrig_PersonnelUpgrade takes nothing returns nothing
    set gg_trg_PersonnelUpgrade = CreateTrigger(  )
    call DisableTrigger( gg_trg_PersonnelUpgrade )
    call TriggerAddAction( gg_trg_PersonnelUpgrade, function Trig_PersonnelUpgrade_Actions )
endfunction

