//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_Blackness_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A041' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Blackness_Func001C takes nothing returns boolean
    if ( not ( udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] == GetSpellTargetUnit() ) ) then
        return false
    endif
    return true
endfunction

function Trig_Blackness_Actions takes nothing returns nothing
local player k=GetOwningPlayer(GetSpellTargetUnit())
    if ( Trig_Blackness_Func001C() ) then
    
        call CinematicFilterGenericForPlayer(GetOwningPlayer(GetSpellTargetUnit()), 1, BLEND_MODE_BLEND,  "ReplaceableTextures\\CameraMasks\\White_mask.blp", 100,100,100,100,0,0,0,0)
        set udg_Player_Blinded[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] = true
        call PolledWait( 6.00 )
        set udg_Player_Blinded[GetConvertedPlayerId(k)] = false
        call CinematicFilterGenericForPlayer(k, 3, BLEND_MODE_BLEND,  "ReplaceableTextures\\CameraMasks\\White_mask.blp", 0,0,0,0,100,100,100,100)
    else
        call DisplayTextToPlayer( udg_Parasite, 0, 0, "TRIGSTR_2179" )
    endif
endfunction

//===========================================================================
function InitTrig_Blackness takes nothing returns nothing
    set gg_trg_Blackness = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Blackness, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_Blackness, Condition( function Trig_Blackness_Conditions ) )
    call TriggerAddAction( gg_trg_Blackness, function Trig_Blackness_Actions )
endfunction

