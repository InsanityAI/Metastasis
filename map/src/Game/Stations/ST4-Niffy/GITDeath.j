function Trig_GITDeath_Actions takes nothing returns nothing 
    call DestroyTrigger(gg_trg_GITDeath) 
    call DestroyTrigger(gg_trg_GIT) 
    call BloodTestingWipe() 
    call CinematicFadeBJ(bj_CINEFADETYPE_FADEOUTIN, 2.00, "ReplaceableTextures\\CameraMasks\\White_mask.blp", 0, 100.00, 0, 0) 
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_797") 
endfunction 

//=========================================================================== 
function InitTrig_GITDeath takes nothing returns nothing 
    set gg_trg_GITDeath = CreateTrigger() 
    call TriggerRegisterUnitEvent(gg_trg_GITDeath, gg_unit_h011_0100, EVENT_UNIT_DEATH) 
    call TriggerAddAction(gg_trg_GITDeath, function Trig_GITDeath_Actions) 
endfunction 

