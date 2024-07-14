//TESH.scrollpos=57
//TESH.alwaysfold=0
function Trig_Coreoverload_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A06C' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Coreoverload_Func008Func001Func001C takes nothing returns boolean
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

function Trig_Coreoverload_Func008Func001C takes nothing returns boolean
    if ( not Trig_Coreoverload_Func008Func001Func001C() ) then
        return false
    endif
    return true
endfunction

function Trig_Coreoverload_Func008A takes nothing returns nothing
    if ( Trig_Coreoverload_Func008Func001C() ) then
       //call KillDestructable( GetEnumDestructable() )
       call UnitDamageTarget(GetSpellAbilityUnit(),GetEnumDestructable(),2550.0,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
    else
    endif
endfunction

function Coreoverload_Explosion takes nothing returns nothing
    set udg_TempBool=UnitInSector(GetEnumUnit(), udg_TempInt)
    if udg_TempBool then
        call UnitDamageTargetBJ( udg_TempUnit, GetEnumUnit(), 700.00, ATTACK_TYPE_MELEE, DAMAGE_TYPE_NORMAL )
    else
    endif
endfunction


function Trig_Coreoverload_Actions takes nothing returns nothing
local group g
local unit r=GetSpellAbilityUnit()
    set udg_TempUnit = GetSpellAbilityUnit()
    set udg_TempPoint = GetUnitLoc(udg_TempUnit)
    call CreateNUnitsAtLoc( 1, 'e00E', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg() )
    call SetUnitScalePercent( GetLastCreatedUnit(), 75.00, 75.00, 75.00 )
    call UnitDamageTargetBJ( r, r, 150.00, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL )
    set udg_TempInt=GetSector(udg_TempPoint)
    call EnumDestructablesInCircleBJ( 500.00, udg_TempPoint, function Trig_Coreoverload_Func008A )
    set udg_TempReal=GetLocationZ(udg_TempPoint)
    if udg_TempReal >= -600.00 then
        call TerrainDeformationCraterBJ( 0.5, true, udg_TempPoint, 512, 40.00 )
    else
    endif
        call SetUnitTimeScalePercent(CreateUnitAtLoc(GetOwningPlayer(udg_TempUnit), 'e01T', udg_TempPoint, GetRandomDirectionDeg()), 0.0)
      set g=GetUnitsInRangeOfLocAll(425.0,udg_TempPoint)
      set udg_TempUnit=r
      call GroupRemoveUnit(g,udg_TempUnit)
      call ForGroup(g, function Coreoverload_Explosion )
      call DestroyGroup(g)
  call RemoveLocation( udg_TempPoint )
        endfunction

//===========================================================================
function InitTrig_Coreoverload takes nothing returns nothing
    set gg_trg_Coreoverload = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Coreoverload, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_Coreoverload, Condition( function Trig_Coreoverload_Conditions ) )
    call TriggerAddAction( gg_trg_Coreoverload, function Trig_Coreoverload_Actions )
endfunction

