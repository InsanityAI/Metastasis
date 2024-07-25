function Trig_BlackHole_Actions takes nothing returns nothing 
    call PlaySoundBJ(gg_snd_PursuitTheme) 
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_5311") 
    call DestroyTrigger(gg_trg_MoonMovement) 
    call DestroyTrigger(gg_trg_PlanetMovement) 
    call EnableTrigger(gg_trg_DragIntoSun) 
    call EnableTrigger(gg_trg_Sunpod_apocalypse) 
    call DisableTrigger(gg_trg_SunUnitInRange) 
endfunction 

//=========================================================================== 
function InitTrig_BlackHole takes nothing returns nothing 
    set gg_trg_BlackHole = CreateTrigger() 
    call TriggerAddAction(gg_trg_BlackHole, function Trig_BlackHole_Actions) 
endfunction 

