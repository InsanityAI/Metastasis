function Trig_The_Warp_relocation_Func005A takes nothing returns nothing
    call RemoveUnit( GetEnumUnit() )
endfunction

function Trig_The_Warp_relocation_Func009Func001C takes nothing returns boolean
    if ( not ( GetUnitTypeId(GetEnumUnit()) == 'H03I' ) ) then
        return false
    endif
    return true
endfunction

function Trig_The_Warp_relocation_Func009A takes nothing returns nothing
    if ( Trig_The_Warp_relocation_Func009Func001C() ) then
    else
        call SetUnitPositionLoc( GetEnumUnit(), udg_TempPoint2 )
        call DisplayTextToPlayer(GetOwningPlayer(GetEnumUnit()), 0, 0, "Relocation Succesful.")
    endif
endfunction

function Trig_The_Warp_relocation_Func013A takes nothing returns nothing
    call RemoveItem( GetEnumItem() )
endfunction

function Trig_The_Warp_relocation_Func014A takes nothing returns nothing
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_MASKED, gg_rct_Warp )
endfunction

function Trig_The_Warp_relocation_Actions takes nothing returns nothing
    call PauseTimerBJ( true, udg_WarpTimer )
    set udg_TempPoint2 = GetRectCenter(gg_rct_BombTeleport)
    set udg_TempUnitGroup = GetUnitsInRectOfPlayer(gg_rct_Warp, Player(PLAYER_NEUTRAL_AGGRESSIVE))
    call ForGroupBJ( udg_TempUnitGroup, function Trig_The_Warp_relocation_Func005A )
    call DestroyGroup(udg_TempUnitGroup)
    // csa\c\a
    set udg_TempUnitGroup = GetUnitsInRectAll(gg_rct_Warp)
    call ForGroupBJ( udg_TempUnitGroup, function Trig_The_Warp_relocation_Func009A )
    call DestroyTimerDialogBJ( udg_Warp_Timer_Window )
    set udg_TPareafail = 0
    call DestroyGroup(udg_TempUnitGroup)
    call EnumItemsInRectBJ( gg_rct_Warp, function Trig_The_Warp_relocation_Func013A )
    call ForForce( GetPlayersAll(), function Trig_The_Warp_relocation_Func014A )
    call AddSpecialEffectLocBJ( GetRectCenter(gg_rct_BombTeleport), "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl" )
    call DestroyEffectBJ( GetLastCreatedEffectBJ() )
    call DestroyGroup(udg_TempUnitGroup)
    call RemoveLocation(udg_TempPoint2)
    call DisableTrigger( gg_trg_Warp_Artificial_Intelligence )
    call DisableTrigger( gg_trg_The_Warp_ongoing )
    call DisableTrigger( gg_trg_The_Warp_ongoing_spawn )
endfunction

//===========================================================================
function InitTrig_The_Warp_relocation takes nothing returns nothing
    set gg_trg_The_Warp_relocation = CreateTrigger(  )
    call TriggerRegisterTimerExpireEventBJ( gg_trg_The_Warp_relocation, udg_WarpTimer )
    call TriggerAddAction( gg_trg_The_Warp_relocation, function Trig_The_Warp_relocation_Actions )
endfunction

