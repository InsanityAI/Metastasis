function Trig_ElectromagneticDisruption_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A03Q' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ElectromagneticDisruption_Func008Func001Func003Func003C takes nothing returns boolean
    if ( not ( udg_TempInt3 != 1337 ) ) then
        return false
    endif
    if ( not ( GetRandomInt(1, 1) == 1 ) ) then
        return false
    endif
    return true
endfunction

function Trig_ElectromagneticDisruption_Func008Func001Func003C takes nothing returns boolean
    if ( not ( udg_TempBool == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_ElectromagneticDisruption_Func008Func001Func005C takes nothing returns boolean
    if ( ( GetDestructableTypeId(GetEnumDestructable()) == 'B001' ) ) then
        return true
    endif
    if ( ( GetDestructableTypeId(GetEnumDestructable()) == 'B000' ) ) then
        return true
    endif
    return false
endfunction

function Trig_ElectromagneticDisruption_Func008Func001C takes nothing returns boolean
    if ( not Trig_ElectromagneticDisruption_Func008Func001Func005C() ) then
        return false
    endif
    return true
endfunction

function Trig_ElectromagneticDisruption_Func008A takes nothing returns nothing
    if ( Trig_ElectromagneticDisruption_Func008Func001C() ) then
        set udg_TempPoint2 = GetDestructableLoc(GetEnumDestructable())
        set udg_TempBool=LocInSector(udg_TempPoint2, udg_TempInt)
        if ( Trig_ElectromagneticDisruption_Func008Func001Func003C() ) then
            set udg_TempTrigger=LoadTriggerHandle(LS(), GetHandleId(GetEnumDestructable()), StringHash("t1")) 
            set udg_TempInt3=LoadInteger(LS(), GetHandleId(udg_TempTrigger), StringHash("clearance"))
            if ( Trig_ElectromagneticDisruption_Func008Func001Func003Func003C() ) then
                set udg_TempInt2 = ( udg_TempInt2 + 1 )
                set udg_TempPoint3 = GetDestructableLoc(GetEnumDestructable())
                call SaveInteger(LS(), GetHandleId(udg_TempTrigger), StringHash("clearance"), 1337)
                set udg_TempTrigger=LoadTriggerHandle(LS(), GetHandleId(GetEnumDestructable()), StringHash("t2")) 
                set udg_TempDoorHack = true
                call TriggerExecute( udg_TempTrigger )
                set udg_TempDoorHack = false
                call SaveInteger(LS(), GetHandleId(udg_TempTrigger), StringHash("clearance"), 1337)
                call DestructableRestoreLife(LoadDestructableHandle(LS(), GetHandleId(udg_TempTrigger),StringHash("doorpath")),999999,true)
                call AddSpecialEffectLocBJ( udg_TempPoint3, "Abilities\\Spells\\Human\\ManaFlare\\ManaFlareBoltImpact.mdl" )
                call SFXThreadClean()
                call RemoveLocation(udg_TempPoint3)
            else
            endif
        else
        endif
        call RemoveLocation(udg_TempPoint2)
    else
    endif
endfunction

function Trig_ElectromagneticDisruption_Func010C takes nothing returns boolean
    if ( not ( GetOwningPlayer(GetSpellAbilityUnit()) == Player(bj_PLAYER_NEUTRAL_EXTRA) ) ) then
        return false
    endif
    return true
endfunction

function Trig_ElectromagneticDisruption_Actions takes nothing returns nothing
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
    call AddSpecialEffectLocBJ( udg_TempPoint, "Abilities\\Spells\\Human\\ManaFlare\\ManaFlareBoltImpact.mdl" )
    call SFXThreadClean()
    set udg_TempInt=GetSector(udg_TempPoint)
    set udg_TempInt2 = 0
    call EnumDestructablesInRectAll( GetEntireMapRect(), function Trig_ElectromagneticDisruption_Func008A )
    call RemoveLocation(udg_TempPoint)
    if ( Trig_ElectromagneticDisruption_Func010C() ) then
        call DisplayTextToPlayer(udg_Parasite, 0, 0, "|cffffcc00Locked " + I2S(udg_TempInt2) + " doors.")
    else
        call DisplayTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0, "|cffffcc00Locked " + I2S(udg_TempInt2) + " doors.")
    endif
    set udg_TempUnitType = 'e00O'
    set udg_TempPlayer = GetOwningPlayer(GetSpellAbilityUnit())
    set udg_TempReal = 60.00
    call ExecuteFunc("AlienRequirementRemove")
    call ExecuteFunc("AlienRequirementRestore")
endfunction

//===========================================================================
function InitTrig_ElectromagneticDisruption takes nothing returns nothing
    set gg_trg_ElectromagneticDisruption = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_ElectromagneticDisruption, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_ElectromagneticDisruption, Condition( function Trig_ElectromagneticDisruption_Conditions ) )
    call TriggerAddAction( gg_trg_ElectromagneticDisruption, function Trig_ElectromagneticDisruption_Actions )
endfunction

