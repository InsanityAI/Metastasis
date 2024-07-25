function Trig_ST5Abilities_Func003Func001Func001C takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A04Q')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ST5Abilities_Func003Func001C takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A04O')) then 
        return false 
    endif 
    if(not(GetSpellTargetUnit() == gg_unit_h008_0196)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ST5Abilities_Func003Func005Func001Func002Func001001001 takes nothing returns boolean 
    return(GetFilterPlayer() == udg_Parasite) 
endfunction 

function Trig_ST5Abilities_Func003Func005Func001Func002Func002001001 takes nothing returns boolean 
    return(GetFilterPlayer() == GetOwningPlayer(GetTriggerUnit())) 
endfunction 

function Trig_ST5Abilities_Func003Func005Func001Func002C takes nothing returns boolean 
    if(not(GetOwningPlayer(GetTriggerUnit()) != Player(bj_PLAYER_NEUTRAL_EXTRA))) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ST5Abilities_Func003Func005Func001C takes nothing returns boolean 
    if(not(GetOwningPlayer(GetEnumUnit()) != Player(PLAYER_NEUTRAL_PASSIVE))) then 
        return false 
    endif 
    if(not(GetOwningPlayer(GetEnumUnit()) != Player(PLAYER_NEUTRAL_AGGRESSIVE))) then 
        return false 
    endif 
    if(not(RectContainsUnit(gg_rct_Space, GetEnumUnit()) == false)) then 
        return false 
    endif 
    if(not(udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] == GetEnumUnit())) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ST5Abilities_Func003Func005Func002Func002Func001001001 takes nothing returns boolean 
    return(udg_Parasite == GetFilterPlayer()) 
endfunction 

function Trig_ST5Abilities_Func003Func005Func002Func002Func002001001 takes nothing returns boolean 
    return(GetOwningPlayer(GetSpellAbilityUnit()) == GetFilterPlayer()) 
endfunction 

function Trig_ST5Abilities_Func003Func005Func002Func002C takes nothing returns boolean 
    if(not(GetOwningPlayer(GetSpellAbilityUnit()) != Player(bj_PLAYER_NEUTRAL_EXTRA))) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ST5Abilities_Func003Func005Func002C takes nothing returns boolean 
    if not(IsUnitExplorer(GetEnumUnit()) and ShipHasUnits(GetEnumUnit())) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ST5Abilities_Func003Func005A takes nothing returns nothing 
    if(Trig_ST5Abilities_Func003Func005Func001C()) then 
        set udg_TempPoint = GetUnitLoc(GetEnumUnit()) 
        if(Trig_ST5Abilities_Func003Func005Func001Func002C()) then 
            call PingMinimapLocForForceEx(GetPlayersMatching(Condition(function Trig_ST5Abilities_Func003Func005Func001Func002Func002001001)), udg_TempPoint, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100, 100, 100) 
        else 
            call PingMinimapLocForForceEx(GetPlayersMatching(Condition(function Trig_ST5Abilities_Func003Func005Func001Func002Func001001001)), udg_TempPoint, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100, 100, 100) 
        endif 
        call RemoveLocation(udg_TempPoint) 
    else 
    endif 
    if(Trig_ST5Abilities_Func003Func005Func002C()) then 
        set udg_TempPoint2 = GetUnitLoc(GetEnumUnit()) 
        if(Trig_ST5Abilities_Func003Func005Func002Func002C()) then 
            call PingMinimapLocForForceEx(GetPlayersMatching(Condition(function Trig_ST5Abilities_Func003Func005Func002Func002Func002001001)), udg_TempPoint2, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100.00, 25.00, 50.00) 
        else 
            call PingMinimapLocForForceEx(GetPlayersMatching(Condition(function Trig_ST5Abilities_Func003Func005Func002Func002Func001001001)), udg_TempPoint2, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100.00, 25.00, 50.00) 
        endif 
        call RemoveLocation(udg_TempPoint2) 
    else 
    endif 
endfunction 

function Trig_ST5Abilities_Func003C takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A000')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ST5Abilities_Actions takes nothing returns nothing 
    if(Trig_ST5Abilities_Func003C()) then 
        call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_727") 
        set udg_TempRect = gg_rct_ST5 
        set udg_TempUnitGroup = GetUnitsInRectAll(udg_TempRect) 
        call ForGroupBJ(udg_TempUnitGroup, function Trig_ST5Abilities_Func003Func005A) 
        call DestroyGroup(udg_TempUnitGroup) 
    else 
        if(Trig_ST5Abilities_Func003Func001C()) then 
            call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2475") 
            call ShowUnitHide(gg_unit_h00X_0049) 
            call PauseUnitBJ(true, gg_unit_h00X_0049) 
            call SetUnitVertexColorBJ(gg_unit_h03O_0208, 0.00, 0.00, 0.00, 25.00) 
            call SetUnitVertexColorBJ(gg_unit_e012_0074, 100.00, 100.00, 100.00, 0.00) 
            call SetUnitVertexColorBJ(gg_unit_e012_0092, 100.00, 100.00, 100.00, 0.00) 
            call UnitAddAbilityBJ('A04Q', gg_unit_h00Y_0050) 
            set udg_Swagger_Grounded = true 
            call EnableTrigger(gg_trg_SwaggerTeleportToPlanet) 
            call EnableTrigger(gg_trg_SwaggerTeleportToSwagger) 
        else 
            if(Trig_ST5Abilities_Func003Func001Func001C()) then 
                call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2491") 
                call UnitRemoveAbilityBJ('A04Q', GetSpellAbilityUnit()) 
                call StartTimerBJ(udg_SwaggerLaunchTimer, false, 45.00) 
                call CreateTimerDialogBJ(GetLastCreatedTimerBJ(), "TRIGSTR_2492") 
                set udg_SwaggerLaunchTimerWindow = GetLastCreatedTimerDialogBJ() 
                call PolledWait(45.00) 
                set udg_Swagger_Grounded = false 
                call DestroyTimerDialogBJ(udg_SwaggerLaunchTimerWindow) 
                call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2494") 
                call ShowUnitShow(gg_unit_h00X_0049) 
                call PauseUnitBJ(false, gg_unit_h00X_0049) 
                set udg_TempPoint = GetUnitLoc(gg_unit_h008_0196) 
                call SetUnitPositionLoc(gg_unit_h00X_0049, udg_TempPoint) 
                call RemoveLocation(udg_TempPoint) 
                call SetUnitVertexColorBJ(gg_unit_h03O_0208, 100.00, 100.00, 100.00, 100.00) 
                call SetUnitVertexColorBJ(gg_unit_e012_0074, 100.00, 100.00, 100.00, 100.00) 
                call SetUnitVertexColorBJ(gg_unit_e012_0092, 100.00, 100.00, 100.00, 100.00) 
                call DisableTrigger(gg_trg_SwaggerTeleportToPlanet) 
                call DisableTrigger(gg_trg_SwaggerTeleportToSwagger) 
            else 
            endif 
        endif 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_ST5Abilities takes nothing returns nothing 
    set gg_trg_ST5Abilities = CreateTrigger() 
    call TriggerRegisterUnitEvent(gg_trg_ST5Abilities, gg_unit_h00Y_0050, EVENT_UNIT_SPELL_EFFECT) 
    call TriggerRegisterUnitEvent(gg_trg_ST5Abilities, gg_unit_h00X_0049, EVENT_UNIT_SPELL_EFFECT) 
    call TriggerAddAction(gg_trg_ST5Abilities, function Trig_ST5Abilities_Actions) 
endfunction 

