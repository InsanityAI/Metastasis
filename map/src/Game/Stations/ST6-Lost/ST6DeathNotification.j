function Trig_ST6DeathNotification_Actions takes nothing returns nothing 
    call CinematicFadeBJ(bj_CINEFADETYPE_FADEOUTIN, 7.00, "ReplaceableTextures\\CameraMasks\\DreamFilter_Mask.blp", 100.00, 0, 0, 0) 
    call PlaySoundBJ(gg_snd_NecropolisUpgrade1) 
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5198") 
    call TriggerExecute(gg_trg_ST6Death) 
endfunction 

//=========================================================================== 
function InitTrig_ST6DeathNotification takes nothing returns nothing 
    set gg_trg_ST6DeathNotification = CreateTrigger() 
    call TriggerRegisterUnitEvent(gg_trg_ST6DeathNotification, gg_unit_h029_0114, EVENT_UNIT_DEATH) 
    call TriggerAddAction(gg_trg_ST6DeathNotification, function Trig_ST6DeathNotification_Actions) 
endfunction 

