function Trig_PirateShip_Func008A takes nothing returns nothing 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_PirateShip) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
endfunction 

function Trig_PirateShip_Actions takes nothing returns nothing 
    call DestroyTrigger(GetTriggeringTrigger()) 
    set udg_RandomEvent_On[4] = true 
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_3012") 
    set udg_TempPoint = GetRandomLocInRect(gg_rct_SpaceSound) 
    call SetUnitPositionLoc(gg_unit_h02B_0116, udg_TempPoint) 
    call PingMinimapLocForForceEx(GetPlayersAll(), udg_TempPoint, 15.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100, 0.00, 0.00) 
    call RemoveLocation(udg_TempPoint) 
    call ForForce(GetPlayersAll(), function Trig_PirateShip_Func008A) 
    call StartTimerBJ(udg_RandomEvent, false, GetRandomReal(90.00, 1200.00)) 
    call SetUnitOwner(gg_unit_h02B_0116, Player(PLAYER_NEUTRAL_AGGRESSIVE), true) 
    set udg_TempUnit = gg_unit_h02B_0116 
    set udg_SpaceAI_PirateCaptainAlive = true 
endfunction 

//=========================================================================== 
function InitTrig_PirateShip takes nothing returns nothing 
    set gg_trg_PirateShip = CreateTrigger() 
    call DisableTrigger(gg_trg_PirateShip) 
    call TriggerAddAction(gg_trg_PirateShip, function Trig_PirateShip_Actions) 
endfunction 

