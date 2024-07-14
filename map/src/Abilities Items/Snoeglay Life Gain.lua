//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_Snoeglay_Life_Gain_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I024' ) ) then
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
    
    set udg_SnoeglayBonus[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] = udg_SnoeglayBonus[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] + 1
    if udg_SnoeglayBonus[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] == 3 then
        set udg_SnoeglayBonus[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))]=0
        return true
    else
        return false
    endif
endfunction

function Trig_Snoeglay_Life_Gain_Actions takes nothing returns nothing
    call SetPlayerTechResearchedSwap( 'R00C', ( GetPlayerTechCountSimple('R00C', GetOwningPlayer(GetTriggerUnit())) + 1 ), GetOwningPlayer(GetTriggerUnit()) )
endfunction

//===========================================================================
function InitTrig_Snoeglay_Life_Gain takes nothing returns nothing
    set gg_trg_Snoeglay_Life_Gain = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Snoeglay_Life_Gain, EVENT_PLAYER_UNIT_USE_ITEM )
    call TriggerAddCondition( gg_trg_Snoeglay_Life_Gain, Condition( function Trig_Snoeglay_Life_Gain_Conditions ) )
    call TriggerAddAction( gg_trg_Snoeglay_Life_Gain, function Trig_Snoeglay_Life_Gain_Actions )
endfunction

