function Trig_MutantDevour_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A05M' ) ) then
        return false
    endif
    return true
endfunction

function Trig_MutantDevour_Func003Func003C takes nothing returns boolean
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'n006' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'n001' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'n000' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'n002' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'n00A' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'nech' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'nfro' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'necr' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'nder' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'nshe' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'e01H' ) ) then
        return true
    endif
    return false
endfunction

function Trig_MutantDevour_Func003C takes nothing returns boolean
    if ( not Trig_MutantDevour_Func003Func003C() ) then
        return false
    endif
    return true
endfunction

function Trig_MutantDevour_Func004C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSpellTargetUnit()) == 'e01H' ) ) then
        return false
    endif
    return true
endfunction

function Trig_MutantDevour_Actions takes nothing returns nothing
    if ( Trig_MutantDevour_Func003C() ) then
    else
        call IssueImmediateOrderBJ( GetSpellAbilityUnit(), "stop" )
        return
    endif
    if ( Trig_MutantDevour_Func004C() ) then
        call KillUnit( GetSpellTargetUnit() )
        set udg_UpgradePointsMutant = ( udg_UpgradePointsMutant + 200.00 )
    else
        call RemoveUnit( GetSpellTargetUnit() )
        set udg_UpgradePointsMutant = ( udg_UpgradePointsMutant + 75.00 )
    endif
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
    call SetSoundPositionLocBJ( gg_snd_Devour, udg_TempPoint, 0 )
    call PlaySoundBJ( gg_snd_Devour )
    call AddSpecialEffectLocBJ( udg_TempPoint, "Objects\\Spawnmodels\\Orc\\Orcblood\\BattrollBlood.mdl" )
    call SFXThreadClean()
    call RemoveLocation(udg_TempPoint)
    set udg_TempReal = 12.00
    set udg_TempUnitType = 'e031'
    set udg_TempPlayer = GetOwningPlayer(GetSpellAbilityUnit())
    call ExecuteFunc("AlienRequirementRemove")
    call ExecuteFunc("AlienRequirementRestore")
endfunction

//===========================================================================
function InitTrig_MutantDevour takes nothing returns nothing
    set gg_trg_MutantDevour = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_MutantDevour, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_MutantDevour, Condition( function Trig_MutantDevour_Conditions ) )
    call TriggerAddAction( gg_trg_MutantDevour, function Trig_MutantDevour_Actions )
endfunction

