function Trig_ST9Init_Func002A takes nothing returns nothing
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST9V1 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST9V2 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST9V3 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST9V4 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST9V5 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST9V6 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST9V7 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_ST9V8 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_Cage1 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_Cage2 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_Cage3 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_Cage4 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_Cage5 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
    call CreateFogModifierRectBJ( true, GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_Cage6 )
    call DestroyFogModifier( GetLastCreatedFogModifier() )
endfunction

function Trig_ST9Init_Func003A takes nothing returns nothing
    call BasicAI(GetEnumUnit(),300,1000.0)
endfunction

function Trig_ST9Init_Func013A takes nothing returns nothing
    set udg_TempTrigger=LoadTriggerHandle(LS(), GetHandleId(GetEnumDestructable()), StringHash("t1")) 
    call DisableTrigger( udg_TempTrigger )
    set udg_TempTrigger=LoadTriggerHandle(LS(), GetHandleId(GetEnumDestructable()), StringHash("t2")) 
    set udg_TempDoorHack = true
    call TriggerExecute( udg_TempTrigger )
    set udg_TempDoorHack = false
    call DestructableRestoreLife(LoadDestructableHandle(LS(), GetHandleId(udg_TempTrigger),StringHash("doorpath")),999999,true)
endfunction

function Trig_ST9Init_Actions takes nothing returns nothing
    call DestroyTrigger(GetTriggeringTrigger())
    call ForForce( GetPlayersAll(), function Trig_ST9Init_Func002A )
    call ForGroupBJ( GetUnitsInRectAll(gg_rct_Cage5), function Trig_ST9Init_Func003A )
    set udg_TempUnit = gg_unit_h04P_0266
    call BasicAI_Murmusk(udg_TempUnit,160,700.0)
    set udg_All_Dock[47] = gg_dest_DTrx_7022
    set udg_All_Dock[48] = gg_dest_DTrx_7025
    set udg_All_Dock[49] = gg_dest_DTrx_7023
    set udg_All_Dock[50] = gg_dest_DTrx_7024
    set udg_All_Dock[51] = gg_dest_DTrx_7020
    set udg_All_Dock[52] = gg_dest_DTrx_7021
    set bj_forLoopAIndex = 47
    set bj_forLoopAIndexEnd = 52
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        call ChangeElevatorWalls( true, bj_ELEVATOR_WALL_TYPE_ALL, udg_All_Dock[GetForLoopIndexA()] )
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    call EnumDestructablesInRectAll( gg_rct_ST9, function Trig_ST9Init_Func013A )
    set udg_TempUnit = gg_unit_h04I_0012
    call GenConsole(udg_TempUnit,udg_TempUnit,gg_rct_ST9Control)
    set udg_TempUnit = gg_unit_h04R_0258
    call GenConsole(udg_TempUnit,udg_TempUnit,gg_rct_ST9Control2)
endfunction

//===========================================================================
function InitTrig_ST9Init takes nothing returns nothing
    set gg_trg_ST9Init = CreateTrigger(  )
    call TriggerAddAction( gg_trg_ST9Init, function Trig_ST9Init_Actions )
endfunction

