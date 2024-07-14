function Trig_Tetrabin_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I01K' ) ) then
        return false
    endif
    if ( not ( GetTriggerUnit() == udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] ) ) then
        return false
    endif
    return true
endfunction

function Trig_Tetrabin_Func005C takes nothing returns boolean
    if ( not ( udg_HiddenAndroid == GetOwningPlayer(GetTriggerUnit()) ) ) then
        return false
    endif
    return true
endfunction

function Trig_Tetrabin_Func006Func004C takes nothing returns boolean
    if ( ( udg_Parasite == GetOwningPlayer(GetTriggerUnit()) ) ) then
        return true
    endif
    if ( ( udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_Tetrabin_Func006C takes nothing returns boolean
    if ( not Trig_Tetrabin_Func006Func004C() ) then
        return false
    endif
    return true
endfunction

function Trig_Tetrabin_Func007Func004C takes nothing returns boolean
    if ( ( udg_Mutant == GetOwningPlayer(GetTriggerUnit()) ) ) then
        return true
    endif
    if ( ( udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] == true ) ) then
        return true
    endif
    return false
endfunction

function Trig_Tetrabin_Func007C takes nothing returns boolean
    if ( not Trig_Tetrabin_Func007Func004C() ) then
        return false
    endif
    return true
endfunction

function Trig_Tetrabin_Func010C takes nothing returns boolean
    if ( not ( GetRandomInt(1, 2) != 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Tetrabin_Func012Func001Func001Func002C takes nothing returns boolean
    if not (GetLocalPlayer() == GetOwningPlayer(GetManipulatingUnit())) then
    return false
    endif
    return true
endfunction

function Trig_Tetrabin_Func012Func001Func001Func003Func001Func001Func001C takes nothing returns boolean
    if not (GetLocalPlayer() == GetOwningPlayer(GetManipulatingUnit())) then
    return false
    endif
    return true
endfunction

function Trig_Tetrabin_Func012Func001Func001Func003Func001Func001Func002Func001Func003Func002C takes nothing returns boolean
    if not (GetLocalPlayer() == GetOwningPlayer(GetManipulatingUnit())) then
    return false
    endif
    return true
endfunction

function Trig_Tetrabin_Func012Func001Func001Func003Func001Func001Func002Func001Func003C takes nothing returns boolean
    if ( not ( GetRandomInt(1, 2) == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Tetrabin_Func012Func001Func001Func003Func001Func001Func002Func001C takes nothing returns boolean
    if ( not ( udg_TempInt == 7 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Tetrabin_Func012Func001Func001Func003Func001Func001Func002C takes nothing returns boolean
    if ( not ( udg_TempInt == 6 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Tetrabin_Func012Func001Func001Func003Func001Func001C takes nothing returns boolean
    if ( not ( udg_TempInt == 5 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Tetrabin_Func012Func001Func001Func003Func001C takes nothing returns boolean
    if ( not ( udg_TempInt == 4 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Tetrabin_Func012Func001Func001Func003C takes nothing returns boolean
    if ( not ( udg_TempInt == 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Tetrabin_Func012Func001Func001C takes nothing returns boolean
    if ( not ( udg_TempInt == 2 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Tetrabin_Func012Func001C takes nothing returns boolean
    if ( not ( udg_TempInt == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Tetrabin_Func012C takes nothing returns boolean
    if ( not ( udg_TempInt == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Tetrabin_Actions takes nothing returns nothing
    // Addition: Evils take EP and destroy it
    if ( Trig_Tetrabin_Func005C() ) then
        call RemoveItem( GetManipulatedItem() )
        return
    else
    endif
    if ( Trig_Tetrabin_Func006C() ) then
        set udg_UpgradePointsAlien = ( udg_UpgradePointsAlien + 700.00 )
        call RemoveItem( GetManipulatedItem() )
        return
    else
    endif
    if ( Trig_Tetrabin_Func007C() ) then
        set udg_UpgradePointsMutant = ( udg_UpgradePointsMutant + 700.00 )
        call RemoveItem( GetManipulatedItem() )
        return
    else
    endif
    // ------
    call SetPlayerTechResearchedSwap( 'R00A', ( GetPlayerTechCountSimple('R00A', GetOwningPlayer(GetTriggerUnit())) + 1 ), GetOwningPlayer(GetTriggerUnit()) )
    if ( Trig_Tetrabin_Func010C() ) then
        set udg_Player_TetrabinLevel[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] = ( udg_Player_TetrabinLevel[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] + 1 )
    else
    endif
    set udg_TempInt = udg_Player_TetrabinLevel[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]
    if ( Trig_Tetrabin_Func012C() ) then
    else
        if ( Trig_Tetrabin_Func012Func001C() ) then
            call CameraSetTargetNoiseForPlayer( GetOwningPlayer(GetTriggerUnit()), 120.00, 1.20 )
        else
            if ( Trig_Tetrabin_Func012Func001Func001C() ) then
                call CameraSetTargetNoiseForPlayer( GetOwningPlayer(GetTriggerUnit()), 240.00, 2.40 )
                if ( Trig_Tetrabin_Func012Func001Func001Func002C() ) then
                        call NewSoundEnvironment( "psychotic" )
                else
                endif
            else
                if ( Trig_Tetrabin_Func012Func001Func001Func003C() ) then
                    call CameraSetTargetNoiseForPlayer( GetOwningPlayer(GetTriggerUnit()), 480.00, 4.80 )
                else
                    if ( Trig_Tetrabin_Func012Func001Func001Func003Func001C() ) then
                        call CameraSetTargetNoiseForPlayer( GetOwningPlayer(GetTriggerUnit()), 920.00, 9.20 )
                    else
                        if ( Trig_Tetrabin_Func012Func001Func001Func003Func001Func001C() ) then
                            if ( Trig_Tetrabin_Func012Func001Func001Func003Func001Func001Func001C() ) then
                                call SetDayNightModels("r.mdx","r.mdx")
                            else
                            endif
                        else
                            if ( Trig_Tetrabin_Func012Func001Func001Func003Func001Func001Func002C() ) then
                                call CreateFogModifierRectBJ( true, GetOwningPlayer(GetManipulatingUnit()), FOG_OF_WAR_MASKED, GetPlayableMapRect() )
                            else
                                if ( Trig_Tetrabin_Func012Func001Func001Func003Func001Func001Func002Func001C() ) then
                                    call CameraSetTargetNoiseForPlayer( GetOwningPlayer(GetTriggerUnit()), 1500.00, 15.00 )
                                    if ( Trig_Tetrabin_Func012Func001Func001Func003Func001Func001Func002Func001Func003C() ) then
                                        if ( Trig_Tetrabin_Func012Func001Func001Func003Func001Func001Func002Func001Func003Func002C() ) then
                                            call ExecuteFunc("TETRABINCRASHESTHEGAME")
                                        else
                                        endif
                                    else
                                        call ExplodeUnitBJ( udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))] )
                                    endif
                                else
                                    call ExplodeUnitBJ( udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))] )
                                endif
                            endif
                        endif
                    endif
                endif
            endif
        endif
    endif
endfunction

//===========================================================================
function InitTrig_Tetrabin takes nothing returns nothing
    set gg_trg_Tetrabin = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Tetrabin, EVENT_PLAYER_UNIT_USE_ITEM )
    call TriggerAddCondition( gg_trg_Tetrabin, Condition( function Trig_Tetrabin_Conditions ) )
    call TriggerAddAction( gg_trg_Tetrabin, function Trig_Tetrabin_Actions )
endfunction

