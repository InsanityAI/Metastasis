function Trig_The_Warp_Start_Conditions takes nothing returns boolean 
    if(not(udg_Warp_enabled == false)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_The_Warp_Start_Func003A takes nothing returns nothing 
    local player p = GetOwningPlayer(GetEnumUnit()) 
    if p == Player(bj_PLAYER_NEUTRAL_EXTRA) then 
        set p = udg_Parasite 
    endif 
    call ForceAddPlayerSimple(p, udg_Warp_PG) 
    call DisplayTextToPlayer(p, 0, 0, "|CFFE55BB0Error: Teleportation UN-SUCCESFUL.|n|nLocation : U.N.K.N.O.W.N.|n|nRelocation initiating in 30 seconds.")
endfunction 

function Trig_The_Warp_Start_Func007A takes nothing returns nothing 
    call TimerDialogDisplayForPlayerBJ(true, GetLastCreatedTimerDialogBJ(), GetEnumPlayer()) 
endfunction 

function Trig_The_Warp_Start_Actions takes nothing returns nothing 
    set udg_TempUnitGroup2 = GetUnitsInRectAll(gg_rct_Warp) 
    call ForGroupBJ(udg_TempUnitGroup2, function Trig_The_Warp_Start_Func003A) 
    call StartTimerBJ(udg_WarpTimer, false, 30.00) 
    call CreateTimerDialogBJ(udg_WarpTimer, "TRIGSTR_4649") 
    call TimerDialogDisplayBJ(false, GetLastCreatedTimerDialogBJ()) 
    call ForForce(udg_Warp_PG, function Trig_The_Warp_Start_Func007A) 
    call DestroyGroup(udg_TempUnitGroup2) 
    set udg_Warp_Timer_Window = GetLastCreatedTimerDialogBJ() 
    call PlaySoundAtPointBJ(gg_snd_MarkOfChaos, 100, GetRectCenter(gg_rct_Warp), 0) 
    set udg_Warp_Effect = GetRandomLocInRect(gg_rct_Warp) 
    call AddSpecialEffectLocBJ(udg_Warp_Effect, "Abilities\\Spells\\Human\\Feedback\\ArcaneTowerAttack.mdl") 
    call DestroyEffectBJ(GetLastCreatedEffectBJ()) 
    call AddSpecialEffectLocBJ(udg_Warp_Effect, "Abilities\\Spells\\Human\\FlameStrike\\FlameStrikeTarget.mdl") 
    call DestroyEffectBJ(GetLastCreatedEffectBJ()) 
    call CreateNUnitsAtLocFacingLocBJ(1, 'n00H', Player(PLAYER_NEUTRAL_AGGRESSIVE), GetRandomLocInRect(gg_rct_Warp), GetRandomLocInRect(gg_rct_Warp)) 
    call RemoveLocation(udg_Warp_Effect) 
    call EnableTrigger(gg_trg_The_Warp_ongoing) 
    call EnableTrigger(gg_trg_The_Warp_relocation) 
    call EnableTrigger(gg_trg_The_Warp_ongoing_spawn) 
    call DisableTrigger(GetTriggeringTrigger()) 
endfunction 

//===========================================================================   
function InitTrig_The_Warp_Start takes nothing returns nothing 
    set gg_trg_The_Warp_Start = CreateTrigger() 
    call DisableTrigger(gg_trg_The_Warp_Start) 
    call TriggerAddCondition(gg_trg_The_Warp_Start, Condition(function Trig_The_Warp_Start_Conditions)) 
    call TriggerAddAction(gg_trg_The_Warp_Start, function Trig_The_Warp_Start_Actions) 
endfunction 

