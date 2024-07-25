function Trig_NightOfTheMasksESC_Conditions takes nothing returns boolean 
    if(not(udg_Player_IsMasquerading[GetConvertedPlayerId(GetTriggerPlayer())] == true)) then 
        return false 
    endif 
    if(not(IsUnitAliveBJ(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())]) == true)) then 
        return false 
    endif 
    if RectContainsUnit(gg_rct_Space, udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())]) == true then 
        return false 
    endif 
    if RectContainsUnit(gg_rct_Timeout, udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())]) == true then 
        return false 
    endif 
    return true 
endfunction 

function Trig_NightOfTheMasksESC_Actions takes nothing returns nothing 

    local integer i = 1 
    local item v 
    local unit a 

    set udg_TempPlayer = GetTriggerPlayer() 
    set udg_TempUnit = udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)] 
    set udg_TempPoint = GetUnitLoc(udg_TempUnit) 
    set a = udg_TempUnit 
    call AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Items\\AIil\\AIilTarget.mdl") 
    call SFXThreadClean() 
    
    //If became a structure/shop/vendor  
    if(IsUnitType(a, UNIT_TYPE_STRUCTURE) == true) then 
        call ShowUnitShow(ReturnMasqueradeShop()) 
    endif 
    
    if udg_TempPlayer == udg_Parasite then 
        call CreateNUnitsAtLoc(1, udg_AlienCurrentForm, Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPoint, bj_UNIT_FACING) 
        set udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)] = GetLastCreatedUnit() 
        set udg_Playerhero[GetConvertedPlayerId(Player(bj_PLAYER_NEUTRAL_EXTRA))] = GetLastCreatedUnit() 
        set udg_AlienForm_Alien = GetLastCreatedUnit() 
        call SetPlayerColorBJ(Player(bj_PLAYER_NEUTRAL_EXTRA), ConvertPlayerColor(bj_PLAYER_NEUTRAL_EXTRA), true) 
        call SetPlayerColorBJ(udg_TempPlayer, udg_Player_MasqueradeColor[GetConvertedPlayerId(udg_TempPlayer)], true) 
    else 
        call CreateNUnitsAtLoc(1, udg_ParasiteChildInfectee, GetTriggerPlayer(), udg_TempPoint, bj_UNIT_FACING) 
        set udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)] = GetLastCreatedUnit() 
        call SetPlayerColorBJ(udg_TempPlayer, udg_Player_MasqueradeColor[GetConvertedPlayerId(udg_TempPlayer)], true) 
    endif 
    
    call SetUnitLifePercentBJ(GetLastCreatedUnit(), (udg_Player_Masquerade_Life[GetConvertedPlayerId(GetTriggerPlayer())] + GetUnitLifePercent(a)) / 2.0) 
    
    //Move items  
    loop 
        exitwhen i > 6 
        set v = LoadItemHandle(LS(), GetHandleId(GetTriggerPlayer()), StringHash("mitem_" + I2S(i))) 
        call UnitAddItem(GetLastCreatedUnit(), v) 
        set v = LoadItemHandle(LS(), GetHandleId(GetTriggerPlayer()), StringHash("kitem_" + I2S(i))) 
        call RemoveItem(v) 
        call SetItemPositionLoc(v, udg_HoldZone) 
        set i = i + 1 
    endloop 
    
    call RemoveUnit(a) 
    call RemoveLocation(udg_TempPoint) 
    call SelectUnitForPlayerSingle(GetLastCreatedUnit(), udg_TempPlayer) 
    call SetPlayerName(udg_TempPlayer, udg_Player_NameBeforeDead[GetConvertedPlayerId(GetTriggerPlayer())]) 
    set udg_Player_IsMasquerading[GetConvertedPlayerId(udg_TempPlayer)] = false 
    if udg_TempPlayer == udg_Parasite then 
        set udg_Player_IsMasquerading[GetConvertedPlayerId(Player(bj_PLAYER_NEUTRAL_EXTRA))] = false 
    endif 
endfunction 

//===========================================================================  
function InitTrig_NightOfTheMasksESC takes nothing returns nothing 
    local integer i = 0 
    set gg_trg_NightOfTheMasksESC = CreateTrigger() 
    loop 
        exitwhen i > 11 

        call TriggerRegisterPlayerEventEndCinematic(gg_trg_NightOfTheMasksESC, Player(i)) 
        set i = i + 1 
    endloop 
    call TriggerAddCondition(gg_trg_NightOfTheMasksESC, Condition(function Trig_NightOfTheMasksESC_Conditions)) 
    call TriggerAddAction(gg_trg_NightOfTheMasksESC, function Trig_NightOfTheMasksESC_Actions) 
endfunction 

