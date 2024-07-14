function Trig_RocksFallEveryoneDies_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A01Q' ) ) then
        return false
    endif
    return true
endfunction

function Trig_RocksFallEveryoneDies_Func005C takes nothing returns boolean
    if ( not ( udg_TempReal >= -600.00 ) ) then
        return false
    endif
    return true
endfunction

function Trig_RocksFallEveryoneDies_Actions takes nothing returns nothing
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
    set udg_TempReal=GetLocationZ(udg_TempPoint)
    if ( Trig_RocksFallEveryoneDies_Func005C() ) then
        call TerrainDeformationCraterBJ( 0.5, true, udg_TempPoint, 512, 150.00 )
    else
    endif
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 36
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        set udg_TempPoint2 = PolarProjectionBJ(udg_TempPoint, 512.00, ( I2R(GetForLoopIndexA()) * 10.00 ))
        call CreateDestructableLoc( 'B007', udg_TempPoint2, GetRandomDirectionDeg(), 1.00, 0 )
        call AddSpecialEffectLocBJ( udg_TempPoint2, "Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl" )
        call SFXThreadClean()
        call RemoveLocation(udg_TempPoint2)
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    call RemoveLocation(udg_TempPoint)
endfunction

//===========================================================================
function InitTrig_RocksFallEveryoneDies takes nothing returns nothing
    set gg_trg_RocksFallEveryoneDies = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_RocksFallEveryoneDies, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_RocksFallEveryoneDies, Condition( function Trig_RocksFallEveryoneDies_Conditions ) )
    call TriggerAddAction( gg_trg_RocksFallEveryoneDies, function Trig_RocksFallEveryoneDies_Actions )
endfunction

