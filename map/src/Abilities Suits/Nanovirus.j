function Trig_Nanovirus_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A09R' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nanovirus_Func004Func001Func001C takes nothing returns boolean
    if ( ( UnitHasBuffBJ(udg_TempUnit2, 'BNpa') == true ) ) then
        return true
    endif
    if ( ( UnitHasBuffBJ(udg_TempUnit2, 'B00H') == true ) ) then
        return true
    endif
    if ( ( UnitHasBuffBJ(udg_TempUnit2, 'BNpm') == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_Nanovirus_Func004Func001Func003Func002Func001Func001C takes nothing returns boolean
    if ( not ( udg_MutantUpgradeLevel == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nanovirus_Func004Func001Func003Func002Func001C takes nothing returns boolean
    if ( not ( udg_MutantUpgradeLevel == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nanovirus_Func004Func001Func003Func002C takes nothing returns boolean
    if ( not ( udg_MutantUpgradeLevel == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nanovirus_Func004Func001Func003C takes nothing returns boolean
    if ( not ( UnitHasBuffBJ(udg_TempUnit2, 'B009') == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_Nanovirus_Func004Func001C takes nothing returns boolean
    if ( not Trig_Nanovirus_Func004Func001Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_Nanovirus_Func004Func007C takes nothing returns boolean
    if ( ( GetUnitTypeId(udg_TempUnit2) == 'h02G' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(udg_TempUnit2) == 'h02O' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(udg_TempUnit2) == 'h016' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(udg_TempUnit2) == 'h014' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(udg_TempUnit2) == 'h011' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(udg_TempUnit2) == 'h012' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(udg_TempUnit2) == 'h049' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(udg_TempUnit2) == 'h017' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(udg_TempUnit2) == 'h04S' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(udg_TempUnit2) == 'h00G' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(udg_TempUnit2) == 'h03Z' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(udg_TempUnit2) == 'h023' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(udg_TempUnit2) == 'h019' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(udg_TempUnit2) == 'h00O' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(udg_TempUnit2) == 'h00P' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(udg_TempUnit2) == 'h00Q' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(udg_TempUnit2) == 'h00R' ) ) then
        return true
    endif
    if ( ( IsUnitType(udg_TempUnit2, UNIT_TYPE_STRUCTURE) == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_Nanovirus_Func004C takes nothing returns boolean
    if ( not Trig_Nanovirus_Func004Func007C() ) then
        return false
    endif
    return true
endfunction

function Trig_Nanovirus_Actions takes nothing returns nothing
    set udg_TempUnit2 = GetSpellTargetUnit()
    if ( Trig_Nanovirus_Func004C() ) then
        call CreateTextTagUnitBJ( "TRIGSTR_4809", udg_TempUnit2, 0, 10, 80.00, 80.00, 100, 0 )
        call SetTextTagVelocityBJ( GetLastCreatedTextTag(), 32.00, 90 )
        call SetTextTagPermanentBJ( GetLastCreatedTextTag(), false )
        call SetTextTagLifespanBJ( GetLastCreatedTextTag(), 5 )
        call SetTextTagFadepointBJ( GetLastCreatedTextTag(), 4 )
    else
        if ( Trig_Nanovirus_Func004Func001C() ) then
            call UnitRemoveBuffsBJ( bj_REMOVEBUFFS_ALL, udg_TempUnit2 )
            call CreateNUnitsAtLoc( 1, 'e03D', Player(PLAYER_NEUTRAL_AGGRESSIVE), GetUnitLoc(udg_TempUnit2), bj_UNIT_FACING )
            call UnitApplyTimedLifeBJ( 2.00, 'BTLF', GetLastCreatedUnit() )
            call IssueTargetOrderBJ( GetLastCreatedUnit(), "parasite", udg_TempUnit2 )
        else
            if ( Trig_Nanovirus_Func004Func001Func003C() ) then
                if ( Trig_Nanovirus_Func004Func001Func003Func002C() ) then
                    call UnitRemoveBuffsBJ( bj_REMOVEBUFFS_ALL, udg_TempUnit2 )
                    call CreateNUnitsAtLoc( 1, 'e03E', Player(PLAYER_NEUTRAL_AGGRESSIVE), GetUnitLoc(udg_TempUnit2), bj_UNIT_FACING )
                    call UnitApplyTimedLifeBJ( 2.00, 'BTLF', GetLastCreatedUnit() )
                    call IssueTargetOrderBJ( GetLastCreatedUnit(), "parasite", udg_TempUnit2 )
                else
                    if ( Trig_Nanovirus_Func004Func001Func003Func002Func001C() ) then
                        call UnitRemoveBuffsBJ( bj_REMOVEBUFFS_ALL, udg_TempUnit2 )
                        call CreateNUnitsAtLoc( 1, 'e013', Player(PLAYER_NEUTRAL_AGGRESSIVE), GetUnitLoc(udg_TempUnit2), bj_UNIT_FACING )
                        call UnitApplyTimedLifeBJ( 2.00, 'BTLF', GetLastCreatedUnit() )
                        call IssueTargetOrderBJ( GetLastCreatedUnit(), "parasite", udg_TempUnit2 )
                    else
                        if ( Trig_Nanovirus_Func004Func001Func003Func002Func001Func001C() ) then
                            call UnitRemoveBuffsBJ( bj_REMOVEBUFFS_ALL, udg_TempUnit2 )
                            call CreateNUnitsAtLoc( 1, 'e00D', Player(PLAYER_NEUTRAL_AGGRESSIVE), GetUnitLoc(udg_TempUnit2), bj_UNIT_FACING )
                            call UnitApplyTimedLifeBJ( 2.00, 'BTLF', GetLastCreatedUnit() )
                            call IssueTargetOrderBJ( GetLastCreatedUnit(), "parasite", udg_TempUnit2 )
                        else
                        endif
                    endif
                endif
            else
                call UnitRemoveBuffsBJ( bj_REMOVEBUFFS_ALL, udg_TempUnit2 )
            endif
        endif
    endif
endfunction

//===========================================================================
function InitTrig_Nanovirus takes nothing returns nothing
    set gg_trg_Nanovirus = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Nanovirus, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_Nanovirus, Condition( function Trig_Nanovirus_Conditions ) )
    call TriggerAddAction( gg_trg_Nanovirus, function Trig_Nanovirus_Actions )
endfunction

