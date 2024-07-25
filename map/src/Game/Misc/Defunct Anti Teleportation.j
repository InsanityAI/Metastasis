function Trig_Defunct_Anti_Teleportation_Conditions takes nothing returns boolean 
    if(not(udg_Defunct_Dead == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Defunct_Anti_Teleportation_Func007Func002C takes nothing returns boolean 
    if(not(udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] == GetTriggerUnit())) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Defunct_Anti_Teleportation_Func007C takes nothing returns boolean 
    if(not(udg_TempInt == 1)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Defunct_Anti_Teleportation_Actions takes nothing returns nothing 
    set udg_TempInt = GetRandomInt(1, 2) 
    call SetUnitPositionLoc(GetTriggerUnit(), GetRectCenter(gg_rct_BombTeleport)) 
    call AddSpecialEffectLocBJ(GetRectCenter(gg_rct_BombTeleport), "Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl") 
    call DestroyEffectBJ(GetLastCreatedEffectBJ()) 
    if(Trig_Defunct_Anti_Teleportation_Func007C()) then 
        call PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()), GetRectCenter(gg_rct_BombTeleport), 0) 
        if(Trig_Defunct_Anti_Teleportation_Func007Func002C()) then 
            call SetUnitLifeBJ(GetTriggerUnit(), (GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) -GetRandomReal(150.00, 250.00))) 
        else 
        endif 
    else 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_Defunct_Anti_Teleportation takes nothing returns nothing 
    set gg_trg_Defunct_Anti_Teleportation = CreateTrigger() 
    call TriggerRegisterEnterRectSimple(gg_trg_Defunct_Anti_Teleportation, gg_rct_ST2) 
    call TriggerAddCondition(gg_trg_Defunct_Anti_Teleportation, Condition(function Trig_Defunct_Anti_Teleportation_Conditions)) 
    call TriggerAddAction(gg_trg_Defunct_Anti_Teleportation, function Trig_Defunct_Anti_Teleportation_Actions) 
endfunction 

