function Trig_BlackHoleDevice_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A05N' ) ) then
        return false
    endif
    return true
endfunction

function Trig_BlackHoleDevice_Actions takes nothing returns nothing
    set udg_TempPoint = GetSpellTargetLoc()
    call SetSoundPositionLocBJ( gg_snd_NecropolisUpgrade1, udg_TempPoint, 0 )
    call PlaySoundBJ( gg_snd_NecropolisUpgrade1 )
    call CreateNUnitsAtLoc( 1, 'h02J', GetOwningPlayer(GetSpellAbilityUnit()), udg_TempPoint, bj_UNIT_FACING )
    call RemoveLocation(udg_TempPoint)
    set udg_TempUnit = GetLastCreatedUnit()
    set udg_CountUpBarColor = "|cff804000"
    call BasicAI_IssueDangerArea(udg_TempPoint,800.0,3.1)
    call CountUpBar(udg_TempUnit, 60, 0.1666666666667, "BlackHoleExplosion")
    call KillUnit( gg_unit_h012_0217 )
    call DisplayTextToForce(GetPlayersAll(), "|cffFF0000Emergency News!")
    call DisplayTextToForce(GetPlayersAll(), "|cffFF0000A delayed U.S.I. Weather Forecast reports that a black hole should soon be visible in the sector.")
    call DisplayTextToForce(GetPlayersAll(), "|cffFF0000The metadata suggests it was broadcasted days ago and reached only now, so it must be accurate.")
endfunction

//===========================================================================
function InitTrig_BlackHoleDevice takes nothing returns nothing
    set gg_trg_BlackHoleDevice = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_BlackHoleDevice, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_BlackHoleDevice, Condition( function Trig_BlackHoleDevice_Conditions ) )
    call TriggerAddAction( gg_trg_BlackHoleDevice, function Trig_BlackHoleDevice_Actions )
endfunction

