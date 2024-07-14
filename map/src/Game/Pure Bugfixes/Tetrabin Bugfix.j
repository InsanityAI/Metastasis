function Trig_Tetrabin_Bugfix_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I01K' ) ) then
        return false
    endif
    if ( not ( GetTriggerUnit() == udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] ) ) then
        return false
    endif
    if ( not ( udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] == false ) ) then
        return false
    endif
    if ( not ( udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] == false ) ) then
        return false
    endif
    if ( not ( udg_HiddenAndroid != GetOwningPlayer(GetTriggerUnit()) ) ) then
        return false
    endif
    if ( not ( udg_Mutant != GetOwningPlayer(GetTriggerUnit()) ) ) then
        return false
    endif
    if ( not ( udg_Parasite != GetOwningPlayer(GetTriggerUnit()) ) ) then
        return false
    endif
    if ( not ( GetPlayerTechCountSimple('R00A', GetOwningPlayer(GetTriggerUnit())) >= 15 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Tetrabin_Bugfix_Actions takes nothing returns nothing
    call ExplodeUnitBJ( udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))] )
endfunction

//===========================================================================
function InitTrig_Tetrabin_Bugfix takes nothing returns nothing
    set gg_trg_Tetrabin_Bugfix = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Tetrabin_Bugfix, EVENT_PLAYER_UNIT_USE_ITEM )
    call TriggerAddCondition( gg_trg_Tetrabin_Bugfix, Condition( function Trig_Tetrabin_Bugfix_Conditions ) )
    call TriggerAddAction( gg_trg_Tetrabin_Bugfix, function Trig_Tetrabin_Bugfix_Actions )
endfunction

