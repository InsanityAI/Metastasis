function Trig_ST4DefenseDrone1_Conditions takes nothing returns boolean
    if ( not ( IsUnitIllusionBJ(GetTriggerUnit()) == false ) ) then
        return false
    endif
    if ( not ( GetUnitPointValue(GetTriggerUnit()) != 37 ) ) then
        return false
    endif
    return true
endfunction

function Trig_ST4DefenseDrone1_Func004C takes nothing returns boolean
    if ( not ( IsUnitAliveBJ(gg_unit_h00B_0032) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_ST4DefenseDrone1_Func005C takes nothing returns boolean
    if ( not ( SubStringBJ(I2S(GetUnitPointValue(GetTriggerUnit())), 1, 1) == "1" ) ) then
        return false
    endif
    return true
endfunction

function Trig_ST4DefenseDrone1_Func006C takes nothing returns boolean
    if ( not ( GetOwningPlayer(gg_unit_h00B_0032) == Player(PLAYER_NEUTRAL_PASSIVE) ) ) then
        return false
    endif
    return true
endfunction

function Trig_ST4DefenseDrone1_Actions takes nothing returns nothing
    if ( Trig_ST4DefenseDrone1_Func004C() ) then
    else
           call DestroyTrigger( GetTriggeringTrigger() )
        call DestroyTrigger(gg_trg_ST4DefenseDrone1Loss)
    endif
    if ( Trig_ST4DefenseDrone1_Func005C() ) then
        call DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, "|cffffcc00This unit cannot pilot space stations/ships.|r")
        return
    else
    endif
    if ( Trig_ST4DefenseDrone1_Func006C() ) then
        call SetUnitOwner( gg_unit_h00B_0032, GetOwningPlayer(GetTriggerUnit()), false )
        call SelectUnitForPlayerSingle( gg_unit_h00B_0032, GetOwningPlayer(GetTriggerUnit()) )
        call KillDestructable( gg_dest_XTmp_1430 )
        set udg_TempUnit = gg_unit_h00B_0032
        set udg_TempRect = gg_rct_DD1
        call CheckConsoleControl(udg_TempUnit,udg_TempUnit,udg_TempRect)
    else
    endif
endfunction

//===========================================================================
function InitTrig_ST4DefenseDrone1 takes nothing returns nothing
    set gg_trg_ST4DefenseDrone1 = CreateTrigger(  )
    call TriggerRegisterEnterRectSimple( gg_trg_ST4DefenseDrone1, gg_rct_DD1 )
    call TriggerAddCondition( gg_trg_ST4DefenseDrone1, Condition( function Trig_ST4DefenseDrone1_Conditions ) )
    call TriggerAddAction( gg_trg_ST4DefenseDrone1, function Trig_ST4DefenseDrone1_Actions )
endfunction

