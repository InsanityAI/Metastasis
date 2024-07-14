//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_PrismRocketsEnd_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A05U' ) ) then
        return false
    endif
    return true
endfunction

function Trig_PrismRocketsEnd_Actions takes nothing returns nothing
local timer t=LoadTimerHandle(LS(),GetHandleId(GetSpellAbilityUnit()),StringHash("PrismRocket_Timer"))
call FlushChildHashtable(LS(),GetHandleId(t))
call DestroyTimer(t)
call PauseTimer(t)
endfunction

//===========================================================================
function InitTrig_PrismRocketsEnd takes nothing returns nothing
    set gg_trg_PrismRocketsEnd = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_PrismRocketsEnd, EVENT_PLAYER_UNIT_SPELL_ENDCAST )
    call TriggerAddCondition( gg_trg_PrismRocketsEnd, Condition( function Trig_PrismRocketsEnd_Conditions ) )
    call TriggerAddAction( gg_trg_PrismRocketsEnd, function Trig_PrismRocketsEnd_Actions )
endfunction

