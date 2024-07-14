function Trig_SlugglyInfestation_Func007C takes nothing returns boolean
    if ( not ( IsUnitAliveBJ(gg_unit_h009_0029) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_SlugglyInfestation_Func009C takes nothing returns boolean
    if ( not ( IsUnitAliveBJ(gg_unit_h003_0018) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_SlugglyInfestation_Func011C takes nothing returns boolean
    if ( not ( IsUnitAliveBJ(gg_unit_h007_0027) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_SlugglyInfestation_Func013C takes nothing returns boolean
    if ( not ( IsUnitAliveBJ(gg_unit_h00X_0049) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_SlugglyInfestation_Actions takes nothing returns nothing
    call DestroyTrigger(GetTriggeringTrigger())
    set udg_RandomEvent_On[3] = true
    call DisplayTextToForce( GetPlayersAll(), "TRIGSTR_4177" )
    call StartTimerBJ( udg_RandomEvent, false, GetRandomReal(240.00, 300.00) )
    return
    // Niffy
    if ( Trig_SlugglyInfestation_Func007C() ) then
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 10
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            set udg_TempPoint = GetRandomLocInRect(gg_rct_ST4V11)
            call CreateNUnitsAtLoc( 1, 'n003', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg() )
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 10
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            set udg_TempPoint = GetRandomLocInRect(gg_rct_ST4V7)
            call CreateNUnitsAtLoc( 1, 'n003', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg() )
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 10
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            set udg_TempPoint = GetRandomLocInRect(gg_rct_ST4V18)
            call CreateNUnitsAtLoc( 1, 'n003', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg() )
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 10
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            set udg_TempPoint = GetRandomLocInRect(gg_rct_ST4V30)
            call CreateNUnitsAtLoc( 1, 'n003', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg() )
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 10
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            set udg_TempPoint = GetRandomLocInRect(gg_rct_ST4V3)
            call CreateNUnitsAtLoc( 1, 'n003', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg() )
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
    else
    endif
    // Arbitress
    if ( Trig_SlugglyInfestation_Func009C() ) then
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 8
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            set udg_TempPoint = GetRandomLocInRect(gg_rct_STV2)
            call CreateNUnitsAtLoc( 1, 'n003', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg() )
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 8
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            set udg_TempPoint = GetRandomLocInRect(gg_rct_STV3)
            call CreateNUnitsAtLoc( 1, 'n003', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg() )
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
    else
    endif
    // Kyo
    if ( Trig_SlugglyInfestation_Func011C() ) then
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 8
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            set udg_TempPoint = GetRandomLocInRect(gg_rct_ST3V3)
            call CreateNUnitsAtLoc( 1, 'n003', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg() )
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 8
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            set udg_TempPoint = GetRandomLocInRect(gg_rct_ST3V1)
            call CreateNUnitsAtLoc( 1, 'n003', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg() )
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 8
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            set udg_TempPoint = GetRandomLocInRect(gg_rct_ST3V4)
            call CreateNUnitsAtLoc( 1, 'n003', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg() )
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
    else
    endif
    // Swagger
    if ( Trig_SlugglyInfestation_Func013C() ) then
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 24
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            set udg_TempPoint = GetRandomLocInRect(gg_rct_ST5V2)
            call CreateNUnitsAtLoc( 1, 'n003', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg() )
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
    else
    endif
endfunction

//===========================================================================
function InitTrig_SlugglyInfestation takes nothing returns nothing
    set gg_trg_SlugglyInfestation = CreateTrigger(  )
    call DisableTrigger( gg_trg_SlugglyInfestation )
    call TriggerAddAction( gg_trg_SlugglyInfestation, function Trig_SlugglyInfestation_Actions )
endfunction

