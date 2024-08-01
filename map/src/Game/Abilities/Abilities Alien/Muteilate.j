function Trig_Muteilate_Conditions takes nothing returns boolean 
    return GetSpellAbilityId() == 'A02Y' 
endfunction 

function Trig_Muteilate_Restore_Actions takes nothing returns nothing 
    local Table timeoutData = Timeout.complete()
    local player thisPlayer = timeoutData.player.read("player")
    call ChatSilence_silencePlayer(thisPlayer, false)
    call DisplayTextToPlayer(thisPlayer, 0, 0, "|cff00FFFFYour voice returns to you!|r") 
endfunction 

function Trig_Muteilate_Actions takes nothing returns nothing 
    local Table timeoutData
    local unit targetUnit = GetSpellTargetUnit() 
    local player targetPlayer = GetOwningPlayer(targetUnit)

    if udg_Playerhero[GetConvertedPlayerId(targetPlayer)] == targetUnit then 
        call ChatSilence_silencePlayer(targetPlayer, true)
        call DisplayTextToPlayer(targetPlayer, 0, 0, "|cff00FFFFYou can no longer seem to form words...|r") 
        set timeoutData = Timeout.start(60, false, function Trig_Muteilate_Restore_Actions)
        call timeoutData.player.write("player", targetPlayer)
    endif 

    set targetUnit = null
    set targetPlayer = null
endfunction 

//===========================================================================  
function InitTrig_Muteilate takes nothing returns nothing 
    set gg_trg_Muteilate = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Muteilate, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_Muteilate, Condition(function Trig_Muteilate_Conditions)) 
    call TriggerAddAction(gg_trg_Muteilate, function Trig_Muteilate_Actions) 
endfunction 

