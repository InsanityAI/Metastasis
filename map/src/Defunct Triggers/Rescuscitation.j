function Trig_Rescuscitation_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A06N')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Rescuscitation_Func001Func001Func012A takes nothing returns nothing 
    call SetPlayerAllianceStateBJ(GetEnumPlayer(), udg_TempPlayer, bj_ALLIANCE_ALLIED) 
    call SetPlayerAllianceStateBJ(udg_TempPlayer, GetEnumPlayer(), bj_ALLIANCE_ALLIED) 
endfunction 

function Trig_Rescuscitation_Func001Func001Func015A takes nothing returns nothing 
    call SetPlayerAllianceStateBJ(GetEnumPlayer(), udg_TempPlayer, bj_ALLIANCE_UNALLIED) 
    call SetPlayerAllianceStateBJ(udg_TempPlayer, GetEnumPlayer(), bj_ALLIANCE_ALLIED_VISION) 
endfunction 

function Trig_Rescuscitation_Func001A takes nothing returns nothing 
    local unit b = GetEnumUnit() 
    local player o = GetOwningPlayer(b) 
    local location k 
    local integer i = GetConvertedPlayerId(o) 
    if IsUnitDeadBJ(b) then 
        if TimerGetElapsed(udg_GameTimer) -udg_Unit_DeathTime[GetUnitUserData(GetEnumUnit())] <= 45 then 
            if GetEnumUnit() == udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] then 
                if(o != udg_Mutant and o != udg_Parasite and udg_Player_IsParasiteSpawn[i] != true and udg_Player_IsMutantSpawn[i] != true and udg_HiddenAndroid != o) then 
                    call RemoveItem(GetItemOfTypeFromUnitBJ(GetSpellAbilityUnit(), 'I01O')) 
                    set k = GetUnitLoc(b) 
                    //call PolledWait( 6.00 )    
                    set udg_TempPoint = k 
                    call RemoveUnit(LoadUnitHandle(LS(), GetHandleId(b), StringHash("Corpse"))) 
                    call CreateNUnitsAtLoc(1, 'h00H', o, udg_TempPoint, bj_UNIT_FACING) 
                    call SetUnitLifeBJ(GetLastCreatedUnit(), 150.00) 
                    set udg_Playerhero[GetConvertedPlayerId(o)] = GetLastCreatedUnit() 
                    call SetPlayerName(o, udg_Player_NameBeforeDead[GetConvertedPlayerId(o)]) 
                    call PanCameraToTimedLocForPlayer(o, k, 0) 
                    call SelectUnitForPlayerSingle(GetLastCreatedUnit(), o) 
                    call ForceRemovePlayerSimple(o, udg_DeadGroup) 
                    call ForForce(GetPlayersAll(), function Trig_Rescuscitation_Func001Func001Func012A) 
                    call SetPlayerAllianceStateBJ(Player(bj_PLAYER_NEUTRAL_EXTRA), o, bj_ALLIANCE_ALLIED) 
                    call SetPlayerAllianceStateBJ(o, Player(bj_PLAYER_NEUTRAL_EXTRA), bj_ALLIANCE_ALLIED) 
                    call ForForce(udg_DeadGroup, function Trig_Rescuscitation_Func001Func001Func015A) 
                    call RemoveLocation(udg_TempPoint) 
                    call RemoveUnit(b) 
                    call TriggerExecute(gg_trg_WinCheck) 
                endif 
            endif 
        else 
            call DisplayTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0, "Target is too far dead for rescuscitation.") 
        endif 
    else 
        call DisplayTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0, "Target is non human.") 
    endif 
endfunction 

function Trig_Rescuscitation_Actions takes nothing returns nothing 
    local group g = GetUnitsInRangeOfLocAll(90.00, GetSpellTargetLoc()) 
    call ForGroupBJ(g, function Trig_Rescuscitation_Func001A) 
    call DestroyGroup(g) 
endfunction 

//===========================================================================    
function InitTrig_Rescuscitation takes nothing returns nothing 
    set gg_trg_Rescuscitation = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Rescuscitation, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_Rescuscitation, Condition(function Trig_Rescuscitation_Conditions)) 
    call TriggerAddAction(gg_trg_Rescuscitation, function Trig_Rescuscitation_Actions) 
endfunction 

