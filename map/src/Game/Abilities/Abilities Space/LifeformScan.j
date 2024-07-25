function Trig_LifeformScan_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A04X')) then 
        return false 
    endif 
    return true 
endfunction 


function DeterminePlayerheroIncrease takes nothing returns nothing 
    if udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] == GetEnumUnit() then 
        set udg_TempInt = udg_TempInt + 1 
    endif 
endfunction 

function DetermineExplorerIncrease takes nothing returns nothing 
    if IsUnitExplorer(GetEnumUnit()) then 
        set udg_TempInt = udg_TempInt + 1 
    endif 
endfunction 
//Could "optimize" the above, by having only one group, since first function takes only ships and units 
//and so, i could enumerate them together. But it will be a bit harder to read, and also should take time to bugfix -_- 


function Trig_LifeformScan_Actions takes nothing returns nothing 
    local unit a = GetSpellTargetUnit() 
    local player b = GetOwningPlayer(GetSpellAbilityUnit()) 
    local rect stationRect = udg_SpaceObject_Rect[GetUnitAN(GetSpellTargetUnit())] 
    local real scanDelay = ((GetRectWidthBJ(stationRect) * GetRectHeightBJ(stationRect)) / 15000000.00) 
    local group unitsWithinRect 
    local integer lifeformCount 
    local integer explorerCount 

    if b == Player(bj_PLAYER_NEUTRAL_EXTRA) then 
        set b = udg_Parasite 
    endif 

    if stationRect != null then 
        //Players inside 
        call DisplayTextToPlayer(b, 0, 0, "|cff00FFFFScanning...Estimated time " + R2S(scanDelay) + " seconds.") 
        set udg_TempInt = 0 
        set unitsWithinRect = GetUnitsInRectAndShips(stationRect) 
        call ForGroupBJ(unitsWithinRect, function DeterminePlayerheroIncrease) 
        call DestroyGroup(unitsWithinRect) 
        set lifeformCount = udg_TempInt 
        
        //Ships inside 
        set udg_TempInt = 0 
        set unitsWithinRect = GetUnitsInRectAll(stationRect) 
        call ForGroupBJ(unitsWithinRect, function DetermineExplorerIncrease) 
        call DestroyGroup(unitsWithinRect) 
        set explorerCount = udg_TempInt 
        
        call PolledWait(scanDelay) 
        call DisplayTextToPlayer(b, 0, 0, "|cff00FFFFSensors have detected |r|cffFF0000" + I2S(lifeformCount) + " |r|cff00FFFFlifeforms, and |r|cffF4A460" + I2S(explorerCount) + " |r|cff00FFFFexplorers within target.") 
    
    else 
        call DisplayTextToPlayer(b, 0, 0, "An error has occurred.") 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_LifeformScan takes nothing returns nothing 
    set gg_trg_LifeformScan = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_LifeformScan, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_LifeformScan, Condition(function Trig_LifeformScan_Conditions)) 
    call TriggerAddAction(gg_trg_LifeformScan, function Trig_LifeformScan_Actions) 
endfunction 

