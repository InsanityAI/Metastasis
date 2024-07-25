function Trig_Fleshies_Conditions takes nothing returns boolean 
    if(not(GetUnitTypeId(GetTriggerUnit()) == 'h01F')) then 
        return false 
    endif 
    return true 
endfunction 

function FleshyFilter takes nothing returns nothing 
    if IsPlayerMutant(GetOwningPlayer(GetEnumUnit())) == true or GetOwningPlayer(GetEnumUnit()) == Player(PLAYER_NEUTRAL_PASSIVE) or GetUnitPointValue(GetEnumUnit()) == 37 or IsUnitDeadBJ(GetEnumUnit()) or GetUnitAbilityLevel(GetEnumUnit(), 'Avul') == 1 or GetUnitTypeId(GetEnumUnit()) == 'h01E' then 
        call GroupRemoveUnit(udg_TempUnitGroup, GetEnumUnit()) 
    endif 
endfunction 

function Trig_Fleshies_Actions takes nothing returns nothing 
    local unit a = GetSummonedUnit() 
    local location b 
    local group g 
    call SetUnitOwner(a, Player(PLAYER_NEUTRAL_PASSIVE), false) 
    loop 
        exitwhen IsUnitDeadBJ(a) 
        set b = GetUnitLoc(a) 
        set g = GetUnitsInRangeOfLocAll(650.0, b) 
        set udg_TempUnitGroup = g 
        call ForGroup(g, function FleshyFilter) 
        if CountUnitsInGroup(g) == 0 then 
            call UnitAddAbility(a, 'Atwa') 
        else 
            call UnitRemoveAbility(a, 'Atwa') 
            call IssueTargetOrder(a, "attack", FirstOfGroup(g)) 
        endif 
        call RemoveLocation(b) 
        call DestroyGroup(g) 
        call PolledWait(2.0) 
    endloop 
    set a = null 
endfunction 

//=========================================================================== 
function InitTrig_Fleshies takes nothing returns nothing 
    set gg_trg_Fleshies = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Fleshies, EVENT_PLAYER_UNIT_SUMMON) 
    call TriggerAddCondition(gg_trg_Fleshies, Condition(function Trig_Fleshies_Conditions)) 
    call TriggerAddAction(gg_trg_Fleshies, function Trig_Fleshies_Actions) 
endfunction 

