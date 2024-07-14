//TESH.scrollpos=4
//TESH.alwaysfold=0
function Trig_NeurotoxicPoison_Conditions takes nothing returns boolean
   if GetUnitAbilityLevel(GetAttacker(), 'A043') == 0 then
        return false
    endif
    if ( not ( udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetAttackedUnitBJ()))] == GetAttackedUnitBJ() ) ) then
        return false
    endif
    return true
endfunction

function Trig_NeurotoxicPoison_Func002C takes nothing returns boolean
    if ( not ( udg_Player_Poison_Swaying[GetConvertedPlayerId(GetOwningPlayer(GetAttackedUnitBJ()))] == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_NeurotoxicPoison_Actions takes nothing returns nothing
local unit a=GetAttackedUnitBJ()
local player p=GetOwningPlayer(a)
if IsUnitType(a, UNIT_TYPE_TAUREN) then
call UnitRemoveAbility(a,'B00P')
return
endif
call PolledWait(0.1)
    if ( Trig_NeurotoxicPoison_Func002C() ) and udg_Player_TetrabinLevel[GetConvertedPlayerId(p)]==0 then
        set udg_Player_Poison_Swaying[GetConvertedPlayerId(p)] = true
         call CameraSetSourceNoiseForPlayer( GetOwningPlayer(a), 350.00, 40 )
        loop
            exitwhen UnitHasBuffBJ(a, 'B00P') != true or a==null
   
            call PolledWait( 1.00 )
        endloop
        if udg_Player_TetrabinLevel[GetConvertedPlayerId(p)]==0 then
        call CameraSetSourceNoiseForPlayer(p,0,0)
        endif
        set udg_Player_Poison_Swaying[GetConvertedPlayerId(p)] = false
    else
    endif
endfunction

//===========================================================================
function InitTrig_NeurotoxicPoison takes nothing returns nothing
    set gg_trg_NeurotoxicPoison = CreateTrigger(  )
    call DisableTrigger( gg_trg_NeurotoxicPoison )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_NeurotoxicPoison, EVENT_PLAYER_UNIT_ATTACKED )
    call TriggerAddCondition( gg_trg_NeurotoxicPoison, Condition( function Trig_NeurotoxicPoison_Conditions ) )
    call TriggerAddAction( gg_trg_NeurotoxicPoison, function Trig_NeurotoxicPoison_Actions )
endfunction

