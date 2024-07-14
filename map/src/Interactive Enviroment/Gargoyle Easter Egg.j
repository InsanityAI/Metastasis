function Trig_Gargoyle_Easter_Egg_Conditions takes nothing returns boolean
    if ( not ( GetTriggerUnit() == gg_unit_u000_0150 ) ) then
        return false
    endif
    return true
endfunction

function Trig_Gargoyle_Easter_Egg_Actions takes nothing returns nothing
    call CreateTextTagUnitBJ( "TRIGSTR_4794", gg_unit_u000_0150, 0, 10, 100, 100, 100, 0 )
    call SetTextTagVelocityBJ( GetLastCreatedTextTag(), 32.00, 90 )
    call SetTextTagPermanentBJ( GetLastCreatedTextTag(), false )
    call SetTextTagLifespanBJ( GetLastCreatedTextTag(), 5 )
    call SetTextTagFadepointBJ( GetLastCreatedTextTag(), 4 )
    call RemoveUnit( GetTriggerUnit() )
endfunction

//===========================================================================
function InitTrig_Gargoyle_Easter_Egg takes nothing returns nothing
    set gg_trg_Gargoyle_Easter_Egg = CreateTrigger(  )
    call TriggerRegisterPlayerSelectionEventBJ( gg_trg_Gargoyle_Easter_Egg, Player(0), true )
    call TriggerRegisterPlayerSelectionEventBJ( gg_trg_Gargoyle_Easter_Egg, Player(1), true )
    call TriggerRegisterPlayerSelectionEventBJ( gg_trg_Gargoyle_Easter_Egg, Player(2), true )
    call TriggerRegisterPlayerSelectionEventBJ( gg_trg_Gargoyle_Easter_Egg, Player(3), true )
    call TriggerRegisterPlayerSelectionEventBJ( gg_trg_Gargoyle_Easter_Egg, Player(4), true )
    call TriggerRegisterPlayerSelectionEventBJ( gg_trg_Gargoyle_Easter_Egg, Player(5), true )
    call TriggerRegisterPlayerSelectionEventBJ( gg_trg_Gargoyle_Easter_Egg, Player(6), true )
    call TriggerRegisterPlayerSelectionEventBJ( gg_trg_Gargoyle_Easter_Egg, Player(7), true )
    call TriggerRegisterPlayerSelectionEventBJ( gg_trg_Gargoyle_Easter_Egg, Player(8), true )
    call TriggerRegisterPlayerSelectionEventBJ( gg_trg_Gargoyle_Easter_Egg, Player(9), true )
    call TriggerRegisterPlayerSelectionEventBJ( gg_trg_Gargoyle_Easter_Egg, Player(10), true )
    call TriggerRegisterPlayerSelectionEventBJ( gg_trg_Gargoyle_Easter_Egg, Player(11), true )
    call TriggerAddCondition( gg_trg_Gargoyle_Easter_Egg, Condition( function Trig_Gargoyle_Easter_Egg_Conditions ) )
    call TriggerAddAction( gg_trg_Gargoyle_Easter_Egg, function Trig_Gargoyle_Easter_Egg_Actions )
endfunction

