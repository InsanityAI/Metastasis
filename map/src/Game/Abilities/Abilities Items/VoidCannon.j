function Trig_VoidCannon_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A0A6')) then //TODO 
        return false 
    endif 
    return true 
endfunction 

function VoidCannon_Explode takes nothing returns nothing 
    local timer k = GetExpiredTimer() 
    local location b = LoadLocationHandle(LS(), GetHandleId(k), StringHash("loc")) 
    local player p = LoadPlayerHandle(LS(), GetHandleId(k), StringHash("player")) 
    
    //local unit vfx1 
    //local unit vfx2 
    
    //vfx1 = CreateUnitAtLoc(Player(PLAYER_NEUTRAL_PASSIVE), 'e03l', b, GetRandomDirectionDeg()) 
    //vfx2 = CreateUnitAtLoc(Player(PLAYER_NEUTRAL_PASSIVE), 'e03J', b, GetRandomDirectionDeg()) 
    
    call CreateUnitAtLoc(Player(PLAYER_NEUTRAL_PASSIVE), 'e03I', b, GetRandomDirectionDeg()) 
    call CreateUnitAtLoc(Player(PLAYER_NEUTRAL_PASSIVE), 'e03J', b, GetRandomDirectionDeg()) 
    
    call DamageAreaForPlayerTK(p, 150.0, 700.0, GetLocationX(b), GetLocationY(b)) 
    call RemoveLocation(b) 
    call FlushChildHashtable(LS(), GetHandleId(k)) 
    call DestroyTimer(k) 
endfunction 

function Trig_VoidCannon_Actions takes nothing returns nothing 
    local location b = GetSpellTargetLoc() 
    local location c = GetUnitLoc(GetSpellAbilityUnit()) 
    local timer k = CreateTimer() 
    local unit a = CreateUnitAtLoc(Player(PLAYER_NEUTRAL_PASSIVE), 'e03F', c, GetRandomDirectionDeg()) 
    
    call SaveLocationHandle(LS(), GetHandleId(k), StringHash("loc"), b) 
    call SavePlayerHandle(LS(), GetHandleId(k), StringHash("player"), GetOwningPlayer(GetSpellAbilityUnit())) 
    call TimerStart(k, 2.3, false, function VoidCannon_Explode) 
    call AddSpecialEffectLoc("Abilities\\Spells\\Undead\\DeathCoil\\DeathCoilSpecialArt.mdl", c) 
    call AddSpecialEffectLoc("Abilities\\Spells\\Other\\HowlOfTerror\\HowlCaster.mdl", c) 
    call SFXThreadClean() 
    call BasicAI_IssueDangerArea(b, 220.0, 2.4) 
    call SetUnitFlyHeight(a, 3500, 600.0) 
    //call SizeUnitOverTime(a,2.3,6.0,6.0,false)//(unit, duration, start, end, bool) 
    call FadeUnitOverTime(a, 2.4, true) 
    call RemoveLocation(c) 
endfunction 


//=========================================================================== 
function InitTrig_VoidCannon takes nothing returns nothing 
    set gg_trg_VoidCannon = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_VoidCannon, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_VoidCannon, Condition(function Trig_VoidCannon_Conditions)) 
    call TriggerAddAction(gg_trg_VoidCannon, function Trig_VoidCannon_Actions) 
endfunction 

