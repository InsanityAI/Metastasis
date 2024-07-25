function Trig_Selection_Actions takes nothing returns nothing 
    set udg_TempInt = GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit())) 
    set udg_TempPoint = GetUnitLoc(udg_Playerhero[udg_TempInt]) 
    call PanCameraToTimedLocForPlayer(ConvertedPlayer(udg_TempInt), udg_TempPoint, 0) 
    call SelectUnitForPlayerSingle(udg_Playerhero[udg_TempInt], ConvertedPlayer(udg_TempInt)) 
endfunction 

//=========================================================================== 
function InitTrig_Selection takes nothing returns nothing 
    set gg_trg_Selection = CreateTrigger() 
    call TriggerAddAction(gg_trg_Selection, function Trig_Selection_Actions) 
endfunction 

