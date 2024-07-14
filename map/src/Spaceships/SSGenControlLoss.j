function Trig_SSGenControlLoss_Conditions takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetTriggerUnit()) == GetOwningPlayer(udg_Spaceship_Console[GetUnitUserData(udg_TempUnit)]) ) ) then
        return false
    endif
    if ( not ( GetUnitPointValue(GetTriggerUnit()) != 37 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SSGenControlLoss_Func006C takes nothing returns boolean
    if ( not ( GetUnitAbilityLevelSwapped('A0A5', udg_SS_Space[GetUnitUserData(udg_TempUnit)]) == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SSGenControlLoss_Actions takes nothing returns nothing
    call SetUnitOwner( udg_Spaceship_Console[GetUnitUserData(udg_TempUnit)], Player(PLAYER_NEUTRAL_PASSIVE), false )
    call SetUnitOwner( udg_SS_Space[GetUnitUserData(udg_TempUnit)], Player(PLAYER_NEUTRAL_PASSIVE), false )
    // If Ace -> Remove atk speed buff
    if ( Trig_SSGenControlLoss_Func006C() ) then
        call UnitRemoveAbilityBJ( 'A0A5', udg_SS_Space[GetUnitUserData(udg_TempUnit)] )
    else
    endif
endfunction

//===========================================================================
function InitTrig_SSGenControlLoss takes nothing returns nothing
    set gg_trg_SSGenControlLoss = CreateTrigger(  )
    call TriggerAddCondition( gg_trg_SSGenControlLoss, Condition( function Trig_SSGenControlLoss_Conditions ) )
    call TriggerAddAction( gg_trg_SSGenControlLoss, function Trig_SSGenControlLoss_Actions )
endfunction

