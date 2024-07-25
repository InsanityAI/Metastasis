function Trig_ST6Death_Func001A takes nothing returns nothing 
    call UnitAddAbilityBJ('A02T', GetEnumUnit()) 
    call UnitRemoveBuffsBJ(bj_REMOVEBUFFS_ALL, GetEnumUnit()) 
    call UnitRemoveAbilityBJ('A04T', GetEnumUnit()) 
    call UnitRemoveAbilityBJ('A04U', GetEnumUnit()) 
    set bj_forLoopAIndex = 1 
    set bj_forLoopAIndexEnd = 6 
    loop 
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd 
        call RemoveItem(UnitItemInSlotBJ(GetEnumUnit(), GetForLoopIndexA())) 
        set bj_forLoopAIndex = bj_forLoopAIndex + 1 
    endloop 
    call MoogleKillUnit(GetEnumUnit(), GetKillingUnit()) 
    set udg_TempPoint = GetUnitLoc(GetEnumUnit()) 
    call CreateNUnitsAtLoc(1, 'e001', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING) 
    call SetUnitAnimation(GetLastCreatedUnit(), "death") 
    call RemoveLocation(udg_TempPoint) 
endfunction 

function Trig_ST6Death_Func002A takes nothing returns nothing 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_MASKED, gg_rct_LostStation) 
endfunction 

function Trig_ST6Death_Actions takes nothing returns nothing 
    call ForGroupBJ(GetUnitsInRectAll(gg_rct_LostStation), function Trig_ST6Death_Func001A) 
    call ForForce(GetPlayersAll(), function Trig_ST6Death_Func002A) 
    call RectOfDoom(gg_rct_LostStation) 
endfunction 

//=========================================================================== 
function InitTrig_ST6Death takes nothing returns nothing 
    set gg_trg_ST6Death = CreateTrigger() 
    call TriggerAddAction(gg_trg_ST6Death, function Trig_ST6Death_Actions) 
endfunction 

