function Trig_CarrierSackExplode_Func004A takes nothing returns nothing
    call UnitDamageTargetBJ( udg_TempUnit4, GetEnumUnit(), 1000.00, ATTACK_TYPE_MELEE, DAMAGE_TYPE_NORMAL )
endfunction

function Trig_CarrierSackExplode_Func005A takes nothing returns nothing
    call UnitDamageTargetBJ( udg_TempUnit4, GetEnumUnit(), 125.00, ATTACK_TYPE_MELEE, DAMAGE_TYPE_NORMAL )
endfunction

function Trig_CarrierSackExplode_Func006Func001C takes nothing returns boolean
    if ( not ( GetDestructableTypeId(GetEnumDestructable()) != 'DTrx' ) ) then
        return false
    endif
    return true
endfunction

function Trig_CarrierSackExplode_Func006A takes nothing returns nothing
    if ( Trig_CarrierSackExplode_Func006Func001C() ) then
        call KillDestructable( GetEnumDestructable() )
    else
    endif
endfunction

function Trig_CarrierSackExplode_Func008A takes nothing returns nothing
    set udg_TempPlayer = GetOwningPlayer(GetEnumUnit())
    call CinematicFilterGenericForPlayer(GetOwningPlayer(GetEnumUnit()), 2.0, BLEND_MODE_BLEND,  "ReplaceableTextures\\CameraMasks\\White_mask.blp", 100,0,0,0,0,0,0,100)
endfunction

function Trig_CarrierSackExplode_Actions takes nothing returns nothing
    set udg_TempUnit4 = udg_CountupBarTemp
    set udg_TempPoint = GetUnitLoc(udg_TempUnit4)
    call CreateNUnitsAtLoc( 1, 'e00A', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg() )
    call ForGroupBJ( GetUnitsInRangeOfLocAll(200.00, udg_TempPoint), function Trig_CarrierSackExplode_Func004A )
    call ForGroupBJ( GetUnitsInRangeOfLocAll(400.00, udg_TempPoint), function Trig_CarrierSackExplode_Func005A )
    call EnumDestructablesInCircleBJ( 300.00, udg_TempPoint, function Trig_CarrierSackExplode_Func006A )
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 5
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        set udg_TempPoint2 = PolarProjectionBJ(udg_TempPoint, GetRandomReal(0, 400.00), GetRandomDirectionDeg())
        call CreateNUnitsAtLoc( 1, 'e00A', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint2, bj_UNIT_FACING )
        call CreateDestructableLoc( 'B003', udg_TempPoint2, GetRandomDirectionDeg(), 1.00, 0 )
        call RemoveLocation(udg_TempPoint2)
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    call ForGroupBJ( GetUnitsInRangeOfLocAll(900.00, udg_TempPoint), function Trig_CarrierSackExplode_Func008A )
    call SetSoundPositionLocBJ( gg_snd_EggSackDeath1, udg_TempPoint, 0 )
    call PlaySoundBJ( gg_snd_EggSackDeath1 )
    call RemoveLocation(udg_TempPoint)
endfunction

//===========================================================================
function InitTrig_CarrierSackExplode takes nothing returns nothing
    set gg_trg_CarrierSackExplode = CreateTrigger(  )
    call TriggerAddAction( gg_trg_CarrierSackExplode, function Trig_CarrierSackExplode_Actions )
endfunction

