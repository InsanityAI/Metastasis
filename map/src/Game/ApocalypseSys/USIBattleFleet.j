function Trig_USIBattleFleet_Actions takes nothing returns nothing 
    local timer k = CreateTimer() 
    local timerdialog f 
    local location r 
    set udg_TempPoint = GetRandomLocInRect(gg_rct_Space) 
    if(IsUnitAliveBJ(gg_unit_h003_0018) == true) then 
        if udg_TESTING == false then 
            call PingMinimapLocForForce(GetPlayersAll(), udg_TempPoint, 120.00) 
        else 
            call PingMinimapLocForForce(GetPlayersAll(), udg_TempPoint, 5.00) 
        endif 
    endif 
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_3035") 
    if udg_TESTING == false then 
        call StartTimerBJ(k, false, 120.00) 
    else 
        call StartTimerBJ(k, false, 5.00) 
    endif 
    set f = CreateTimerDialogBJ(k, "TRIGSTR_3036") 
    set r = udg_TempPoint 
    if udg_TESTING == false then 
        call PolledWait(120.00) 
    else 
        call PolledWait(5.00) 
    endif 
    call DestroyTimerDialog(f) 
    call DestroyTimer(k) 
    
    set udg_TempPoint = r 
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_3022") 
    call PlaySoundBJ(gg_snd_PursuitTheme) 
    
    //DummyExplosion VFX 
    call CreateNUnitsAtLoc(1, 'e01K', Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING) 
    
    //Hapyir 
    call CreateNUnitsAtLoc(1, 'h042', Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING) 
    set udg_TempUnit = GetLastCreatedUnit() 
    call GroupAddUnitSimple(udg_TempUnit, udg_SpaceObject_CollideGroup) 
    call NewUnitRegister(udg_TempUnit) 
    set udg_SpaceObject_CollideRadius[GetUnitUserData(udg_TempUnit)] = 300.00 
    call GroupAddUnit(udg_SpaceAI_USIFleet, udg_TempUnit) 
    //call ExecuteFunc("HostileSpaceAIForTempUnit") 
    
    //Erstwhile 
    call CreateNUnitsAtLoc(1, 'h041', Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING) 
    set udg_TempUnit = GetLastCreatedUnit() 
    call GroupAddUnitSimple(udg_TempUnit, udg_SpaceObject_CollideGroup) 
    call NewUnitRegister(udg_TempUnit) 
    set udg_SpaceObject_CollideRadius[GetUnitUserData(udg_TempUnit)] = 200.00 
    call GroupAddUnit(udg_SpaceAI_USIFleet, udg_TempUnit) 
    //call ExecuteFunc("HostileSpaceAIForTempUnit") 
    
    //Cameroon 
    call CreateNUnitsAtLoc(1, 'h040', Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING) 
    set udg_TempUnit = GetLastCreatedUnit() 
    call GroupAddUnitSimple(udg_TempUnit, udg_SpaceObject_CollideGroup) 
    call NewUnitRegister(udg_TempUnit) 
    set udg_SpaceObject_CollideRadius[GetUnitUserData(udg_TempUnit)] = 200.00 
    call GroupAddUnit(udg_SpaceAI_USIFleet, udg_TempUnit) 
    //call ExecuteFunc("HostileSpaceAIForTempUnit") 
        
    //Loop to create 5 raptors 
    set bj_forLoopAIndex = 1 
    set bj_forLoopAIndexEnd = 6 
    loop 
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd 
        call CreateNUnitsAtLoc(1, 'h043', Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING) 
        set udg_TempUnit = GetLastCreatedUnit() 
        call GroupAddUnit(udg_SpaceAI_USIFleet, udg_TempUnit) 
        //call ExecuteFunc("HostileSpaceAIForTempUnit") 
        set bj_forLoopAIndex = bj_forLoopAIndex + 1 
    endloop 
    
    //Make Pirate passive (can't blame fel, wouldn't be easy to make pirate fight players nor does it make sense to help the fleet either) 
    call SetUnitOwner(gg_unit_h02B_0116, Player(PLAYER_NEUTRAL_PASSIVE), true) 
    
    //Memory Leak cleaning 
    call RemoveLocation(udg_TempPoint) 
    
endfunction 

//=========================================================================== 
function InitTrig_USIBattleFleet takes nothing returns nothing 
    set gg_trg_USIBattleFleet = CreateTrigger() 
    call TriggerAddAction(gg_trg_USIBattleFleet, function Trig_USIBattleFleet_Actions) 
endfunction 

