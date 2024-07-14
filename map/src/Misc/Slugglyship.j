function Trig_Slugglyship_Func002Func001Func001C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I018' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Slugglyship_Func002Func001C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I015' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Slugglyship_Func002C takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I013' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Slugglyship_Func003C takes nothing returns boolean
    if ( not ( GetItemLevel(GetManipulatedItem()) == 7 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Slugglyship_Actions takes nothing returns nothing
    if ( Trig_Slugglyship_Func002C() ) then
        set udg_TempPoint = GetUnitLoc(GetManipulatingUnit())
        call CreateTextTagLocBJ( "TRIGSTR_2323", udg_TempPoint, 0, 10, 100, 100, 100, 0 )
        call ShowTextTagForceBJ( true, GetLastCreatedTextTag(), GetPlayersAll() )
        call SetTextTagVelocityBJ( GetLastCreatedTextTag(), 32.00, 90 )
        call SetTextTagPermanentBJ( GetLastCreatedTextTag(), false )
        call SetTextTagLifespanBJ( GetLastCreatedTextTag(), 7.00 )
        call SetTextTagFadepointBJ( GetLastCreatedTextTag(), 5.00 )
        call RemoveLocation(udg_TempPoint)
        return
    else
        if ( Trig_Slugglyship_Func002Func001C() ) then
            set udg_TempPoint = GetUnitLoc(GetManipulatingUnit())
            call CreateTextTagLocBJ( "TRIGSTR_2343", udg_TempPoint, 0, 10, 100, 100, 100, 0 )
            call ShowTextTagForceBJ( true, GetLastCreatedTextTag(), GetPlayersAll() )
            call SetTextTagVelocityBJ( GetLastCreatedTextTag(), 32.00, 90 )
            call SetTextTagPermanentBJ( GetLastCreatedTextTag(), false )
            call SetTextTagLifespanBJ( GetLastCreatedTextTag(), 7.00 )
            call SetTextTagFadepointBJ( GetLastCreatedTextTag(), 5.00 )
            call RemoveLocation(udg_TempPoint)
            call UnitRemoveItemSwapped( GetManipulatedItem(), gg_unit_n006_0218 )
            return
        else
            if ( Trig_Slugglyship_Func002Func001Func001C() ) then
                call DestroyTrigger(GetTriggeringTrigger())
                set udg_TempPoint = GetUnitLoc(GetManipulatingUnit())
                call CreateTextTagLocBJ( "TRIGSTR_2340", udg_TempPoint, 0, 10, 100, 100, 100, 0 )
                call ShowTextTagForceBJ( true, GetLastCreatedTextTag(), GetPlayersAll() )
                call SetTextTagVelocityBJ( GetLastCreatedTextTag(), 32.00, 90 )
                call SetTextTagPermanentBJ( GetLastCreatedTextTag(), false )
                call SetTextTagLifespanBJ( GetLastCreatedTextTag(), 7.00 )
                call SetTextTagFadepointBJ( GetLastCreatedTextTag(), 5.00 )
                call RemoveLocation(udg_TempPoint)
                call PolledWait( 7.00 )
                set udg_TempPoint = GetUnitLoc(gg_unit_n006_0218)
                call CreateTextTagLocBJ( "TRIGSTR_2341", udg_TempPoint, 0, 10, 100, 100, 100, 0 )
                call ShowTextTagForceBJ( true, GetLastCreatedTextTag(), GetPlayersAll() )
                call SetTextTagVelocityBJ( GetLastCreatedTextTag(), 32.00, 90 )
                call SetTextTagPermanentBJ( GetLastCreatedTextTag(), false )
                call SetTextTagLifespanBJ( GetLastCreatedTextTag(), 7.00 )
                call SetTextTagFadepointBJ( GetLastCreatedTextTag(), 5.00 )
                call AddSpecialEffectLocBJ( udg_TempPoint, "war3mapImported\\AncientExplode.mdx" )
                call SFXThreadClean()
                call RemoveLocation(udg_TempPoint)
                call PolledWait( 4.00 )
                call SetUnitPositionLoc( gg_unit_h03J_0180, GetRandomLocInRect(gg_rct_Space) )
                set udg_TempPoint = GetUnitLoc(gg_unit_n006_0218)
                call CreateTextTagLocBJ( "TRIGSTR_2342", udg_TempPoint, 0, 10, 100, 100, 100, 0 )
                call ShowTextTagForceBJ( true, GetLastCreatedTextTag(), GetPlayersAll() )
                call SetTextTagVelocityBJ( GetLastCreatedTextTag(), 32.00, 90 )
                call SetTextTagPermanentBJ( GetLastCreatedTextTag(), false )
                call SetTextTagLifespanBJ( GetLastCreatedTextTag(), 7.00 )
                call SetTextTagFadepointBJ( GetLastCreatedTextTag(), 5.00 )
                call AddSpecialEffectLocBJ( udg_TempPoint, "war3mapImported\\AncientExplode.mdx" )
                call CreateNUnitsAtLoc( 12, 'nshe', Player(PLAYER_NEUTRAL_PASSIVE), GetRectCenter(gg_rct_SS13), bj_UNIT_FACING )
                call SFXThreadClean()
                call RemoveLocation(udg_TempPoint)
                set udg_TempUnit = gg_unit_h03K_0181
                set udg_TempUnit2 = gg_unit_h03J_0180
                set udg_TempUnit3 = gg_unit_h004_0179
                set udg_TempRect = gg_rct_SS13
                set udg_TempRect2 = gg_rct_SS13EE
                set udg_TempRect3 = gg_rct_SS13Control
                set udg_SS_Harbor[GetUnitUserData(gg_unit_h03K_0181)] = null
                set udg_SS_DockGroundedAt[GetUnitUserData(gg_unit_h03K_0181)] = 0
                call Spaceship_Build(udg_TempUnit, udg_TempUnit2, udg_TempUnit3, udg_TempRect, udg_TempRect2, udg_TempRect3,26)
                return
            else
            endif
        endif
    endif
    if ( Trig_Slugglyship_Func003C() ) then
        set udg_TempPoint = GetUnitLoc(GetManipulatingUnit())
        call CreateTextTagLocBJ( "TRIGSTR_2321", udg_TempPoint, 0, 10, 100, 100, 100, 0 )
        call ShowTextTagForceBJ( true, GetLastCreatedTextTag(), GetPlayersAll() )
        call SetTextTagVelocityBJ( GetLastCreatedTextTag(), 32.00, 90 )
        call SetTextTagPermanentBJ( GetLastCreatedTextTag(), false )
        call SetTextTagLifespanBJ( GetLastCreatedTextTag(), 7.00 )
        call SetTextTagFadepointBJ( GetLastCreatedTextTag(), 5.00 )
        call RemoveLocation(udg_TempPoint)
    else
        set udg_TempPoint = GetUnitLoc(GetManipulatingUnit())
        call CreateTextTagLocBJ( "TRIGSTR_2322", udg_TempPoint, 0, 10, 100, 100, 100, 0 )
        call ShowTextTagForceBJ( true, GetLastCreatedTextTag(), GetPlayersAll() )
        call SetTextTagVelocityBJ( GetLastCreatedTextTag(), 32.00, 90 )
        call SetTextTagPermanentBJ( GetLastCreatedTextTag(), false )
        call SetTextTagLifespanBJ( GetLastCreatedTextTag(), 7.00 )
        call SetTextTagFadepointBJ( GetLastCreatedTextTag(), 5.00 )
        call RemoveLocation(udg_TempPoint)
    endif
    call UnitRemoveItemSwapped( GetManipulatedItem(), gg_unit_n006_0218 )
endfunction

//===========================================================================
function InitTrig_Slugglyship takes nothing returns nothing
    set gg_trg_Slugglyship = CreateTrigger(  )
    call TriggerRegisterUnitEvent( gg_trg_Slugglyship, gg_unit_n006_0218, EVENT_UNIT_PICKUP_ITEM )
    call TriggerAddAction( gg_trg_Slugglyship, function Trig_Slugglyship_Actions )
endfunction

