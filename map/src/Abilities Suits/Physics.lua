//TESH.scrollpos=21
//TESH.alwaysfold=0
function Trig_Physics_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A029' ) ) then
        return false
    endif
    return true
endfunction

function DestroyContainmentPens takes nothing returns nothing
    if (GetDestructableTypeId(GetEnumDestructable()) != 'B000' and GetDestructableTypeId(GetEnumDestructable()) != 'B002' and GetDestructableTypeId(GetEnumDestructable()) != 'B004' and GetDestructableTypeId(GetEnumDestructable()) != 'B001') and GetDestructableTypeId(GetEnumDestructable()) != 'Y216' and GetDestructableTypeId(GetEnumDestructable()) != 'Y240' and GetDestructableTypeId(GetEnumDestructable()) != 'Y230' and GetDestructableTypeId(GetEnumDestructable()) != 'Y206' then
        call KillDestructable( GetEnumDestructable() )
    endif
endfunction

function Trig_Physics_Actions takes nothing returns nothing
    local unit b=GetSpellTargetUnit()
    
    set udg_TempPoint=GetUnitLoc(GetSpellAbilityUnit())
    set udg_TempPoint2=GetUnitLoc(GetSpellTargetUnit())

    //----------------------------------------
    set udg_TempReal=GetUnitX(GetSpellTargetUnit())
    set udg_TempReal2=GetUnitY(GetSpellTargetUnit())
    call SetUnitX(GetSpellAbilityUnit(), udg_TempReal)
    call SetUnitY(GetSpellAbilityUnit(), udg_TempReal2)

    set udg_TempReal=GetLocationX(udg_TempPoint)
    set udg_TempReal2=GetLocationY(udg_TempPoint)
    call SetUnitX(GetSpellTargetUnit(), udg_TempReal)
    call SetUnitY(GetSpellTargetUnit(), udg_TempReal2)
    //-----------------------------------------


    if TerrainLineCheck(udg_TempPoint , udg_TempPoint2 , 30) == true then
         //call SetUnitPositionLoc( GetSpellTargetUnit(), udg_TempPoint )
         //call SetUnitPositionLoc( GetSpellAbilityUnit(), udg_TempPoint2 )
        call AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
        call SFXThreadClean()
        call AddSpecialEffectLocBJ(udg_TempPoint2, "Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
        call SFXThreadClean()
        
        //Add invulnerability for 3.2 seconds, which is just enough to not get fbomb-cheesed.y
        call UnitAddAbilityForPeriod(b , 'Avul' , 3.2)
        
        //Destroys containment pens, so you can't trap someone with the power of annoying abuse.
        call EnumDestructablesInCircleBJ(256, udg_TempPoint, function DestroyContainmentPens)
        
        //Clean memory leaks.
        call RemoveLocation(udg_TempPoint)
        call RemoveLocation(udg_TempPoint2)
    endif
endfunction

//===========================================================================
function InitTrig_Physics takes nothing returns nothing
    set gg_trg_Physics = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Physics, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_Physics, Condition( function Trig_Physics_Conditions ) )
    call TriggerAddAction( gg_trg_Physics, function Trig_Physics_Actions )
endfunction

