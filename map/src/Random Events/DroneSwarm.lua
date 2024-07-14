//TESH.scrollpos=0
//TESH.alwaysfold=0

function HostileSpaceAIDrone_Cond takes nothing returns boolean
    if GetOwningPlayer(GetFilterUnit()) != Player(PLAYER_NEUTRAL_AGGRESSIVE) and GetUnitState(GetFilterUnit(), UNIT_STATE_LIFE) > 0 then
        return true
    endif
    
    return false
endfunction

function HostileSpaceAIDroneExpTimer takes nothing returns nothing
    local group g = CreateGroup()
    local location o
    local boolexpr f = Condition(function HostileSpaceAIDrone_Cond)
    local timer t = GetExpiredTimer()                  
    local integer h = GetHandleId(t)
    local unit a = LoadUnitHandle(LS(), h, StringHash("a"))
        
    set o = GetUnitLoc(a)
    call GroupEnumUnitsInRect(g, gg_rct_Space, f)
    call RemoveLocation(o)

    if FirstOfGroup(g) == gg_unit_h008_0196 then
        if CountUnitsInGroup(g) ==1 then
            call UnitRemoveTypeBJ( UNIT_TYPE_SAPPER, gg_unit_h008_0196 )
        else
            call GroupRemoveUnit(g,gg_unit_h008_0196)
        endif
    endif
        
    set o = GetUnitLoc(FirstOfGroup(g))
    call IssuePointOrderLoc(a,"attack",o)
    
    call RemoveLocation(o)
    call DestroyGroup(g)
    call DestroyBoolExpr(f)
    set o =  null
    set g = null
    set f = null
    set a = null
    set t = null
endfunction

function HostileSpaceAIDrone takes nothing returns nothing
    local group g = CreateGroup()
    local location o
    local boolexpr f = Condition(function HostileSpaceAIDrone_Cond)
    local unit a = udg_TempUnit
    local timer t = CreateTimer()
    local integer h = GetHandleId(t)
    
    set o = GetUnitLoc(a)
    call GroupEnumUnitsInRect(g, gg_rct_Space, f)
    call RemoveLocation(o)

    if FirstOfGroup(g) == gg_unit_h008_0196 then
        if CountUnitsInGroup(g) ==1 then
            call UnitRemoveTypeBJ( UNIT_TYPE_SAPPER, gg_unit_h008_0196 )
        else
            call GroupRemoveUnit(g,gg_unit_h008_0196)
        endif
    endif
        
    set o = GetUnitLoc(FirstOfGroup(g))
    call IssuePointOrderLoc(a,"attack",o)
    
    loop
        exitwhen GetUnitState(a, UNIT_STATE_LIFE) <= 0
        call SaveUnitHandle(LS(), h, StringHash("a"), a)
        call TimerStart(t, 10.00, true, function HostileSpaceAIDroneExpTimer)
    endloop
    
    call DestroyTimer(t)
    call RemoveLocation(o)
    call DestroyGroup(g)
    call DestroyBoolExpr(f)
    set o =  null
    set g = null
    set f = null
    set a = null
    set t = null
endfunction

function Trig_DroneSwarm_Actions takes nothing returns nothing
    local integer a
    local integer b
    
    call DestroyTrigger(GetTriggeringTrigger())
    set udg_RandomEvent_On[9] = true
    
    //Code becomes 9999999999 when it is used.
    //In short, this is the boolean flag of BHD having spawned -> doesn't care about syllus -_-
    if udg_Secret_ControlCode == 9999999999 then //GTFO because it will lag the map to infinite!
        call TimerStart(udg_RandomEvent, GetRandomReal(1.00, 2.00), false, null)
        return
    endif
    
    call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "TRIGSTR_1742")
    call StartSound(gg_snd_PursuitTheme)
    call RemoveAllGuardPositions(Player(PLAYER_NEUTRAL_AGGRESSIVE))
    
    set a = 1
    set b = 50
    
    loop
        exitwhen a > b
        call TriggerSleepAction(1.00)
        set udg_TempPoint = GetRandomLocInRect(gg_rct_Space)
        call PingMinimapLocForForce(GetPlayersAll(), udg_TempPoint, 1.00)
        call CreateNUnitsAtLoc(1, 'h02T', Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING)
        set bj_lastCreatedEffect = AddSpecialEffectLoc("Objects\\Spawnmodels\\NightElf\\NEDeathSmall\\NEDeathSmall.mdl", udg_TempPoint)
        call SFXThreadClean()
        set udg_TempUnit = bj_lastCreatedUnit
        call ExecuteFunc("HostileSpaceAIDrone")
        call RemoveLocation(udg_TempPoint)
        set a = a + 1
    endloop
    
    call TimerStart(udg_RandomEvent, GetRandomReal(90.00, 1200.00), false, null)
endfunction

//===========================================================================
function InitTrig_DroneSwarm takes nothing returns nothing
    set gg_trg_DroneSwarm = CreateTrigger(  )
    call DisableTrigger( gg_trg_DroneSwarm )
    call TriggerAddAction( gg_trg_DroneSwarm, function Trig_DroneSwarm_Actions )
endfunction