function Trig_AlienEgg_Conditions takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTriggerUnit()) == 'e01H' ) ) then
        return false
    endif
    return true
endfunction

function Trig_AlienEgg_Func003C takes nothing returns boolean
    if ( not ( CountUnitsInGroup(udg_Parasite_EggGroup) >= 3 ) ) then
        return false
    endif
    return true
endfunction

function Trig_AlienEgg_Actions takes nothing returns nothing
    if ( Trig_AlienEgg_Func003C() ) then
        call KillUnit( GetTriggerUnit() )
    else
        set udg_TempPoint = GetUnitLoc(GetTriggerUnit())
        call AddSpecialEffectLocBJ( udg_TempPoint, "Objects\\Spawnmodels\\NightElf\\EntBirthTarget\\EntBirthTarget.mdl" )
        call SFXThreadClean()
        call GroupAddUnitSimple( GetTriggerUnit(), udg_Parasite_EggGroup )
        call RemoveLocation(udg_TempPoint)
    endif
endfunction

//===========================================================================
function InitTrig_AlienEgg takes nothing returns nothing
    set gg_trg_AlienEgg = CreateTrigger(  )
    call TriggerRegisterEnterRectSimple( gg_trg_AlienEgg, GetPlayableMapRect() )
    call TriggerAddCondition( gg_trg_AlienEgg, Condition( function Trig_AlienEgg_Conditions ) )
    call TriggerAddAction( gg_trg_AlienEgg, function Trig_AlienEgg_Actions )
endfunction

