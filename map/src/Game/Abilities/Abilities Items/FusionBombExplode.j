function Trig_FusionBombExplode_Func006Func001Func001C takes nothing returns boolean
    if ( not ( GetDestructableTypeId(GetEnumDestructable()) != 'DTrx' ) ) then
        return false
    endif
    if ( not ( GetDestructableTypeId(GetEnumDestructable()) != 'YT40' ) ) then
        return false
    endif
    if ( not ( GetDestructableTypeId(GetEnumDestructable()) != 'YT16' ) ) then
        return false
    endif
    if ( not ( GetDestructableTypeId(GetEnumDestructable()) != 'YT06' ) ) then
        return false
    endif
    if ( not ( GetDestructableTypeId(GetEnumDestructable()) != 'YT30' ) ) then
        return false
    endif
    return true
endfunction

function Trig_FusionBombExplode_Func006Func001C takes nothing returns boolean
    if ( not Trig_FusionBombExplode_Func006Func001Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_FusionBombExplode_Func006A takes nothing returns nothing
    if ( Trig_FusionBombExplode_Func006Func001C() ) then
        call KillDestructable( GetEnumDestructable() )
    else
    endif
endfunction

function Trig_FusionBombExplode_Func010Func002C takes nothing returns boolean
    if ( not ( udg_Player_TetrabinLevel[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] <= 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_FusionBombExplode_Func010Func003C takes nothing returns boolean
    if ( not ( Player(bj_PLAYER_NEUTRAL_EXTRA) == GetOwningPlayer(GetEnumUnit()) ) ) then
        return false
    endif
    return true
endfunction

function Trig_FusionBombExplode_Func010A takes nothing returns nothing
    set udg_TempPlayer = GetOwningPlayer(GetEnumUnit())
    if ( Trig_FusionBombExplode_Func010Func002C() ) then
        call CameraSetEQNoiseForPlayer( GetOwningPlayer(GetEnumUnit()), 9.00 )
        call ExecuteFunc("BombEndShaking")
    else
    endif
    if ( Trig_FusionBombExplode_Func010Func003C() ) then
        call CinematicFilterGenericForPlayer(udg_Parasite, 6.0, BLEND_MODE_BLEND,  "ReplaceableTextures\\CameraMasks\\White_mask.blp", 100,100,100,0,0,0,0,100)
    else
        call CinematicFilterGenericForPlayer(GetOwningPlayer(GetEnumUnit()), 6.0, BLEND_MODE_BLEND,  "ReplaceableTextures\\CameraMasks\\White_mask.blp", 100,100,100,0,0,0,0,100)
    endif
endfunction

function Trig_FusionBombExplode_Func013Func002Func001Func001C takes nothing returns boolean
    if ( not ( GetUnitAbilityLevelSwapped('A03U', GetEnumUnit()) == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_FusionBombExplode_Func013Func002Func001C takes nothing returns boolean
    if ( not Trig_FusionBombExplode_Func013Func002Func001Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_FusionBombExplode_Func013Func002C takes nothing returns boolean
    if ( not ( udg_TempBool == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_FusionBombExplode_Func013A takes nothing returns nothing
    set udg_TempBool=UnitInSector(GetEnumUnit(), udg_TempInt)
    if ( Trig_FusionBombExplode_Func013Func002C() ) then
        if ( Trig_FusionBombExplode_Func013Func002Func001C() ) then
            call UnitDamageTargetBJ( udg_TempUnit, GetEnumUnit(), 5000.00, ATTACK_TYPE_MELEE, DAMAGE_TYPE_NORMAL )
        else
        endif
    else
    endif
endfunction

function Trig_FusionBombExplode_Func014Func002Func001Func001C takes nothing returns boolean
    if ( not ( GetUnitAbilityLevelSwapped('A03U', GetEnumUnit()) == 0 ) ) then
        return false
    endif
    return true
endfunction

function Trig_FusionBombExplode_Func014Func002Func001C takes nothing returns boolean
    if ( not Trig_FusionBombExplode_Func014Func002Func001Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_FusionBombExplode_Func014Func002C takes nothing returns boolean
    if ( not ( udg_TempBool == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_FusionBombExplode_Func014A takes nothing returns nothing
    set udg_TempBool=UnitInSector(GetEnumUnit(), udg_TempInt)
    if ( Trig_FusionBombExplode_Func014Func002C() ) then
        if ( Trig_FusionBombExplode_Func014Func002Func001C() ) then
            call UnitDamageTargetBJ( udg_TempUnit, GetEnumUnit(), 200.00, ATTACK_TYPE_MELEE, DAMAGE_TYPE_NORMAL )
        else
        endif
    else
    endif
endfunction

function Trig_FusionBombExplode_Actions takes nothing returns nothing
    set udg_TempUnit = udg_CountupBarTemp
    set udg_TempPoint = GetUnitLoc(udg_TempUnit)
    call SetUnitAnimation( udg_TempUnit, "decay" )
    call CreateNUnitsAtLoc( 1, 'e004', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg() )
    set udg_TempInt=GetSector(udg_TempPoint)
    call EnumDestructablesInCircleBJ( 400.00, udg_TempPoint, function Trig_FusionBombExplode_Func006A )
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 14
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        set udg_TempPoint2=IntelligentRubble(udg_TempPoint,GetRandomReal(0,800),GetRandomDirectionDeg())
        call CreateNUnitsAtLoc( 1, 'e002', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint2, GetRandomDirectionDeg() )
        call CreateDestructableLoc( 'B003', udg_TempPoint2, GetRandomDirectionDeg(), 1.00, 0 )
        call SetDestructableLifePercentBJ( GetLastCreatedDestructable(), GetRandomReal(15.00, 75.00) )
        call RemoveLocation(udg_TempPoint2)
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 6
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        set udg_TempPoint2=IntelligentRubble(udg_TempPoint,GetRandomReal(0,250),bj_forLoopAIndex*(360.0/bj_forLoopAIndexEnd))
        call CreateDestructableLoc( 'B003', udg_TempPoint2, GetRandomDirectionDeg(), 1.00, 0 )
        call SetDestructableLifePercentBJ( GetLastCreatedDestructable(), GetRandomReal(50.00, 100.00) )
        call RemoveLocation(udg_TempPoint2)
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 8
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        set udg_TempPoint2=IntelligentRubble(udg_TempPoint,GetRandomReal(250,400),bj_forLoopAIndex*(360.0/bj_forLoopAIndexEnd))
        call CreateDestructableLoc( 'B003', udg_TempPoint2, GetRandomDirectionDeg(), 1.00, 0 )
        call SetDestructableLifePercentBJ( GetLastCreatedDestructable(), GetRandomReal(50.00, 100.00) )
        call RemoveLocation(udg_TempPoint2)
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    call ForGroupBJ( GetUnitsInRangeOfLocAll(1800.00, udg_TempPoint), function Trig_FusionBombExplode_Func010A )
    call SetSoundPositionLocBJ( gg_snd_BuildingDeathLargeHuman, udg_TempPoint, 0 )
    call PlaySoundBJ( gg_snd_BuildingDeathLargeHuman )
    call ForGroupBJ( GetUnitsInRangeOfLocAll(250.00, udg_TempPoint), function Trig_FusionBombExplode_Func013A )
    call ForGroupBJ( GetUnitsInRangeOfLocAll(550.00, udg_TempPoint), function Trig_FusionBombExplode_Func014A )
    call AddSpecialEffectLoc("war3mapImported\\BlackSplat.mdl",udg_TempPoint)
    call RemoveLocation(udg_TempPoint)
endfunction

//===========================================================================
function InitTrig_FusionBombExplode takes nothing returns nothing
    set gg_trg_FusionBombExplode = CreateTrigger(  )
    call TriggerAddAction( gg_trg_FusionBombExplode, function Trig_FusionBombExplode_Actions )
endfunction

