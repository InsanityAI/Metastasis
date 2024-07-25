function Trig_Sound_Func005A takes nothing returns nothing 
    call SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_RESOURCE_LUMBER, 0) 
endfunction 

function Trig_Sound_Actions takes nothing returns nothing 
    // Plays that one sound at the beginning and locks alliance settings. 
    call PlaySoundBJ(gg_snd_TempleOfTheDamnedWhat) 
    call SetMapFlag(MAP_LOCK_ALLIANCE_CHANGES, true) 
    call ForForce(GetPlayersAll(), function Trig_Sound_Func005A) 
    call DestroyTrigger(GetTriggeringTrigger()) 
endfunction 

//=========================================================================== 
function InitTrig_Sound takes nothing returns nothing 
    set gg_trg_Sound = CreateTrigger() 
    call TriggerRegisterTimerEventSingle(gg_trg_Sound, 0.00) 
    call TriggerAddAction(gg_trg_Sound, function Trig_Sound_Actions) 
endfunction 

