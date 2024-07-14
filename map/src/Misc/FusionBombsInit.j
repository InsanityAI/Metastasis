function Trig_FusionBombsInit_Func003A takes nothing returns nothing
    call SetUnitAnimation( GetEnumUnit(), "stand work" )
endfunction

function Trig_FusionBombsInit_Func007A takes nothing returns nothing
    call ResetUnitAnimation( GetEnumUnit() )
endfunction

function Trig_FusionBombsInit_Actions takes nothing returns nothing
    set udg_TempUnitGroup = GetUnitsOfTypeIdAll('h014')
    call ForGroupBJ( udg_TempUnitGroup, function Trig_FusionBombsInit_Func003A )
        call DestroyGroup( udg_TempUnitGroup )
    call PolledWait( 58.00 )
    set udg_TempUnitGroup = GetUnitsOfTypeIdAll('h014')
    call ForGroupBJ( udg_TempUnitGroup, function Trig_FusionBombsInit_Func007A )
        call DestroyGroup( udg_TempUnitGroup )
endfunction

//===========================================================================
function InitTrig_FusionBombsInit takes nothing returns nothing
    set gg_trg_FusionBombsInit = CreateTrigger(  )
    call TriggerAddAction( gg_trg_FusionBombsInit, function Trig_FusionBombsInit_Actions )
endfunction

