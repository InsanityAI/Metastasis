//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_Carrier_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A05I' ) ) then
        return false
    endif
    return true
endfunction

function Carrier_Infect takes nothing returns nothing
local unit a=GetTriggerUnit()
local unit b
if GetUnitPointValue(a) != 37 and IsUnitType(a, UNIT_TYPE_MECHANICAL)==false then
set b=CreateUnit(udg_Mutant,'e00D',GetUnitX(a), GetUnitY(a),0.0)
call PolledWait(0.0)
call IssueTargetOrderBJ(b, "parasite", a )
endif
endfunction

function Trig_Carrier_Actions takes nothing returns nothing
local trigger t=CreateTrigger()
call TriggerRegisterUnitInRangeSimple(t,350.0,GetSpellTargetUnit())
call TriggerAddAction(t,function Carrier_Infect)
set udg_Unit_CarrierTrigger[GetUnitAN(GetSpellTargetUnit())]=t
endfunction

//===========================================================================
function InitTrig_Carrier takes nothing returns nothing
    set gg_trg_Carrier = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Carrier, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_Carrier, Condition( function Trig_Carrier_Conditions ) )
    call TriggerAddAction( gg_trg_Carrier, function Trig_Carrier_Actions )
endfunction

