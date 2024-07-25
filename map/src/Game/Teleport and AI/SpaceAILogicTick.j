function RunSpaceFleetLogic takes nothing returns nothing 
    call IssuePointOrder(GetEnumUnit(), "attack", udg_TempReal, udg_TempReal2) 
endfunction 

function FilterEnum takes nothing returns boolean 
    if GetOwningPlayer(GetFilterUnit()) != Player(PLAYER_NEUTRAL_AGGRESSIVE) and IsUnitAliveBJ(GetFilterUnit()) then 
        return true 
    endif 
    return false 
endfunction 

function Trig_SpaceAILogicTick_Actions takes nothing returns nothing 
            
    //Get all non-player-hostile units who are alive 
    set udg_SpaceAI_FocusTargets = GetUnitsInRectMatching(gg_rct_Space, Condition(function FilterEnum)) 
    
    //TempInt = The amount of units in space to be focused by AI 
    set udg_TempInt = CountUnitsInGroup(udg_SpaceAI_FocusTargets) 
    
    
    //If Minertha is alive, start the sapper logic 
    if IsUnitDeadBJ(gg_unit_h008_0196) == false then 
        
        //If Minertha has sapper tag, and it's the only unit in space -> Remove the sapper tag 
        if IsUnitType(gg_unit_h008_0196, UNIT_TYPE_SAPPER) and udg_TempInt == 1 then 
            call UnitRemoveTypeBJ(UNIT_TYPE_SAPPER, gg_unit_h008_0196) 
        endif 
        
        //If minertha doesn't have sapper tag, check if there are more space units now, so as to add it to minertha 
        if IsUnitType(gg_unit_h008_0196, UNIT_TYPE_SAPPER) == false and udg_TempInt > 1 then 
            call UnitAddTypeBJ(UNIT_TYPE_SAPPER, gg_unit_h008_0196) 
        endif 
        
        //Unrelated to sapper, but removing Minertha completely from being focused if its not alone plz 
        if udg_TempInt > 1 then 
            call GroupRemoveUnit(udg_SpaceAI_FocusTargets, gg_unit_h008_0196) 
        endif 
    endif 
    
    //Get First unit to target ((unrelated with distance lmao)) 
    set udg_TempReal = GetUnitX(FirstOfGroup(udg_SpaceAI_FocusTargets)) 
    set udg_TempReal2 = GetUnitY(FirstOfGroup(udg_SpaceAI_FocusTargets)) 
    
    //Run USI Fleet Logic on each ship in the group 
    call ForGroup(udg_SpaceAI_USIFleet, function RunSpaceFleetLogic) 
    
    //Run Pirate Ship Logic 
    if udg_SpaceAI_PirateCaptainAlive then 
        call IssuePointOrder(gg_unit_h02B_0116, "attack", udg_TempReal, udg_TempReal2) 
    endif 
    
    call DestroyGroup(udg_SpaceAI_FocusTargets) 
        
    //Run Drones Logic 
    //Ytrec's code copypasta has made them run by themselves, and its better that way since they don't focus one point but locally closest 
    //Could use some cleaning for sure, as they are not optimized for sure and conflict with this (checking sapper minertha for each drone -_-) 
    
    //Run Misc 
    //No idea, but I was thinking of snoeglays or hostile raptors/ships in general - very rare. 
endfunction 

//=========================================================================== 
function InitTrig_SpaceAILogicTick takes nothing returns nothing 
    set gg_trg_SpaceAILogicTick = CreateTrigger() 
    call TriggerRegisterTimerExpireEventBJ(gg_trg_SpaceAILogicTick, udg_SpaceAI_Timer) 
    call TriggerAddAction(gg_trg_SpaceAILogicTick, function Trig_SpaceAILogicTick_Actions) 
endfunction 

