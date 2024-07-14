function Trig_TeleportBombExplode_Func003Func003Func001C takes nothing returns boolean
    if ( not ( IsUnitType(GetEnumUnit(), UNIT_TYPE_STRUCTURE) == false ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetEnumUnit()) != Player(PLAYER_NEUTRAL_PASSIVE) ) ) then
        return false
    endif
    if ( not ( GetUnitAbilityLevelSwapped('A079', GetEnumUnit()) == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_TeleportBombExplode_Func003Func003A takes nothing returns nothing
    if ( Trig_TeleportBombExplode_Func003Func003Func001C() ) then
        set udg_TempBool = true
    else
    endif
endfunction

function Trig_TeleportBombExplode_Func003Func005C takes nothing returns boolean
    if ( not ( udg_TempBool == false ) ) then
        return false
    endif
    if ( not ( udg_Mirror_Enabled == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_TeleportBombExplode_Func003Func007Func007C takes nothing returns boolean
    if ( not ( udg_Mirror_Enabled == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_TeleportBombExplode_Func003Func007Func009Func001Func008C takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetEnumUnit()) == Player(bj_PLAYER_NEUTRAL_EXTRA) ) ) then
        return false
    endif
    return true
endfunction

function Trig_TeleportBombExplode_Func003Func007Func009Func001C takes nothing returns boolean
    if ( not ( IsUnitType(GetEnumUnit(), UNIT_TYPE_STRUCTURE) == false ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetEnumUnit()) != Player(PLAYER_NEUTRAL_PASSIVE) ) ) then
        return false
    endif
    if ( not ( GetUnitAbilityLevelSwapped('A079', GetEnumUnit()) == 0 ) ) then
        return false
    endif
    if ( not ( RectContainsUnit(gg_rct_Mirror_Arena, GetEnumUnit()) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_TeleportBombExplode_Func003Func007Func009A takes nothing returns nothing
    if ( Trig_TeleportBombExplode_Func003Func007Func009Func001C() ) then
        call SetUnitPositionLoc( GetEnumUnit(), udg_TeleportBombMirrorExitPoint )
        // Mandatory Teleporting stuff
        call SetSoundPositionLocBJ( gg_snd_NightElfBuildingDeathSmall1, udg_TempPoint, 0 )
        call PlaySoundBJ( gg_snd_NightElfBuildingDeathSmall1 )
        call CreateNUnitsAtLoc( 1, 'e005', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING )
        call CreateNUnitsAtLoc( 1, 'e006', Player(PLAYER_NEUTRAL_PASSIVE), udg_TeleportBombMirrorExitPoint, bj_UNIT_FACING )
        // Mandatory Teleporting stuff
        if ( Trig_TeleportBombExplode_Func003Func007Func009Func001Func008C() ) then
            call PanCameraToTimedLocForPlayer( udg_Parasite, udg_TeleportBombMirrorExitPoint, 0 )
        else
            call PanCameraToTimedLocForPlayer( GetOwningPlayer(GetEnumUnit()), udg_TeleportBombMirrorExitPoint, 0 )
        endif
    else
    endif
endfunction

function Trig_TeleportBombExplode_Func003Func007Func016Func001Func002C takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetEnumUnit()) == Player(bj_PLAYER_NEUTRAL_EXTRA) ) ) then
        return false
    endif
    return true
endfunction

function Trig_TeleportBombExplode_Func003Func007Func016Func001C takes nothing returns boolean
    if ( not ( IsUnitType(GetEnumUnit(), UNIT_TYPE_STRUCTURE) == false ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetEnumUnit()) != Player(PLAYER_NEUTRAL_PASSIVE) ) ) then
        return false
    endif
    if ( not ( GetUnitAbilityLevelSwapped('A079', GetEnumUnit()) == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_TeleportBombExplode_Func003Func007Func016A takes nothing returns nothing
    if ( Trig_TeleportBombExplode_Func003Func007Func016Func001C() ) then
        call SetUnitPositionLoc( GetEnumUnit(), udg_TempPoint2 )
        if ( Trig_TeleportBombExplode_Func003Func007Func016Func001Func002C() ) then
            call PanCameraToTimedLocForPlayer( udg_Parasite, udg_TempPoint2, 0 )
        else
            call PanCameraToTimedLocForPlayer( GetOwningPlayer(GetEnumUnit()), udg_TempPoint2, 0 )
        endif
    else
    endif
endfunction

function Trig_TeleportBombExplode_Func003Func007C takes nothing returns boolean
    if ( not ( RectContainsLoc(gg_rct_Mirror_Arena, udg_TempPoint) == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_TeleportBombExplode_Func003C takes nothing returns boolean
    if ( not ( IsUnitDeadBJ(gg_unit_h009_0029) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_TeleportBombExplode_Func012Func001Func002Func002Func002C takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetEnumUnit()) == Player(bj_PLAYER_NEUTRAL_EXTRA) ) ) then
        return false
    endif
    return true
endfunction

function Trig_TeleportBombExplode_Func012Func001Func002Func002C takes nothing returns boolean
    if ( not ( udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] == GetEnumUnit() ) ) then
        return false
    endif
    return true
endfunction

function Trig_TeleportBombExplode_Func012Func001Func002C takes nothing returns boolean
    if ( not ( udg_TempBool == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_TeleportBombExplode_Func012Func001C takes nothing returns boolean
    if ( not ( IsUnitType(GetEnumUnit(), UNIT_TYPE_STRUCTURE) == false ) ) then
        return false
    endif
    if ( not ( GetOwningPlayer(GetEnumUnit()) != Player(PLAYER_NEUTRAL_PASSIVE) ) ) then
        return false
    endif
    if ( not ( GetUnitAbilityLevelSwapped('A079', GetEnumUnit()) == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_TeleportBombExplode_Func012A takes nothing returns nothing
    if ( Trig_TeleportBombExplode_Func012Func001C() ) then
        set udg_TempBool=UnitInSector(GetEnumUnit(), udg_TempInt)
        if ( Trig_TeleportBombExplode_Func012Func001Func002C() ) then
            call SetUnitPositionLoc( GetEnumUnit(), udg_TempPoint2 )
            if ( Trig_TeleportBombExplode_Func012Func001Func002Func002C() ) then
                call UnitDamageTargetBJ( GetEnumUnit(), GetEnumUnit(), 100.00, ATTACK_TYPE_MELEE, DAMAGE_TYPE_UNKNOWN )
                if ( Trig_TeleportBombExplode_Func012Func001Func002Func002Func002C() ) then
                    call PanCameraToTimedLocForPlayer( udg_Parasite, udg_TempPoint2, 0 )
                else
                    call PanCameraToTimedLocForPlayer( GetOwningPlayer(GetEnumUnit()), udg_TempPoint2, 0 )
                endif
            else
            endif
        else
        endif
    else
    endif
endfunction

function Trig_TeleportBombExplode_Actions takes nothing returns nothing
    set udg_TempUnit = udg_CountupBarTemp
    set udg_TempPoint = GetUnitLoc(udg_TempUnit)
    if ( Trig_TeleportBombExplode_Func003C() ) then
        // Check if any unit is to go inside
        set udg_TempBool = false
        call ForGroupBJ( GetUnitsInRangeOfLocAll(400.00, udg_TempPoint), function Trig_TeleportBombExplode_Func003Func003A )
        call DestroyGroup(udg_TempUnitGroup)
        if ( Trig_TeleportBombExplode_Func003Func005C() ) then
            return
        else
        endif
        // End Check if any unit is to go inside
        if ( Trig_TeleportBombExplode_Func003Func007C() ) then
            set udg_TeleportBombMirrorExitPoint = GetUnitLoc(udg_TempUnit)
            call DestroyEffectBJ( udg_Mirror_EntranceVisual )
            call AddSpecialEffectLocBJ( udg_TempPoint, "Abilities\\Spells\\Orc\\Purge\\PurgeBuffTarget.mdl" )
            set udg_Mirror_EntranceVisual = GetLastCreatedEffectBJ()
            // The above special effect stays and shows the portal exit
            if ( Trig_TeleportBombExplode_Func003Func007Func007C() ) then
                set udg_Mirror_Enabled = true
                call TriggerExecute( gg_trg_Mirror_start )
            else
            endif
            // Mandatory Teleporting stuff
            call SetSoundPositionLocBJ( gg_snd_NightElfBuildingDeathSmall1, udg_TempPoint, 0 )
            call PlaySoundBJ( gg_snd_NightElfBuildingDeathSmall1 )
            call CreateNUnitsAtLoc( 1, 'e005', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING )
            set udg_TempPoint2 = GetRectCenter(gg_rct_Mirror_Arena)
            call CreateNUnitsAtLoc( 1, 'e006', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint2, bj_UNIT_FACING )
            call ForGroupBJ( GetUnitsInRangeOfLocAll(400.00, udg_TempPoint), function Trig_TeleportBombExplode_Func003Func007Func016A )
        else
            // Using teleport in mirror arena lmao
            call ForGroupBJ( GetUnitsInRangeOfLocAll(400.00, udg_TempPoint), function Trig_TeleportBombExplode_Func003Func007Func009A )
        endif
        call RemoveLocation(udg_TempPoint)
        call RemoveLocation(udg_TempPoint2)
        return
    else
    endif
    call SetSoundPositionLocBJ( gg_snd_NightElfBuildingDeathSmall1, udg_TempPoint, 0 )
    call PlaySoundBJ( gg_snd_NightElfBuildingDeathSmall1 )
    call CreateNUnitsAtLoc( 1, 'e005', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING )
    set udg_TempPoint2 = GetRectCenter(gg_rct_BombTeleport)
    call SetUnitPositionLoc( GetEnumUnit(), udg_TempPoint )
    // 100% to damage (aka no RnG), to do 100 dmg is interesting.
    call CreateNUnitsAtLoc( 1, 'e006', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint2, bj_UNIT_FACING )
    set udg_TempInt=GetSector(udg_TempPoint)
    call ForGroupBJ( GetUnitsInRangeOfLocAll(400.00, udg_TempPoint), function Trig_TeleportBombExplode_Func012A )
    call RemoveLocation(udg_TempPoint)
    call RemoveLocation(udg_TempPoint2)
endfunction

//===========================================================================
function InitTrig_TeleportBombExplode takes nothing returns nothing
    set gg_trg_TeleportBombExplode = CreateTrigger(  )
    call TriggerAddAction( gg_trg_TeleportBombExplode, function Trig_TeleportBombExplode_Actions )
endfunction

