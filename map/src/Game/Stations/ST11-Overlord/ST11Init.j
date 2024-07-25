function Trig_ST11Init_Func016A takes nothing returns nothing 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST11V1) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST11V10) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST11V11) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST11V12) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST11V13) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST11V14) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST11V15) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST11V16) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST11V17) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST11V18) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST11V19) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST11V2) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST11V20) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST11V21) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST11V22) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST11V23) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST11V24) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST11V3) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST11V4) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST11V5) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST11V6) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST11V7) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST11V8) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST11V9) 
    call DestroyFogModifier(GetLastCreatedFogModifier()) 
endfunction 

function Trig_ST11Init_Actions takes nothing returns nothing 
    call DestroyTrigger(GetTriggeringTrigger()) 
    call EnableTrigger(gg_trg_ST11BloodEffect) 
    call EnableTrigger(gg_trg_ST11HivesDie) 
    call EnableTrigger(gg_trg_ST11DieNatural) 
    set udg_Sector_Space[27] = GetLastCreatedUnit() 
    set udg_All_Dock[53] = gg_dest_B009_5548 
    set udg_All_Dock[54] = gg_dest_B009_5547 
    set udg_All_Dock[55] = gg_dest_B009_5543 
    set udg_All_Dock[56] = gg_dest_B009_5542 
    set udg_All_Dock[57] = gg_dest_B009_5540 
    set udg_SectorId[27] = gg_rct_OverlordRect 
    set udg_TempUnit = GetLastCreatedUnit() 
    call GroupAddUnitSimple(udg_TempUnit, udg_SpaceObject_CollideGroup) 
    call NewUnitRegister(udg_TempUnit) 
    set udg_SpaceObject_CollideRadius[GetUnitUserData(udg_TempUnit)] = 150.00 
    call ForForce(GetPlayersAll(), function Trig_ST11Init_Func016A) 
    call PlaySoundBJ(gg_snd_SargerasRoar02) 
    call UnitRemoveAbilityBJ('Avul', gg_unit_h04X_0172) 
    call UnitRemoveAbilityBJ('Avul', gg_unit_h04X_0148) 
    call UnitRemoveAbilityBJ('Avul', gg_unit_h04X_0173) 
endfunction 

//=========================================================================== 
function InitTrig_ST11Init takes nothing returns nothing 
    set gg_trg_ST11Init = CreateTrigger() 
    call TriggerAddAction(gg_trg_ST11Init, function Trig_ST11Init_Actions) 
endfunction 

