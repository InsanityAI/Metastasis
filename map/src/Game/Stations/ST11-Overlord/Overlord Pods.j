function Trig_Overlord_Pods_Conditions takes nothing returns boolean 
    if(GetSpellAbilityId() != 'A08H') then 
        return false 
    endif 
    return true 
endfunction 

function TransportedDestruction takes nothing returns nothing 
    if IsUnitInTransport(GetEnumUnit(), udg_TempUnit) then 
        call KillUnit(GetEnumUnit()) 
    endif 
endfunction 

function Trig_Overlord_Pods_Actions takes nothing returns nothing 

    local unit a = GetSpellAbilityUnit() 
    local unit b = GetSpellTargetUnit() 
    local player qrqr = GetOwningPlayer(a) 
    local unit c 
    local rect r 
    local location loc 
    local location loc2 
    local real d 
    local real targetX = GetUnitX(b) 
    local real targetY = GetUnitY(b) 
    local real currentX 
    local real currentY 
    local real d2 
    local boolean flag 
    local group g 
    local group g2 
    local group g3 

    set loc = GetUnitLoc(udg_Sector_Space[GetUnitSector(a)]) 
    set flag = false 
    set d = udg_SpaceObject_CollideRadius[GetUnitAN(b)] * 1.2 
    set d2 = d * d 
    
    if(d < 150) then 
        set d = 150 
        set d2 = d * d 
    endif 
    
    if(GetUnitTypeId(b) == 'h03T') then 
        set r = gg_rct_MoonEscapePod 
    else 
        if(GetUnitTypeId(b) == 'h007') then 
            set r = gg_rct_ST3EscapePod 
        else 
            if(GetUnitTypeId(b) == 'h008') then 
                set r = gg_rct_PlanetEscapePod 
            else 
                if(GetUnitTypeId(b) == 'h003') then 
                    set r = gg_rct_ST1EscapePod 
                else 
                    if(GetUnitTypeId(b) == 'h009') then 
                        set r = gg_rct_ST4EscapePod 
                    else 
                        if(GetUnitTypeId(b) == 'h00X') then 
                            set r = gg_rct_ST5EscapePod 
                        else 
                            if(GetUnitTypeId(b) == 'h04T') then 
                                set r = gg_rct_ST9EscapePod 
                            else 
                                if(GetUnitTypeId(b) == 'h04V') then 
                                    set r = gg_rct_ST10EscapePod 
                                else 
                                    if(GetUnitTypeId(b) == 'h04E') then 
                                        set r = gg_rct_ST8EscapePod 
                                    else 
                                        if IsUnitExplorer(b) then 
                                            set r = udg_Spaceship_EnterExit[GetUnitAN(b)] 
                                        else 
                                            call DisplayTextToPlayer(GetOwningPlayer(a), 0, 0, "|cffFF0000INVALID TARGET|r") 
                                            set flag = true 
                                            //return null 
                                        endif 
                                    endif 
                                endif 
                            endif 
                        endif 
                    endif 
                endif 
            endif 
        endif 
    endif 
    
    if(not(flag)) then 
    
        set c = CreateUnitAtLoc(Player(PLAYER_NEUTRAL_PASSIVE), 'h04Z', loc, 0) 

        call SetUnitX(a, GetRectCenterX(gg_rct_Timeout)) 
        call SetUnitY(a, GetRectCenterY(gg_rct_Timeout)) 
        //call SetUnitOwner(a, Player(PLAYER_NEUTRAL_PASSIVE), true) 
        call UnitAddAbility(a, 'A08I') 
        call UnitAddAbility(a, 'Aloc') 
        
        //call DisplayTextToPlayer(Player(0), 0, 0, GetUnitName(c)) 
        //call DisplayTextToPlayer(Player(0), 0, 0, GetLocationX(loc2) + "," + GetLocationY(loc2) + " " + GetUnitX(c) + " " + GetUnitY(c)) 
    
    
        loop 
            exitwhen flag 
            set currentX = GetUnitX(c) 
            set currentY = GetUnitY(c) 
            set targetX = GetUnitX(b) 
            set targetY = GetUnitY(b) 
            set flag = ((Pow(targetX - currentX, 2) + Pow(targetY - currentY, 2)) <= d2) 
            set loc2 = Location(targetX, targetY) 
            set loc2 = Location(targetX, targetY) 
            call IssuePointOrderLocBJ(c, "move", loc2) 
            call IssuePointOrderLoc(c, "move", loc2) 
            call RemoveLocation(loc2) 
            if(GetUnitLifePercent(c) == 0) then 
                //call RemoveUnit(a) 
                set g3 = GetUnitsOfPlayerAll(qrqr) 
                set udg_TempUnit = a 
                call ForGroup(g3, function TransportedDestruction) 
                call DestroyGroup(g3) 
                call KillUnit(a) 
                call KillUnit(c) 
                return 
            endif 
            if GetUnitLifePercent(b) == 0 then 
                set b = gg_unit_h008_0196 
                set r = gg_rct_PlanetEscapePod 
            endif 
            
            call PolledWait(0.2) 
        endloop 
        call RemoveLocation(loc2) 
        //call SetUnitOwner(a, udg_Mutant, true) 
        //call PolledWait(0.01) 
        call UnitRemoveAbility(a, 'A08I') 
        call UnitRemoveAbility(a, 'Aloc') 
        call SetUnitX(a, GetRectCenterX(r)) 
        call SetUnitY(a, GetRectCenterY(r)) 
        call UnitDamageTarget(a, b, 10000, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS) 
        call KillUnit(a) 
        call KillUnit(c) 
        call RemoveLocation(loc) 
        call PolledWait(0.001) 
        set g = GetUnitsInRectOfPlayer(r, udg_Mutant) 
        set g2 = CreateGroup() 
        loop 
            set a = FirstOfGroup(g) 
            exitwhen a == null 
            if(UnitHasBuffBJ(a, 'B01C')) then 
                call UnitRemoveBuffBJ('B01C', a) 
                call UnitAddAbility(a, 'Avul') 
                call GroupAddUnit(g2, a) 
            endif 
            call GroupRemoveUnit(g, a) 
        endloop 
        call PolledWait(2.0) 
        loop 
            set a = FirstOfGroup(g2) 
            exitwhen a == null 
            call UnitRemoveAbility(a, 'Avul') 
        endloop 
        call DestroyGroup(g2) 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_Overlord_Pods takes nothing returns nothing 
    set gg_trg_Overlord_Pods = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Overlord_Pods, EVENT_PLAYER_UNIT_SPELL_CAST) 
    call TriggerAddCondition(gg_trg_Overlord_Pods, Condition(function Trig_Overlord_Pods_Conditions)) 
    call TriggerAddAction(gg_trg_Overlord_Pods, function Trig_Overlord_Pods_Actions) 
endfunction 

