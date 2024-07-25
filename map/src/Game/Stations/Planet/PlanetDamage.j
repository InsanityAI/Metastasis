function Trig_PlanetDamage_DestructDamage takes nothing returns nothing 
    call KillDestructable(GetEnumDestructable()) 
    if GetDestructableTypeId(GetEnumDestructable()) == 'B006' then 
        call RemoveDestructable(GetEnumDestructable()) 
    endif 
endfunction 

function PBombardment_Damage takes nothing returns nothing 
    if IsUnitExplorer(GetEnumUnit()) then 
        call UnitDamageTarget(GetEventDamageSource(), GetEnumUnit(), 10000.0, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS) 
    else 
        call UnitDamageTarget(GetEventDamageSource(), GetEnumUnit(), 4900.0, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS) 
    endif 
endfunction 

function PlanetDamageExplosion takes nothing returns nothing 
    local timer t = GetExpiredTimer() 
    local integer ht = GetHandleId(t) 
    local unit damager = LoadUnitHandle(udg_hash, ht, StringHash("Damager")) 
    local real targetX = LoadReal(udg_hash, ht, StringHash("TargetX")) 
    local real targetY = LoadReal(udg_hash, ht, StringHash("TargetY")) 
    local effect e = AddSpecialEffect("SFX\\Explosions\\NuclearExplosion.mdl", targetX, targetY) 
    local rect r = Rect(targetX - 712.0, targetY - 712.0, targetX + 712.0, targetY + 712.0) 
    local group g = CreateGroup() 
    local real swaggerHealth 
    if UnitAlive(gg_unit_h008_0196) then 
        call BlzSetSpecialEffectScale(e, 2.00) 
        call BlzSetSpecialEffectTimeScale(e, 0.75) 
        
        set e = AddSpecialEffect("Abilities\\Spells\\Undead\\Darksummoning\\DarkSummonTarget.mdl", targetX, targetY) 
        call BlzSetSpecialEffectColor(e, 255, 126, 255) 
        call BlzSetSpecialEffectScale(e, 7.00) 
        call BlzSetSpecialEffectTime(e, 0.5) 
        call BlzSetSpecialEffectTimeScale(e, 0.00) 
        
        call EnumDestructablesInRect(r, DESTRUCT_FILTER, function Trig_PlanetDamage_DestructDamage) 
        call RemoveRect(r) 
        
        call GroupEnumUnitsInRange(g, targetX, targetY, 600.0, UNIT_FILTER) 
        call ForGroup(g, function PBombardment_Damage) 
        call DestroyGroup(g) 
        
        call TerrainDeformCrater(targetX, targetY, 600.00, 128.00, 1, true) 
        call SetBlight(Player(PLAYER_NEUTRAL_AGGRESSIVE), targetX, targetY, 600.0, true) 
        
        if udg_Swagger_Grounded == true and UnitAlive(gg_unit_h00X_0049) then 
            call UnitDamageTarget(damager, gg_unit_h00X_0049, 20000, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS) 
            set swaggerHealth = GetUnitState(gg_unit_h00X_0049, UNIT_STATE_LIFE) / 20000.0 
            call DisplayTextToForce(GetPlayersAll(), "|cffFF0000WARNING: Atmospheric disturbance is damaging U.S.I. Swagger hull integrity. An immediate launch is recommended. Estimated " + I2S(R2I(swaggerHealth)) + " impacts remaining before hull integrity failure.") 
        endif 
    endif 
    
    call FlushChildHashtable(udg_hash, ht) 
    call DestroyTimer(t) 
endfunction 

function Trig_PlanetDamage_Actions takes nothing returns nothing 
    local integer iteration = 1 
    local real maxX = GetRectMaxX(gg_rct_Planet) 
    local real minX = GetRectMinX(gg_rct_Planet) 
    local real maxY = GetRectMaxY(gg_rct_Planet) 
    local real minY = GetRectMinY(gg_rct_Planet) 
    local real targetX 
    local real targetY 
    local real boomX 
    local real boomY 
    local real angle 
    local real distance 
    local effect e 
    local timer t 
    local integer ht 
    local integer damageIteration = 0 

    set udg_MinerthaDamageCounter = udg_MinerthaDamageCounter + GetEventDamage() 
    loop 
        exitwhen udg_MinerthaDamageCounter < 30000 
        set udg_MinerthaDamageCounter = udg_MinerthaDamageCounter - 30000.00 
        if UnitAlive(gg_unit_h008_0196) then 
            set boomX = GetRandomReal(minX, maxX) 
            set boomY = GetRandomReal(minY, maxY) 

            loop 
                exitwhen iteration > 36 
                
                set angle = 2 * bj_PI * I2R(iteration) / 36 
                set targetX = boomX + 600 * Cos(angle) 
                set targetY = boomY + 600 * Sin(angle) 
                set e = AddSpecialEffect("Abilities\\Spells\\Other\\TalkToMe\\TalkToMe.mdl", targetX, targetY) 
                set iteration = iteration + 1 
                
                call Timed_EffectRemove(e, 10.0 + damageIteration * 0.1) 
            endloop 
            set udg_MinerthaDamagePerSecond = udg_MinerthaDamagePerSecond + 3.0 
            set iteration = 1 
            loop 
                exitwhen iteration > 36 
                
                set distance = GetRandomReal(0, 590.00) 
                set angle = GetRandomReal(0, 2 * bj_PI) 
                set targetX = boomX + distance * Cos(angle) 
                set targetY = boomY + distance * Sin(angle) 
                set e = AddSpecialEffect("Abilities\\Spells\\Other\\TalkToMe\\TalkToMe.mdl", targetX, targetY) 
                set iteration = iteration + 1 
                
                call Timed_EffectRemove(e, 10.0 + damageIteration * 0.1) 
            endloop 
            
            set t = CreateTimer() 
            set ht = GetHandleId(t) 
            call SaveReal(udg_hash, ht, StringHash("TargetX"), boomX) 
            call SaveReal(udg_hash, ht, StringHash("TargetY"), boomY) 
            call SaveUnitHandle(udg_hash, ht, StringHash("Damager"), GetEventDamageSource()) 
            
            call TimerStart(t, 10.00 + damageIteration * 0.1, false, function PlanetDamageExplosion) 
            
            
            call PingMinimapEx(boomX, boomY, 10.00, 64, 64, 255, false) 
        endif 
        set damageIteration = damageIteration + 1 
    endloop 
    call SetUnitState(gg_unit_h008_0196, UNIT_STATE_MANA, udg_MinerthaDamageCounter) 
endfunction 

//=========================================================================== 
function InitTrig_PlanetDamage takes nothing returns nothing 
    set gg_trg_PlanetDamage = CreateTrigger() 
    call TriggerRegisterUnitEvent(gg_trg_PlanetDamage, gg_unit_h008_0196, EVENT_UNIT_DAMAGED) 
    call TriggerAddAction(gg_trg_PlanetDamage, function Trig_PlanetDamage_Actions) 
endfunction 

