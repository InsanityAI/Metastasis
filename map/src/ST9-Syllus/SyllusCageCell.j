function Trig_SyllusCageCell_Func002Func002Func001Func002Func002Func002C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTrainedUnit()) == 'e02Y' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SyllusCageCell_Func002Func002Func001Func002Func002C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTrainedUnit()) == 'e02X' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SyllusCageCell_Func002Func002Func001Func002C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTrainedUnit()) == 'e02W' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SyllusCageCell_Func002Func002Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTrainedUnit()) == 'e02V' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SyllusCageCell_Func002Func002C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTrainedUnit()) == 'e02U' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SyllusCageCell_Func002C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetTrainedUnit()) == 'e02T' ) ) then
        return false
    endif
    return true
endfunction

function Trig_SyllusCageCell_Func004Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetEnumUnit()) == 'h04Q' ) ) then
        return false
    endif
    if not (LoadInteger(LS(),GetHandleId(GetEnumUnit()),StringHash("Cage_Weight"))<=2) then
    return false
    endif
    if ( not ( IsUnitHiddenBJ(GetEnumUnit()) == false ) ) then
        return false
    endif
    if ( not ( IsUnitAliveBJ(GetEnumUnit()) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_SyllusCageCell_Func004A takes nothing returns nothing
    if ( Trig_SyllusCageCell_Func004Func001C() ) then
        set udg_TempBool = true
        set udg_TempUnit2 = GetEnumUnit()
    else
    endif
endfunction

function Trig_SyllusCageCell_Func005C takes nothing returns boolean
    if ( not ( udg_TempBool == false ) ) then
        return false
    endif
    return true
endfunction

function Trig_SyllusCageCell_Func007Func001C takes nothing returns boolean
    if ( not ( GetUnitPointValue(GetEnumUnit()) != 37 ) ) then
        return false
    endif
    return true
endfunction

function Trig_SyllusCageCell_Func007A takes nothing returns nothing
    if ( Trig_SyllusCageCell_Func007Func001C() ) then
        set udg_TempBool = true
        set udg_TempUnit = GetEnumUnit()
    else
    endif
endfunction

function Trig_SyllusCageCell_Func008C takes nothing returns boolean
    if ( not ( udg_TempBool == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_SyllusCageCell_Actions takes nothing returns nothing
    if ( Trig_SyllusCageCell_Func002C() ) then
        set udg_TempRect = gg_rct_Cage1
    else
        if ( Trig_SyllusCageCell_Func002Func002C() ) then
            set udg_TempRect = gg_rct_Cage2
        else
            if ( Trig_SyllusCageCell_Func002Func002Func001C() ) then
                set udg_TempRect = gg_rct_Cage3
            else
                if ( Trig_SyllusCageCell_Func002Func002Func001Func002C() ) then
                    set udg_TempRect = gg_rct_Cage4
                else
                    if ( Trig_SyllusCageCell_Func002Func002Func001Func002Func002C() ) then
                        set udg_TempRect = gg_rct_Cage5
                    else
                        if ( Trig_SyllusCageCell_Func002Func002Func001Func002Func002Func002C() ) then
                            set udg_TempRect = gg_rct_Cage6
                        else
                            return
                        endif
                    endif
                endif
            endif
        endif
    endif
    set udg_TempBool = false
    call ForGroupBJ( GetUnitsInRectAll(gg_rct_Cage_Transport), function Trig_SyllusCageCell_Func004A )
    if ( Trig_SyllusCageCell_Func005C() ) then
        call DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, "|cffffcc00Error: Unable to find a non-full cage on the transportation platform.|r")
        return
    else
    endif
    set udg_TempBool = false
    call ForGroupBJ( GetUnitsInRectAll(udg_TempRect), function Trig_SyllusCageCell_Func007A )
    if ( Trig_SyllusCageCell_Func008C() ) then
        set udg_TempPoint = GetUnitLoc(udg_TempUnit)
        call ShowUnitHide( udg_TempUnit )
        call PauseUnitBJ( true, udg_TempUnit )
        call AddSpecialEffectLocBJ( udg_TempPoint, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl" )
        call SFXThreadClean()
        call GroupAddUnit(LoadGroupHandle(LS(),GetHandleId(udg_TempUnit2),StringHash("CageGroup")),udg_TempUnit)
        call SaveInteger(LS(),GetHandleId(udg_TempUnit2),StringHash("Cage_Weight"),LoadInteger(LS(),GetHandleId(udg_TempUnit2),StringHash("Cage_Weight"))+1)
        call DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, "|cff00FF00Transfer successful!|r")
        call UnitShareVisionBJ( true, udg_TempUnit2, GetOwningPlayer(udg_TempUnit) )
        call RemoveLocation(udg_TempPoint)
        set udg_TempPoint = GetUnitLoc(udg_TempUnit2)
        call AddSpecialEffectLocBJ( udg_TempPoint, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl" )
        call SFXThreadClean()
        call RemoveLocation(udg_TempPoint)
    else
        call DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, "|cffffcc00Error: Unable to find subject in requested cell.|r")
    endif
endfunction

//===========================================================================
function InitTrig_SyllusCageCell takes nothing returns nothing
    set gg_trg_SyllusCageCell = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_SyllusCageCell, EVENT_PLAYER_UNIT_TRAIN_FINISH )
    call TriggerAddAction( gg_trg_SyllusCageCell, function Trig_SyllusCageCell_Actions )
endfunction

