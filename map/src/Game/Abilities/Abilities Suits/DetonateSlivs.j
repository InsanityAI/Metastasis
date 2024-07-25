function Trig_DetonateSlivs_Conditions takes nothing returns boolean 
    if(not(GetSpellAbilityId() == 'A07S')) then 
        return false 
    endif 
    return true 
endfunction 

//Runs once for each unit inside 
function GetSlivGroupCount takes nothing returns nothing 
    set udg_TempInt = udg_TempInt + 1 
endfunction 

function Trig_DetonateSlivs_Actions takes nothing returns nothing 
    local unit a = GetSpellAbilityUnit() 
    local group magneticSlivedGroup 
    local unit pickedUnit 
    local integer slivAttacks 
    local location o 

    if HaveSavedHandle(LS(), GetHandleId(a), StringHash("Suit_SlivGroup")) then 
        set magneticSlivedGroup = LoadGroupHandle(LS(), GetHandleId(a), StringHash("Suit_SlivGroup")) 
    else 
        return 
    endif 
    
    set udg_TempInt = 0 
    call ForGroup(magneticSlivedGroup, function GetSlivGroupCount) 
    
    //Loops and always gets the first of the unit group 
    loop 
        //Exitwhen there are no iterations left 
        exitwhen udg_TempInt == 0 
        
        //Pick the unit for this loop (works by queue) 
        set pickedUnit = FirstOfGroup(magneticSlivedGroup) 
        
        if HaveSavedInteger(LS(), GetHandleId(magneticSlivedGroup), GetHandleId(pickedUnit)) and IsUnitAliveBJ(pickedUnit) then 
            
            //Play SFX on unit's location 
            set o = GetUnitLoc(pickedUnit) 
            call PlaySoundAtPointBJ(gg_snd_MeatwagonMissileHit1, 100, o, 0) 
            call RemoveLocation(o) 
            
            //Get how many slivAttacks picked unit has taken 
            set slivAttacks = LoadInteger(LS(), GetHandleId(magneticSlivedGroup), GetHandleId(pickedUnit)) 
            //call SaveInteger(LS(),GetHandleId(a),StringHash(I2S(GetHandleId(d))+"_SlivsOn"),0) 

            ///DEBUG//TODO REMOVE! 
            ///call DisplayTextToForce(GetPlayersAll(), "The sliv attacks right before detonation are: ") 
            ///call DisplayTextToForce(GetPlayersAll(), I2S(slivAttacks)) 
            
            //if 10 attacks (25*10=250), it becomes AoE 
            //What it would do single-target - 150, and that 150 becomes AoE now. 
            if slivAttacks > 9 then 
                call UnitDamageTarget(a, pickedUnit, I2R(slivAttacks) * 25.0 - 150, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS) 
                call DamageAreaForPlayerTK(GetOwningPlayer(a), 250.0, 150, GetUnitX(pickedUnit), GetUnitY(pickedUnit)) 
            else //Single target dmg 
                call UnitDamageTarget(a, pickedUnit, I2R(slivAttacks) * 25.0, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS) 
            endif 
            
            //Pure Special Effects (visual) below 
            
            call AddSpecialEffect("Objects\\Spawnmodels\\NightElf\\NightElfBlood\\NightElfBloodDruidBear.mdl", GetUnitX(pickedUnit), GetUnitY(pickedUnit)) 
            call SFXThreadClean() 
                
            if not(IsUnitType(pickedUnit, UNIT_TYPE_TAUREN)) and not(IsUnitType(pickedUnit, UNIT_TYPE_STRUCTURE)) then 
                
                if slivAttacks > 3 then 
                    call AddSpecialEffect("Objects\\Spawnmodels\\Human\\HumanBlood\\BloodElfSpellThiefBlood.mdl", GetUnitX(pickedUnit), GetUnitY(pickedUnit)) 
                    call SFXThreadClean() 
                endif 
                    
                if slivAttacks > 5 then 
                    call AddSpecialEffect("Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl", GetUnitX(pickedUnit), GetUnitY(pickedUnit)) 
                    call SFXThreadClean() 
                endif 
                    
                if slivAttacks > 7 then 
                    call AddSpecialEffect("Objects\\Spawnmodels\\Undead\\UndeadLargeDeathExplode\\UndeadLargeDeathExplode.mdl", GetUnitX(pickedUnit), GetUnitY(pickedUnit)) 
                    call SFXThreadClean() 
                endif 
                    
                if slivAttacks > 9 then 
                    call AddSpecialEffect("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", GetUnitX(pickedUnit), GetUnitY(pickedUnit)) 
                    call SFXThreadClean() 
                endif 
            else 
                call AddSpecialEffect("Objects\\Spawnmodels\\NightElf\\NECancelDeath\\NECancelDeath.mdl", GetUnitX(pickedUnit), GetUnitY(pickedUnit)) 
                call SFXThreadClean() 
                    
                if slivAttacks > 5 then 
                    call AddSpecialEffect("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", GetUnitX(pickedUnit), GetUnitY(pickedUnit)) 
                    call SFXThreadClean() 
                endif 
            endif 
            //Special Effects (visual) End 
        endif 
        
        //Remove unit, so the next picked unit will not be the same ;) 
        call GroupRemoveUnit(magneticSlivedGroup, pickedUnit) 
        
        set udg_TempInt = udg_TempInt - 1 
    endloop 
            
    call FlushChildHashtable(LS(), GetHandleId(magneticSlivedGroup)) 
    call DestroyGroup(magneticSlivedGroup) 
endfunction 

//=========================================================================== 
function InitTrig_DetonateSlivs takes nothing returns nothing 
    set gg_trg_DetonateSlivs = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_DetonateSlivs, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_DetonateSlivs, Condition(function Trig_DetonateSlivs_Conditions)) 
    call TriggerAddAction(gg_trg_DetonateSlivs, function Trig_DetonateSlivs_Actions) 
endfunction 

