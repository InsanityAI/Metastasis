//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_CrabMutant_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetAttacker()) == 'h01C' ) ) then
        return false
    endif
    return true
endfunction

function Trig_CrabMutant_Actions takes nothing returns nothing
local location q=GetUnitLoc(GetAttacker())
local location a=PolarProjectionBJ(q,90.0,GetUnitFacing(GetAttacker()))
local unit b=GetAttackedUnitBJ()
    call CreateNUnitsAtLoc( 1, 'n009', Player(PLAYER_NEUTRAL_PASSIVE),a, bj_UNIT_FACING )
    call IssueTargetOrderBJ( GetLastCreatedUnit(), "attack", b)
    set bj_lastCreatedEffect=AddSpecialEffectLoc("Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl",a)
        call SFXThreadClean()
    call PolledWait( 0.25 )
    call CreateNUnitsAtLoc( 1, 'n009', Player(PLAYER_NEUTRAL_PASSIVE), a, bj_UNIT_FACING )
    call IssueTargetOrderBJ( GetLastCreatedUnit(), "attack", b )
    set bj_lastCreatedEffect=AddSpecialEffectLoc("Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl",a)
        call SFXThreadClean()
        if GetUnitAbilityLevel(GetAttacker(),'A07H')==1 then
    call PolledWait( 0.25 )
    call CreateNUnitsAtLoc( 1, 'n009', Player(PLAYER_NEUTRAL_PASSIVE),a, bj_UNIT_FACING )
    call IssueTargetOrderBJ( GetLastCreatedUnit(), "attack", b )
    set bj_lastCreatedEffect=AddSpecialEffectLoc("Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl",a)
        call SFXThreadClean()
        endif
    call RemoveLocation(a)
    call RemoveLocation(q)
endfunction

//===========================================================================
function InitTrig_CrabMutant takes nothing returns nothing
    set gg_trg_CrabMutant = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_CrabMutant, EVENT_PLAYER_UNIT_ATTACKED )
    call TriggerAddCondition( gg_trg_CrabMutant, Condition( function Trig_CrabMutant_Conditions ) )
    call TriggerAddAction( gg_trg_CrabMutant, function Trig_CrabMutant_Actions )
    call DisableTrigger(gg_trg_CrabMutant)
endfunction

