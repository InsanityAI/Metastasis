function Trig_SlugglyDeath_Conditions takes nothing returns boolean 
    if(not('n003' == GetUnitTypeId(GetDyingUnit()))) then 
        return false 
    endif 
    if(not(udg_Player_Slugglied[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_SlugglyDeath_Func004Func001C takes nothing returns boolean 
    if(not(IsPlayerInForce(GetEnumPlayer(), udg_DeadGroup) == false)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_SlugglyDeath_Func004A takes nothing returns nothing 
    if(Trig_SlugglyDeath_Func004Func001C()) then 
        call SetPlayerAllianceStateBJ(GetEnumPlayer(), GetTriggerPlayer(), bj_ALLIANCE_ALLIED_VISION) 
        call SetPlayerAllianceStateBJ(GetTriggerPlayer(), GetEnumPlayer(), bj_ALLIANCE_ALLIED_VISION) 
        set udg_Player_Slugglied[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] = false 
    else 
    endif 
endfunction 

function Trig_SlugglyDeath_Actions takes nothing returns nothing 
    call ForForce(GetPlayersAll(), function Trig_SlugglyDeath_Func004A) 
endfunction 

//=========================================================================== 
function InitTrig_SlugglyDeath takes nothing returns nothing 
    set gg_trg_SlugglyDeath = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_SlugglyDeath, EVENT_PLAYER_UNIT_DEATH) 
    call TriggerAddCondition(gg_trg_SlugglyDeath, Condition(function Trig_SlugglyDeath_Conditions)) 
    call TriggerAddAction(gg_trg_SlugglyDeath, function Trig_SlugglyDeath_Actions) 
endfunction 

