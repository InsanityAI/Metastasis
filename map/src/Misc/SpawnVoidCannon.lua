//TESH.scrollpos=2
//TESH.alwaysfold=0
function Trig_SpawnVoidCannon_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'n005' ) ) then//'n005' is snoeglay warden
        return false
    endif
    return true
endfunction

function EnumCannonUnits takes nothing returns nothing
    if ( GetItemTypeId(GetItemOfTypeFromUnitBJ(GetEnumUnit(), 'I018')) == 'I018' ) then
        call AddSpecialEffectLocBJ( udg_TempPoint, "war3mapImported\\AncientExplode.mdx" )
        call DestroyEffectBJ( GetLastCreatedEffectBJ() )
        call CreateItemLoc( 'I02C', udg_TempPoint )//Create void cannon, at death of warden
    endif
endfunction

function Trig_SpawnVoidCannon_Actions takes nothing returns nothing
    set udg_TempPoint = GetUnitLoc(GetTriggerUnit())
    set udg_TempUnitGroup = GetUnitsInRangeOfLocAll(1000.00, udg_TempPoint)
    call ForGroupBJ( GetUnitsInRangeOfLocAll(1000.00, GetUnitLoc(GetTriggerUnit())), function EnumCannonUnits )
    call DestroyGroup(udg_TempUnitGroup)
    call RemoveLocation(udg_TempPoint)
endfunction

//===========================================================================
function InitTrig_SpawnVoidCannon takes nothing returns nothing
    set gg_trg_SpawnVoidCannon = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_SpawnVoidCannon, EVENT_PLAYER_UNIT_DEATH )
    call TriggerAddCondition( gg_trg_SpawnVoidCannon, Condition( function Trig_SpawnVoidCannon_Conditions ) )
    call TriggerAddAction( gg_trg_SpawnVoidCannon, function Trig_SpawnVoidCannon_Actions )
endfunction

