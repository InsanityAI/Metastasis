function Trig_Alodimensional1_Actions takes nothing returns nothing
    set udg_HP_Comparison[( 2 + udg_HP_Index )] = GetUnitStateSwap(UNIT_STATE_LIFE, udg_Alodimensional_Being)
    set udg_HP_Comparison[( 3 + udg_HP_Index )] = ( udg_HP_Comparison[( 1 + udg_HP_Index )] - udg_HP_Comparison[( 2 + udg_HP_Index )] )
    call SetUnitLifeBJ( udg_Alodimensional_Being, ( GetUnitStateSwap(UNIT_STATE_LIFE, udg_Alodimensional_Being) + udg_HP_Comparison[( 3 + udg_HP_Index )] ) )
    call SetUnitManaBJ( udg_Alodimensional_Being, ( GetUnitStateSwap(UNIT_STATE_MANA, udg_Alodimensional_Being) - udg_HP_Comparison[( 3 + udg_HP_Index )] ) )
    set udg_HP_Index = ( udg_HP_Index + 1 )
    set udg_HP_Comparison[( 1 + udg_HP_Index )] = GetUnitStateSwap(UNIT_STATE_LIFE, udg_Alodimensional_Being)
endfunction

//===========================================================================
function InitTrig_Alodimensional1 takes nothing returns nothing
    set gg_trg_Alodimensional1 = CreateTrigger(  )
    call DisableTrigger( gg_trg_Alodimensional1 )
    call TriggerRegisterTimerEventPeriodic( gg_trg_Alodimensional1, 1.00 )
    call TriggerAddAction( gg_trg_Alodimensional1, function Trig_Alodimensional1_Actions )
endfunction

