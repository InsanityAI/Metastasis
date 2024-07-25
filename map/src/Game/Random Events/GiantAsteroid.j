function Trig_GiantAsteroid_Actions takes nothing returns nothing 
    local integer i = 7 
    local integer b = 0 
    local group g = GetUnitsInRectAll(gg_rct_Space) 
    call DestroyTrigger(GetTriggeringTrigger()) 
    set udg_RandomEvent_On[12] = true 
    set udg_TempUnitGroup = GetUnitsInRectAll(gg_rct_Space) 
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_3443") 
    call StartTimerBJ(udg_RandomEvent, false, GetRandomReal(90.00, 1200.00)) 
    call PlaySoundBJ(gg_snd_Warning01) 
    loop 
        exitwhen i > 11 
        set b = 0 
        loop 
            exitwhen b > i 
            set udg_TempPoint = GetRandomLocInRect(gg_rct_GiantAsteroidSpawn) 
            call CreateNUnitsAtLoc(1, 'h04D', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg()) 
            call SetUnitTimeScalePercent(GetLastCreatedUnit(), GetRandomReal(0.00, 50.00)) 
            set udg_TempReal = GetRandomReal(0, 1) 
            set udg_TempReal2 = ((udg_TempReal * 200.00) + 50.00) 
            call SetUnitScalePercent(GetLastCreatedUnit(), udg_TempReal2, udg_TempReal2, udg_TempReal2) 
            call SetUnitLifePercentBJ(GetLastCreatedUnit(), (udg_TempReal * 100.00)) 
            call RemoveLocation(udg_TempPoint) 
            set udg_TempUnit = GetLastCreatedUnit() 
            if GetRandomInt(1, 2) == 1 then 
                call GiantAsteroid(udg_TempUnit, AngleBetweenUnits(udg_TempUnit, GroupPickRandomUnit(g))) 
            else 
                call GiantAsteroid(udg_TempUnit, 90 + GetRandomReal(-20.0, 20.0)) 
            endif 
            call DestroyGroup(udg_TempUnitGroup) 
            set b = b + 1 
        endloop 
        call PolledWait(GetRandomReal(0.1, 5)) 
        set i = i + 1 
    endloop 
    call DestroyGroup(g) 
    set g = null 
endfunction 

//=========================================================================== 
function InitTrig_GiantAsteroid takes nothing returns nothing 
    set gg_trg_GiantAsteroid = CreateTrigger() 
    call DisableTrigger(gg_trg_GiantAsteroid) 
    call TriggerAddAction(gg_trg_GiantAsteroid, function Trig_GiantAsteroid_Actions) 
endfunction 

