//TESH.scrollpos=4
//TESH.alwaysfold=0
function Trig_RaininRocks_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A05F' ) ) then
        return false
    endif
    return true
endfunction

function RaininRocks_Debris takes nothing returns nothing
local timer t=GetExpiredTimer()
local real x=LoadReal(LS(), GetHandleId(t), StringHash("x"))
local real y=LoadReal(LS(), GetHandleId(t), StringHash("y"))  
local integer i=0
call DestroyTimer(t)
loop
exitwhen i > 2
call CreateDestructable('B007', x+GetRandomReal(-100,100),y+GetRandomReal(-100,100),GetRandomDirectionDeg(),1,GetRandomInt(1,6)) 
set i=i+1
endloop
endfunction

function Trig_RaininRocks_Actions takes nothing returns nothing
local timer t=CreateTimer()
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
    set udg_TempPoint2 = GetSpellTargetLoc()
    call AddSpecialEffectLocBJ( udg_TempPoint, "Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl" )
    call SaveReal(LS(), GetHandleId(t), StringHash("x"), GetLocationX(udg_TempPoint2))
    call SaveReal(LS(), GetHandleId(t), StringHash("y"), GetLocationY(udg_TempPoint2))   
    call TimerStart(t,0.5,false, function RaininRocks_Debris)
call SFXThreadClean()
    call RemoveLocation( udg_TempPoint )
    call RemoveLocation( udg_TempPoint2 )
endfunction

//===========================================================================
function InitTrig_RaininRocks takes nothing returns nothing
    set gg_trg_RaininRocks = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_RaininRocks, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_RaininRocks, Condition( function Trig_RaininRocks_Conditions ) )
    call TriggerAddAction( gg_trg_RaininRocks, function Trig_RaininRocks_Actions )
endfunction

