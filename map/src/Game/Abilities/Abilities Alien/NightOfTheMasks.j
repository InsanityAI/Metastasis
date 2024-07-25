function Trig_NightOfTheMasks_Func002C takes nothing returns boolean 
    if((true == true)) then 
        return true 
    endif 
    if((udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] == GetSpellTargetUnit())) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_NightOfTheMasks_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A03K')) then 
        return false 
    endif 
    if(not Trig_NightOfTheMasks_Func002C()) then 
        return false 
    endif 
    if(not(udg_Player_IsMasquerading[GetConvertedPlayerId(GetOwningPlayer(GetSpellAbilityUnit()))] == false)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_NightOfTheMasks_Func016C takes nothing returns boolean 
    if(not(udg_TempPlayer == Player(bj_PLAYER_NEUTRAL_EXTRA))) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_NightOfTheMasks_Func021C takes nothing returns boolean 
    if(not(IsUnitType(udg_TempUnit2, UNIT_TYPE_STRUCTURE) == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_NightOfTheMasks_Func024Func002C takes nothing returns boolean 
    if(not(GetItemLevel(udg_TempItemArray[GetForLoopIndexA()]) == 8)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_NightOfTheMasks_Func035C takes nothing returns boolean 
    if(not(udg_TempPlayer == udg_Parasite)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_NightOfTheMasks_Func036Func002Func002C takes nothing returns boolean 
    if(not(IsUnitType(udg_TempUnit2, UNIT_TYPE_STRUCTURE) == false)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_NightOfTheMasks_Func036Func002C takes nothing returns boolean 
    if(not(GetUnitMoveSpeed(udg_TempUnit2) <= 120.00)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_NightOfTheMasks_Func036C takes nothing returns boolean 
    if(not(GetUnitTypeId(udg_TempUnit2) == 'h01C')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_NightOfTheMasks_Func037C takes nothing returns boolean 
    if(not(IsUnitType(udg_TempUnit2, UNIT_TYPE_MECHANICAL) == true)) then 
        return false 
    endif 
    if(not(GetConvertedPlayerId(GetOwningPlayer(udg_TempUnit2)) <= 12)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_NightOfTheMasks_Func038Func003C takes nothing returns boolean 
    if((udg_TempUnit2 == gg_unit_h02S_0215)) then 
        return true 
    endif 
    if((udg_TempUnit2 == gg_unit_h02K_0204)) then 
        return true 
    endif 
    if((udg_TempUnit2 == gg_unit_h02K_0203)) then 
        return true 
    endif 
    if((udg_TempUnit2 == gg_unit_h02I_0183)) then 
        return true 
    endif 
    if((udg_TempUnit2 == gg_unit_h001_0041)) then 
        return true 
    endif 
    if((udg_TempUnit2 == gg_unit_h001_0043)) then 
        return true 
    endif 
    if((udg_TempUnit2 == gg_unit_h001_0002)) then 
        return true 
    endif 
    if((udg_TempUnit2 == gg_unit_h001_0016)) then 
        return true 
    endif 
    if((udg_TempUnit2 == gg_unit_h001_0041)) then 
        return true 
    endif 
    if((udg_TempUnit2 == gg_unit_h001_0044)) then 
        return true 
    endif 
    if((udg_TempUnit2 == gg_unit_h001_0163)) then 
        return true 
    endif 
    if((udg_TempUnit2 == gg_unit_h001_0162)) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_NightOfTheMasks_Func038C takes nothing returns boolean 
    if(not Trig_NightOfTheMasks_Func038Func003C()) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_NightOfTheMasks_Actions takes nothing returns nothing 
    set udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit()) 
    set udg_TempPlayer = GetOwningPlayer(GetSpellAbilityUnit()) 
    set udg_TempUnit2 = GetSpellTargetUnit() 
    set udg_TempReal = 60.00 
    set udg_TempUnitType = 'e015' 
    set udg_TempPlayer = GetOwningPlayer(GetSpellAbilityUnit()) 
    call ExecuteFunc("AlienRequirementRemove") 
    call ExecuteFunc("AlienRequirementRestore") 
    set udg_TempReal = GetUnitFacing(GetSpellAbilityUnit()) 
    call AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Items\\AIil\\AIilTarget.mdl") 
    call SFXThreadClean() 
    if(Trig_NightOfTheMasks_Func016C()) then 
        set udg_TempPlayer = udg_Parasite 
    else 
    endif 
    set udg_Player_Masquerade_Life[GetConvertedPlayerId(udg_TempPlayer)] = GetUnitLifePercent(GetSpellAbilityUnit()) 
    set bj_forLoopAIndex = 1 
    set bj_forLoopAIndexEnd = 6 
    loop 
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd 
        set udg_TempItemArray[GetForLoopIndexA()] = UnitItemInSlotBJ(GetSpellAbilityUnit(), GetForLoopIndexA()) 
        call SaveItemHandle(LS(), GetHandleId(udg_TempPlayer), StringHash("mitem_" + I2S(bj_forLoopAIndex)), udg_TempItemArray[bj_forLoopAIndex]) 
        call SetItemPositionLoc(UnitItemInSlotBJ(GetSpellAbilityUnit(), GetForLoopIndexA()), udg_HoldZone) 
        call UnitRemoveItemFromSlotSwapped(GetForLoopIndexA(), GetSpellAbilityUnit()) 
        set bj_forLoopAIndex = bj_forLoopAIndex + 1 
    endloop 
    // Delete masquerade and copypaste the targeted unit 
    call RemoveUnit(GetSpellAbilityUnit()) 
    if(Trig_NightOfTheMasks_Func021C()) then 
        call SetMasqueradeShop(udg_TempUnit2) //Caches the shop for later ESC usage 
        set udg_TempPoint = GetUnitLoc(udg_TempUnit2) 
        set udg_TempReal = GetUnitFacing(udg_TempUnit2) 
        call ShowUnitHide(udg_TempUnit2) 
    else 
    endif 
    set udg_TempUnit = CloneUnit(udg_TempUnit2, udg_TempPlayer, GetLocationX(udg_TempPoint), GetLocationY(udg_TempPoint), udg_TempReal) 
    call ResetUnitAnimation(udg_TempUnit) 
    set bj_forLoopAIndex = 1 
    set bj_forLoopAIndexEnd = 6 
    loop 
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd 
        set udg_TempItemArray[GetForLoopIndexA()] = UnitItemInSlotBJ(udg_TempUnit, GetForLoopIndexA()) 
        if(Trig_NightOfTheMasks_Func024Func002C()) then 
            call RemoveItem(udg_TempItemArray[GetForLoopIndexA()]) 
        else 
            call SaveItemHandle(LS(), GetHandleId(GetOwningPlayer(udg_TempUnit)), StringHash("kitem_" + I2S(bj_forLoopAIndex)), udg_TempItemArray[bj_forLoopAIndex]) 
        endif 
        set bj_forLoopAIndex = bj_forLoopAIndex + 1 
    endloop 
    call RemoveLocation(udg_TempPoint) 
    set udg_Player_NameBeforeDead[GetConvertedPlayerId(udg_TempPlayer)] = GetPlayerName(udg_TempPlayer) 
    call SelectUnitForPlayerSingle(udg_TempUnit, udg_TempPlayer) 
    set udg_TempString = GetPlayerName(GetOwningPlayer(udg_TempUnit2)) 
    call SetPlayerName(udg_TempPlayer, udg_TempString) 
    set udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)] = udg_TempUnit 
    set udg_Player_MasqueradeColor[GetConvertedPlayerId(udg_TempPlayer)] = GetPlayerColor(udg_TempPlayer) 
    call SetPlayerColorBJ(udg_TempPlayer, GetPlayerColor(GetOwningPlayer(udg_TempUnit2)), true) 
    set udg_Player_IsMasquerading[GetConvertedPlayerId(udg_TempPlayer)] = true 
    set udg_Player_MasqueradeTarget[GetConvertedPlayerId(udg_TempPlayer)] = GetOwningPlayer(udg_TempUnit2) 
    if(Trig_NightOfTheMasks_Func035C()) then 
    else 
    endif 
    if(Trig_NightOfTheMasks_Func036C()) then 
        call CrabTeleport(GetLastCreatedUnit()) 
    else 
        // Check for barrel, cage, health regen, whatever 
        if(Trig_NightOfTheMasks_Func036Func002C()) then 
            call SetUnitMoveSpeed(udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)], 120.00) 
            if(Trig_NightOfTheMasks_Func036Func002Func002C()) then 
                call SetUnitTimeScalePercent(udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)], 0.00) 
            else 
            endif 
        else 
        endif 
    endif 
    if(Trig_NightOfTheMasks_Func037C()) then 
        call Masquerade_MutantEnd(udg_TempPlayer) 
    else 
    endif 
    if(Trig_NightOfTheMasks_Func038C()) then 
        call SetUnitTimeScalePercent(udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)], 0.00) 
        call Masquerade_MutantEnd(udg_TempPlayer) 
    else 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_NightOfTheMasks takes nothing returns nothing 
    set gg_trg_NightOfTheMasks = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_NightOfTheMasks, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_NightOfTheMasks, Condition(function Trig_NightOfTheMasks_Conditions)) 
    call TriggerAddAction(gg_trg_NightOfTheMasks, function Trig_NightOfTheMasks_Actions) 
endfunction 

