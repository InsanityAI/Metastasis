function USAD_AbilCode takes nothing returns boolean 
    return GetSpellAbilityId() == 'A06S'
endfunction 

function Trig_ScanAcquireASAD_Func001Func003Func001Func001C takes nothing returns boolean 
    if(not(GetOwningPlayer(GetEnumUnit()) != Player(PLAYER_NEUTRAL_PASSIVE))) then 
        return false 
    endif 
    if(not(GetOwningPlayer(GetEnumUnit()) != Player(PLAYER_NEUTRAL_AGGRESSIVE))) then 
        return false 
    endif 
    if(not(RectContainsUnit(gg_rct_Space, GetEnumUnit()) == false)) then 
        return false 
    endif 
    if(not(udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] == GetEnumUnit())) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_ScanAcquireASAD_Func001Func003Func001A takes nothing returns nothing 
    if(Trig_ScanAcquireASAD_Func001Func003Func001Func001C()) then 
        set udg_TempPoint = GetUnitLoc(GetEnumUnit()) 
        if GetOwningPlayer(GetSpellAbilityUnit()) != Player(bj_PLAYER_NEUTRAL_EXTRA) then 
            call PingMinimapLocForForceEx(GetPlayersAll(), udg_TempPoint, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100, 100, 100) 
        else 
            call PingMinimapLocForForceEx(GetPlayersAll(), udg_TempPoint, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100, 100, 100) 
        endif 
        call RemoveLocation(udg_TempPoint) 
    else 
    endif 
    if IsUnitExplorer(GetEnumUnit()) and ShipHasUnits(GetEnumUnit()) and not RectContainsUnit(gg_rct_Timeout, GetEnumUnit()) then 
        set udg_TempPoint2 = GetUnitLoc(GetEnumUnit()) 
        if GetOwningPlayer(GetSpellAbilityUnit()) != Player(bj_PLAYER_NEUTRAL_EXTRA) then 
            call PingMinimapLocForForceEx(GetPlayersAll(), udg_TempPoint2, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100.00, 25.00, 50.00) 
        else 
            call PingMinimapLocForForceEx(GetPlayersAll(), udg_TempPoint2, 7.00, bj_MINIMAPPINGSTYLE_SIMPLE, 100.00, 25.00, 50.00) 
        endif 
        call RemoveLocation(udg_TempPoint2) 
    else 
    endif 
endfunction 

function Trig_ScanAcquireASAD_Actions takes nothing returns nothing 
    local unit q 
    local group g 
    if GetSpellTargetUnit() == gg_unit_h019_0155 then 
        call CreateNUnitsAtLoc(1, 'h04C', Player(PLAYER_NEUTRAL_PASSIVE), Location(-11410.00, 15466.00), GetRandomDirectionDeg()) 
        set q = bj_lastCreatedUnit 
        call RemoveItem(GetItemOfTypeFromUnitBJ(GetSpellAbilityUnit(), 'I01S')) 
        loop 
            exitwhen IsUnitAliveBJ(q) != true 
            call DisplayTextToForce(GetPlayersAll(), "|cff00FFFFU.S.I. Arbitress Scanning...") 
            set g = GetUnitsInRectAll(GetPlayableMapRect()) 
            call ForGroupBJ(g, function Trig_ScanAcquireASAD_Func001Func003Func001A) 
            call DestroyGroup(g) 
            call PolledWait(45.00) 
        endloop 
    else 
        call UnitRemoveItemSwapped(GetManipulatedItem(), gg_unit_h019_0155) 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_ScanAcquireASAD takes nothing returns nothing 
    set gg_trg_ScanAcquireASAD = CreateTrigger() 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_ScanAcquireASAD, EVENT_PLAYER_UNIT_SPELL_EFFECT) 
    call TriggerAddCondition(gg_trg_ScanAcquireASAD, Condition(function USAD_AbilCode)) 
    call TriggerAddAction(gg_trg_ScanAcquireASAD, function Trig_ScanAcquireASAD_Actions) 
endfunction 

