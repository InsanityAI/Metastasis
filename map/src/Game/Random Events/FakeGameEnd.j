function Trig_FakeGameEnd_Func001Func007A takes nothing returns nothing 
    call SetUnitAnimation(GetEnumUnit(), "victory") 
endfunction 

function Trig_FakeGameEnd_Func001C takes nothing returns boolean 
    if(not(GetRandomInt(1, 6) == 1)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_FakeGameEnd_Actions takes nothing returns nothing 
    if(Trig_FakeGameEnd_Func001C()) then 
        call DestroyTrigger(GetTriggeringTrigger()) 
        call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4183") 
        call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4184") 
        call PlaySoundBJ(gg_snd_HumanVictory) 
        set udg_RandomEvent_On[15] = true 
        call PolledWait(2.00) 
        call ForGroupBJ(GetUnitsInRectAll(GetPlayableMapRect()), function Trig_FakeGameEnd_Func001Func007A) 
        call PolledWait(4.00) 
        call StopSoundBJ(gg_snd_HumanVictory, false) 
        call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4185") 
    else 
    endif 
    call StartTimerBJ(udg_RandomEvent, false, GetRandomReal(10.00, 300.00)) 
endfunction 

//=========================================================================== 
function InitTrig_FakeGameEnd takes nothing returns nothing 
    set gg_trg_FakeGameEnd = CreateTrigger() 
    call DisableTrigger(gg_trg_FakeGameEnd) 
    call TriggerAddAction(gg_trg_FakeGameEnd, function Trig_FakeGameEnd_Actions) 
endfunction 

