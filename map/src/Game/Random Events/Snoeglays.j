function Trig_Snoeglays_Func004Func003C takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetLastReplacedUnitBJ()) == Player(PLAYER_NEUTRAL_PASSIVE) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Snoeglays_Func004A takes nothing returns nothing
    set udg_TempPoint = GetUnitLoc(GetEnumUnit())
    call ReplaceUnitBJ( GetEnumUnit(), 'h02E', bj_UNIT_STATE_METHOD_RELATIVE )
    if ( Trig_Snoeglays_Func004Func003C() ) then
        call SetUnitOwner( GetLastReplacedUnitBJ(), Player(PLAYER_NEUTRAL_AGGRESSIVE), true )
    else
    endif
    call DropItemFromUnitOnDeath(GetLastReplacedUnitBJ(),'I024')
    call AddSpecialEffectLocBJ( udg_TempPoint, "Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl" )
    call SFXThreadClean()
    call RemoveLocation(udg_TempPoint)
endfunction

function Trig_Snoeglays_Actions takes nothing returns nothing
    call DestroyTrigger(GetTriggeringTrigger())
    set udg_RandomEvent_On[5] = true
    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_1357" )
    call ForGroupBJ( GetUnitsOfTypeIdAll('n003'), function Trig_Snoeglays_Func004A )
    call StartTimerBJ( udg_RandomEvent, false, GetRandomReal(90.00, 1200.00) )
endfunction

//===========================================================================
function InitTrig_Snoeglays takes nothing returns nothing
    set gg_trg_Snoeglays = CreateTrigger(  )
    call DisableTrigger( gg_trg_Snoeglays )
    call TriggerAddAction( gg_trg_Snoeglays, function Trig_Snoeglays_Actions )
endfunction

