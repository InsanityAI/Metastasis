function Trig_DestroyST7_Func006A takes nothing returns nothing 
    call UnitAddAbilityBJ('A02T', GetEnumUnit()) 
    call UnitRemoveBuffsBJ(bj_REMOVEBUFFS_ALL, GetEnumUnit()) 
    call UnitRemoveAbilityBJ('A04T', GetEnumUnit()) 
    call UnitRemoveAbilityBJ('A04U', GetEnumUnit()) 
    set bj_forLoopAIndex = 1 
    set bj_forLoopAIndexEnd = 6 
    loop 
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd 
        call RemoveItem(UnitItemInSlotBJ(GetEnumUnit(), GetForLoopIndexA())) 
        set bj_forLoopAIndex = bj_forLoopAIndex + 1 
    endloop 
    call MoogleKillUnit(GetEnumUnit(), GetKillingUnit()) 
endfunction 

function Trig_DestroyST7_Func010A takes nothing returns nothing 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_MASKED, gg_rct_PirateShip) 
endfunction 

function Trig_DestroyST7_Actions takes nothing returns nothing 
    call DestroyTrigger(GetTriggeringTrigger()) 
    call DestroyTrigger(gg_trg_ST7Death) 
    call KillUnit(gg_unit_h02B_0116) 
    call ForGroupBJ(GetUnitsInRectAll(gg_rct_PirateShip), function Trig_DestroyST7_Func006A) 
    call DestroyTimerDialogBJ(udg_PirateShip_CountdownWindow) 
    call CinematicFadeBJ(bj_CINEFADETYPE_FADEOUTIN, 5.00, "ReplaceableTextures\\CameraMasks\\DreamFilter_Mask.blp", 100.00, 0, 0, 0) 
    call PolledWait(5.00) 
    call ForForce(GetPlayersAll(), function Trig_DestroyST7_Func010A) 
    call RectOfDoom(gg_rct_PirateShip) 
endfunction 

//=========================================================================== 
function InitTrig_DestroyST7 takes nothing returns nothing 
    set gg_trg_DestroyST7 = CreateTrigger() 
    call TriggerRegisterTimerExpireEventBJ(gg_trg_DestroyST7, udg_PirateShip_DestructionTimer) 
    call TriggerRegisterUnitEvent(gg_trg_DestroyST7, gg_unit_h02B_0116, EVENT_UNIT_DEATH) 
    call TriggerAddAction(gg_trg_DestroyST7, function Trig_DestroyST7_Actions) 
endfunction 

