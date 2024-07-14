function Trig_Sludge_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A012' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sludge_Func006C takes nothing returns boolean
    if ( not ( IsPlayerEnemy(GetOwningPlayer(GetSpellAbilityUnit()), Player(PLAYER_NEUTRAL_AGGRESSIVE)) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sludge_Func009C takes nothing returns boolean
    if ( not ( udg_TempBool == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Sludge_Actions takes nothing returns nothing
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
    set udg_TempPoint2 = GetSpellTargetLoc()
    set udg_TempBool = false
    if ( Trig_Sludge_Func006C() ) then
        set udg_TempBool = true
        call SetPlayerAllianceStateBJ( Player(PLAYER_NEUTRAL_AGGRESSIVE), GetOwningPlayer(GetSpellAbilityUnit()), bj_ALLIANCE_ALLIED )
    else
    endif
    call CreateNUnitsAtLoc( 1, 'e000', Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, AngleBetweenPoints(udg_TempPoint, udg_TempPoint2) )
    call IssuePointOrderLocBJ( GetLastCreatedUnit(), "carrionswarm", udg_TempPoint2 )
    if ( Trig_Sludge_Func009C() ) then
        call SetPlayerAllianceStateBJ( Player(PLAYER_NEUTRAL_AGGRESSIVE), GetOwningPlayer(GetSpellAbilityUnit()), bj_ALLIANCE_UNALLIED )
    else
    endif
    call RemoveLocation(udg_TempPoint)
    call RemoveLocation(udg_TempPoint2)
endfunction

//===========================================================================
function InitTrig_Sludge takes nothing returns nothing
    set gg_trg_Sludge = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Sludge, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_Sludge, Condition( function Trig_Sludge_Conditions ) )
    call TriggerAddAction( gg_trg_Sludge, function Trig_Sludge_Actions )
endfunction

