function Trig_ST5Abilities_Actions takes nothing returns nothing 
    if GetSpellAbilityId() == 'A04O' and GetSpellTargetUnit() == gg_unit_h008_0196 then 
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
    elseif GetSpellAbilityId() == 'A04Q' then 
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
    endif 
endfunction 

//===========================================================================     
function InitTrig_ST5Abilities takes nothing returns nothing 
    set gg_trg_ST5Abilities = CreateTrigger() 
    call TriggerRegisterUnitEvent(gg_trg_ST5Abilities, gg_unit_h00Y_0050, EVENT_UNIT_SPELL_EFFECT) 
    call TriggerRegisterUnitEvent(gg_trg_ST5Abilities, gg_unit_h00X_0049, EVENT_UNIT_SPELL_EFFECT) 
    call TriggerAddAction(gg_trg_ST5Abilities, function Trig_ST5Abilities_Actions) 
endfunction 

