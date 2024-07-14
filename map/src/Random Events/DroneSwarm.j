globals
    integer dronesSpawned = 1
endglobals

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
        
    call GroupEnumUnitsInRect(g, gg_rct_Space, f)
    if FirstOfGroup(g) == gg_unit_h008_0196 then
        if BlzGroupGetSize(g) ==1 then
            call UnitRemoveTypeBJ( UNIT_TYPE_SAPPER, gg_unit_h008_0196 )
        else
            call GroupRemoveUnit(g,gg_unit_h008_0196)
        endif
    endif
        
    set o = GetUnitLoc(FirstOfGroup(g))
    call IssuePointOrderLoc(a,"attack",o)
    
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

function HostileSpaceAIDrone takes unit a returns nothing
    local group g = CreateGroup()
    local location o
    local boolexpr f = Condition(function HostileSpaceAIDrone_Cond)
    local timer t = CreateTimer()
    local integer h = GetHandleId(t)

    call GroupEnumUnitsInRect(g, gg_rct_Space, f)
    if FirstOfGroup(g) == gg_unit_h008_0196 then
        if BlzGroupGetSize(g) ==1 then
            call UnitRemoveTypeBJ( UNIT_TYPE_SAPPER, gg_unit_h008_0196 )
        else
            call GroupRemoveUnit(g,gg_unit_h008_0196)
        endif
    endif
        
    set o = GetUnitLoc(FirstOfGroup(g))
    call IssuePointOrderLoc(a,"attack",o)
    
    call SaveUnitHandle(LS(), h, StringHash("a"), a)
    call TimerStart(t, 10.00, true, function HostileSpaceAIDroneExpTimer)

    call RemoveLocation(o)
    call DestroyGroup(g)
    call DestroyBoolExpr(f)
    set o =  null
    set g = null
    set f = null
    set t = null
endfunction

function SpawnDrone takes nothing returns nothing
    if dronesSpawned >= 50 then
        call PauseTimer(GetExpiredTimer())
        call DestroyTimer(GetExpiredTimer())
        call TimerStart(udg_RandomEvent, GetRandomReal(90.00, 1200.00), false, null)
        return
    endif

    set dronesSpawned = dronesSpawned + 1

    set udg_TempPoint = GetRandomLocInRect(gg_rct_Space)
    call PingMinimapLocForForce(GetPlayersAll(), udg_TempPoint, 1.00)
    set udg_TempUnit = CreateUnitAtLoc(Player(PLAYER_NEUTRAL_AGGRESSIVE), 'h02T', udg_TempPoint, bj_UNIT_FACING)
    call DestroyEffect(AddSpecialEffectLoc("Objects\\Spawnmodels\\NightElf\\NEDeathSmall\\NEDeathSmall.mdl", udg_TempPoint))
    call HostileSpaceAIDrone(udg_TempUnit)
    call RemoveLocation(udg_TempPoint)
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
    
    call TimerStart(CreateTimer(), 1.00, true, function SpawnDrone)
endfunction

//===========================================================================
function InitTrig_DroneSwarm takes nothing returns nothing
    set gg_trg_DroneSwarm = CreateTrigger(  )
    call DisableTrigger( gg_trg_DroneSwarm )
    call TriggerAddAction( gg_trg_DroneSwarm, function Trig_DroneSwarm_Actions )
endfunction