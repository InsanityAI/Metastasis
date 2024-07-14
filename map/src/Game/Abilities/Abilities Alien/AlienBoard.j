function Trig_AlienBoard_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A03B' ) ) then
        return false
    endif
    return true
endfunction

function Trig_AlienBoard_Func004Func001Func002Func001Func001Func001Func001Func001Func001Func001Func001Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSpellTargetUnit()) == 'h03T' ) ) then
        return false
    endif
    return true
endfunction

function Trig_AlienBoard_Func004Func001Func002Func001Func001Func001Func001Func001Func001Func001Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSpellTargetUnit()) == 'h04G' ) ) then
        return false
    endif
    return true
endfunction

function Trig_AlienBoard_Func004Func001Func002Func001Func001Func001Func001Func001Func001Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSpellTargetUnit()) == 'h029' ) ) then
        return false
    endif
    return true
endfunction

function Trig_AlienBoard_Func004Func001Func002Func001Func001Func001Func001Func001Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSpellTargetUnit()) == 'h009' ) ) then
        return false
    endif
    return true
endfunction

function Trig_AlienBoard_Func004Func001Func002Func001Func001Func001Func001Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSpellTargetUnit()) == 'h003' ) ) then
        return false
    endif
    return true
endfunction

function Trig_AlienBoard_Func004Func001Func002Func001Func001Func001Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSpellTargetUnit()) == 'h008' ) ) then
        return false
    endif
    return true
endfunction

function Trig_AlienBoard_Func004Func001Func002Func001Func001Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSpellTargetUnit()) == 'h007' ) ) then
        return false
    endif
    return true
endfunction

function Trig_AlienBoard_Func004Func001Func002Func001Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSpellTargetUnit()) == 'h005' ) ) then
        return false
    endif
    return true
endfunction

function Trig_AlienBoard_Func004Func001Func002Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSpellTargetUnit()) == 'h00X' ) ) then
        return false
    endif
    return true
endfunction

function Trig_AlienBoard_Func004Func001Func002C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetSpellTargetUnit()) == 'h02B' ) ) then
        return false
    endif
    return true
endfunction

function Trig_AlienBoard_Func004Func001Func003C takes nothing returns boolean
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'h04G' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'h02B' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'h00X' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'h005' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'h007' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'h008' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'h03T' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'h003' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'h009' ) ) then
        return true
    endif
    if ( ( GetUnitTypeId(GetSpellTargetUnit()) == 'h029' ) ) then
        return true
    endif
    return false
endfunction

function Trig_AlienBoard_Func004Func001C takes nothing returns boolean
    if ( not Trig_AlienBoard_Func004Func001Func003C() ) then
        return false
    endif
    return true
endfunction

function Trig_AlienBoard_Func004Func002C takes nothing returns boolean
    if IsUnitExplorer(GetSpellTargetUnit()) then
    return true
    endif
    return false
endfunction

function Trig_AlienBoard_Func004C takes nothing returns boolean
    if ( not Trig_AlienBoard_Func004Func002C() ) then
        return false
    endif
    return true
endfunction

function Trig_AlienBoard_Func011C takes nothing returns boolean
    if ( not ( GetOwningPlayer(udg_TempUnit3) == Player(bj_PLAYER_NEUTRAL_EXTRA) ) ) then
        return false
    endif
    return true
endfunction

function Trig_AlienBoard_Func014C takes nothing returns boolean
    if ( not ( GetOwningPlayer(udg_TempUnit3) == Player(bj_PLAYER_NEUTRAL_EXTRA) ) ) then
        return false
    endif
    return true
endfunction

function Trig_AlienBoard_Actions takes nothing returns nothing
    set udg_TempUnit3 = GetSpellAbilityUnit()
    if ( Trig_AlienBoard_Func004C() ) then
        set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
        set udg_TempPoint2 = GetRectCenter(udg_Spaceship_EnterExit[GetUnitUserData(udg_SS_Landed[GetUnitUserData(GetSpellTargetUnit())])])
    else
        if ( Trig_AlienBoard_Func004Func001C() ) then
            if ( Trig_AlienBoard_Func004Func001Func002C() ) then
                set udg_TempPoint2 = GetRectCenter(gg_rct_PirateABEnter)
            else
                if ( Trig_AlienBoard_Func004Func001Func002Func001C() ) then
                    set udg_TempPoint2 = GetRectCenter(gg_rct_ST5EscapePod)
                else
                    if ( Trig_AlienBoard_Func004Func001Func002Func001Func001C() ) then
                        set udg_TempPoint2 = GetRectCenter(gg_rct_ST2)
                    else
                        if ( Trig_AlienBoard_Func004Func001Func002Func001Func001Func001C() ) then
                            set udg_TempPoint2 = GetRectCenter(gg_rct_ST3EscapePod)
                        else
                            if ( Trig_AlienBoard_Func004Func001Func002Func001Func001Func001Func001C() ) then
                                set udg_TempPoint2 = GetRectCenter(gg_rct_PlanetEscapePod)
                            else
                                if ( Trig_AlienBoard_Func004Func001Func002Func001Func001Func001Func001Func001C() ) then
                                    set udg_TempPoint2 = GetRectCenter(gg_rct_ST1EscapePod)
                                else
                                    if ( Trig_AlienBoard_Func004Func001Func002Func001Func001Func001Func001Func001Func001C() ) then
                                        set udg_TempPoint2 = GetRectCenter(gg_rct_ST4EscapePod)
                                    else
                                        if ( Trig_AlienBoard_Func004Func001Func002Func001Func001Func001Func001Func001Func001Func001C() ) then
                                            set udg_TempPoint2 = GetRectCenter(gg_rct_LostStation)
                                        else
                                            if ( Trig_AlienBoard_Func004Func001Func002Func001Func001Func001Func001Func001Func001Func001Func001C() ) then
                                                set udg_TempPoint2 = GetRectCenter(gg_rct_OverlordPod)
                                            else
                                                if ( Trig_AlienBoard_Func004Func001Func002Func001Func001Func001Func001Func001Func001Func001Func001Func001C() ) then
                                                    set udg_TempPoint2 = GetRectCenter(gg_rct_MoonEscapePod)
                                                else
                                                endif
                                            endif
                                        endif
                                    endif
                                endif
                            endif
                        endif
                    endif
                endif
            endif
            set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
        else
            return
        endif
    endif
    call AddSpecialEffectLocBJ( udg_TempPoint, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl" )
    call SFXThreadClean()
    call AddSpecialEffectLocBJ( udg_TempPoint2, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl" )
    call SFXThreadClean()
    call SetUnitPositionLoc( udg_TempUnit3, udg_TempPoint2 )
    call UnitRemoveTypeBJ( UNIT_TYPE_FLYING, udg_TempUnit3 )
    if ( Trig_AlienBoard_Func011C() ) then
        call PanCameraToTimedLocForPlayer( udg_Parasite, udg_TempPoint2, 0 )
    else
        call PanCameraToTimedLocForPlayer( GetOwningPlayer(udg_TempUnit3), udg_TempPoint2, 0 )
    endif
    set bj_forLoopAIndex = 1
    set bj_forLoopAIndexEnd = 6
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        set udg_TempItem=LoadItemHandle(LS(), GetHandleId(udg_TempUnit3), StringHash("ihold" + I2S(bj_forLoopAIndex)))
        call SetItemVisibleBJ( true, udg_TempItem )
        call UnitAddItemSwapped( udg_TempItem, udg_TempUnit3 )
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    call SetUnitMoveSpeed( udg_TempUnit3, ( GetUnitDefaultMoveSpeed(udg_TempUnit3) / 1.00 ) )
    if ( Trig_AlienBoard_Func014C() ) then
        call UnitAddAbilityBJ( 'A02S', udg_TempUnit3 )
        call UnitAddAbilityBJ( 'A03I', udg_TempUnit3 )
        call SetUnitScalePercent( udg_TempUnit3, 100.00, 100.00, 100.00 )
    else
        call UnitAddAbilityBJ( 'A02X', udg_TempUnit3 )
        call SetUnitScalePercent( udg_TempUnit3, 85.00, 85.00, 85.00 )
    endif
    call UnitAddAbilityBJ( 'A03C', udg_TempUnit3 )
    call UnitAddAbilityBJ( 'AInv', udg_TempUnit3 )
    call UnitRemoveAbilityBJ( 'A03B', udg_TempUnit3 )
    call UnitRemoveAbilityBJ( 'A03H', udg_TempUnit3 )
    call UnitRemoveAbilityBJ( 'A03G', udg_TempUnit3 )
    set udg_TempUnitType = 'e00M'
    set udg_TempPlayer = GetOwningPlayer(udg_TempUnit3)
    set udg_TempReal = 60.00
    call ExecuteFunc("AlienRequirementRestore")
    call UnitAddAbilityForPeriod(udg_TempUnit3,'Avul',3.0)
endfunction

//===========================================================================
function InitTrig_AlienBoard takes nothing returns nothing
    set gg_trg_AlienBoard = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_AlienBoard, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_AlienBoard, Condition( function Trig_AlienBoard_Conditions ) )
    call TriggerAddAction( gg_trg_AlienBoard, function Trig_AlienBoard_Actions )
endfunction

