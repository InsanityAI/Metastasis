function SentryGun_Filter takes nothing returns nothing 
    local location a = GetUnitLoc(GetEnumUnit()) 
    local real distance = DistanceBetweenPoints(a, udg_TempPoint) 
    if IsPlayerInForce(GetOwningPlayer(GetEnumUnit()), udg_SentryGunAllies[GetConvertedPlayerId(udg_TempPlayer)]) == false and GetUnitAbilityLevel(GetEnumUnit(), 'Avul') == 0 and GetUnitPointValue(GetEnumUnit()) != 37 and GetOwningPlayer(GetEnumUnit()) != Player(PLAYER_NEUTRAL_PASSIVE) and IsUnitAliveBJ(GetEnumUnit()) and(udg_Player_IsMasquerading[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] and IsPlayerInForce(udg_Player_MasqueradeTarget[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))], udg_SentryGunAllies[GetConvertedPlayerId(udg_TempPlayer)])) == false then 
        if distance < udg_TempReal then 
            set udg_TempUnit = GetEnumUnit() 
            set udg_TempReal = distance 
        endif 
    endif 
    call RemoveLocation(a) 
    set a = null 
endfunction 

function SentryGun_CheckTargets takes unit sentrygun, player owner returns nothing 
    local location sentryloc = GetUnitLoc(sentrygun) 
    local boolean b 
    if owner == Player(bj_PLAYER_NEUTRAL_EXTRA) then 
        set owner = udg_Parasite 
    endif 
    loop 
        exitwhen GetUnitLifePercent(sentrygun) <= 0.0 or sentrygun == null 
        set udg_TempReal = 100000000 
        set udg_TempUnit = null 
        set udg_TempPoint = sentryloc 
        set udg_TempPlayer = owner 
        set udg_SentryGunTempGroup = GetUnitsInRangeOfLocAll(650.0, sentryloc) 
        call ForGroup(udg_SentryGunTempGroup, function SentryGun_Filter) 
        set b = IssueTargetOrderBJ(sentrygun, "attack", udg_TempUnit) 
        if udg_TempUnit == null then 
            call IssueImmediateOrder(sentrygun, "stop") 
            call SetUnitFacingTimed(sentrygun, GetUnitFacing(sentrygun) + 27.9, 0.5) 
        endif 
        call DestroyGroup(udg_SentryGunTempGroup) 
        call PolledWait(0.5) 
    endloop 
    call RemoveLocation(sentryloc) 
    set sentryloc = null 
endfunction 





function Trig_SentryGunAI_Actions takes nothing returns nothing 
    //local trigger c=GetTriggeringTrigger()  
    //local unit b=GetHandleUnit(c, "sentry")  
    //   if (GetOwningPlayer(GetTriggerUnit()) != udg_SentryGun_OrigOwner[GetUnitAN(b)]) and GetOwningPlayer(GetTriggerUnit()) != Player(PLAYER_NEUTRAL_PASSIVE) then  
    //       call IssueTargetOrderBJ( b, "attack", GetTriggerUnit() )  
    //  endif  
endfunction 

//===========================================================================  
function SentryGunAI takes nothing returns nothing 
    call SentryGun_CheckTargets(udg_TempUnit, udg_SentryGun_OrigOwner[GetUnitAN(udg_TempUnit)]) 
    // set udg_SentryGun_TriggerAI[GetUnitAN(udg_TempUnit)] = CreateTrigger(  )  
    //call SetHandleHandle(udg_SentryGun_TriggerAI[GetUnitAN(udg_TempUnit)], "sentry", udg_TempUnit)  
    //   call TriggerRegisterUnitInRangeSimple( udg_SentryGun_TriggerAI[GetUnitAN(udg_TempUnit)], 600.00, udg_TempUnit )  
    //   call TriggerAddAction( udg_SentryGun_TriggerAI[GetUnitAN(udg_TempUnit)], function Trig_SentryGunAI_Actions )  
endfunction 

function InitTrig_SentryGunAI takes nothing returns nothing 
endfunction 
