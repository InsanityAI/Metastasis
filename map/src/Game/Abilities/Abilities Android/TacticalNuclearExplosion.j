//TESH.scrollpos=29
//TESH.alwaysfold=0
function Trig_TacticalNuclearExplosion_Func006Func002C takes nothing returns boolean
    if ( not ( udg_TempBool == true ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetEnumUnit()) != 'h03A' ) ) then
        return false
    endif
    if ( not ( GetUnitTypeId(GetEnumUnit()) != 'h03B' ) ) then
        return false
    endif
    return true
endfunction

function Trig_TacticalNuclearExplosion_Func006A takes nothing returns nothing
    set udg_TempBool=UnitInSector(GetEnumUnit(), udg_TempInt)
    if ( Trig_TacticalNuclearExplosion_Func006Func002C() ) then
        call UnitDamageTargetBJ( udg_TempUnit4, GetEnumUnit(), 7000.00, ATTACK_TYPE_MELEE, DAMAGE_TYPE_NORMAL )
    else
    endif
endfunction

function Trig_TacticalNuclearExplosion_Func007Func001Func001C takes nothing returns boolean
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

function Trig_TacticalNuclearExplosion_Func007Func001C takes nothing returns boolean
    if ( not Trig_TacticalNuclearExplosion_Func007Func001Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_TacticalNuclearExplosion_Func007A takes nothing returns nothing
    if ( Trig_TacticalNuclearExplosion_Func007Func001C() ) then
        call KillDestructable( GetEnumDestructable() )
    else
    endif
endfunction

function Trig_TacticalNuclearExplosion_Actions takes nothing returns nothing
local unit a=udg_CountupBarTemp
if udg_Android_Deactivated==true and udg_HiddenAndroid==GetOwningPlayer(a) then
return
endif
    set udg_TempUnit4 = udg_CountupBarTemp
    set udg_TempPoint = GetUnitLoc(udg_TempUnit4)
    call CreateNUnitsAtLoc( 1, 'e00E', Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING )
    call SetUnitTimeScalePercent( GetLastCreatedUnit(), 50.00 )
    set udg_TempInt=GetSector(udg_TempPoint)
    call ForGroupBJ( GetUnitsInRangeOfLocAll(850.00, udg_TempPoint), function Trig_TacticalNuclearExplosion_Func006A )
    call EnumDestructablesInCircleBJ( 900.00, udg_TempPoint, function Trig_TacticalNuclearExplosion_Func007A )
    call RemoveLocation( udg_TempPoint )
endfunction

//===========================================================================
function InitTrig_TacticalNuclearExplosion takes nothing returns nothing
    set gg_trg_TacticalNuclearExplosion = CreateTrigger(  )
    call TriggerAddAction( gg_trg_TacticalNuclearExplosion, function Trig_TacticalNuclearExplosion_Actions )
endfunction

