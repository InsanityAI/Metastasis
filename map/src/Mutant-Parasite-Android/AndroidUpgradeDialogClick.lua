//TESH.scrollpos=48
//TESH.alwaysfold=0
function Trig_AndroidUpgradeDialogClick_Actions takes nothing returns nothing
    local unit c=udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)]
    local location b=GetRectCenter(gg_rct_AndroidUpgrade)
    local effect r
    local integer i=0
    local integer m
    local item i1
    local item i2
    local item i3
    local item i4
    local item i5
    local item i6
    
    //[1] is Cancel option
    if ( GetClickedButtonBJ() == udg_AndroidUpgradeDialogButtons[1] ) then
        call RemoveLocation(b)
        set udg_Android_DialogOn=false
        return
    endif
    
    //Loop, iterating through android evolution choices
    set bj_forLoopAIndex = 2
    set bj_forLoopAIndexEnd = 10
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        if ( GetClickedButtonBJ() == udg_AndroidUpgradeDialogButtons[GetForLoopIndexA()] ) then
            set m = udg_Android_UpgradingTo[GetForLoopIndexA()]
        endif
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    
    call ChangeElevatorWalls( false, bj_ELEVATOR_WALL_TYPE_ALL, gg_dest_DTrx_0642 )
    call ChangeElevatorHeight( gg_dest_DTrx_0642, 3 )
    call UnitAddAbilityBJ( 'Avul', c )//Invulnerable
    call PauseUnit(c,true)
    call SetUnitTimeScalePercent(c,0.0)
    call SetUnitPositionLoc(c,b)
    
    loop
        exitwhen i > 60.0
        set r= AddSpecialEffectLocBJ( b, "war3mapImported\\AncientExplode.mdl" )
        set i=i+1
        call PolledWait(0.5)//Emphasis here! This is where the delay of evolution happens!
        call DestroyEffect(r)
    endloop
    
    call RemoveLocation(b)
    set i1=UnitItemInSlotBJ(udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)],1)
    set i2=UnitItemInSlotBJ(udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)],2)
    set i3=UnitItemInSlotBJ(udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)],3)
    set i4=UnitItemInSlotBJ(udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)],4)
    set i5=UnitItemInSlotBJ(udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)],5)
    set i6=UnitItemInSlotBJ(udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)],6)
    set i=1
    
    loop
        exitwhen i > 6
        call UnitDropItem(udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)],i)
        set i=i+1
    endloop
    
    call ReplaceUnitBJ( udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)], m, bj_UNIT_STATE_METHOD_RELATIVE )

    set udg_Android_Preference=m
    set udg_Playerhero[GetConvertedPlayerId(udg_HiddenAndroid)] = GetLastReplacedUnitBJ()
        call UnitAddItem(GetLastReplacedUnitBJ(),i1)
            call UnitAddItem(GetLastReplacedUnitBJ(),i2)
                call UnitAddItem(GetLastReplacedUnitBJ(),i3)
                    call UnitAddItem(GetLastReplacedUnitBJ(),i4)
                        call UnitAddItem(GetLastReplacedUnitBJ(),i5)
                            call UnitAddItem(GetLastReplacedUnitBJ(),i6)
    call ChangeElevatorHeight( gg_dest_DTrx_0642, 1 )
    call ChangeElevatorWalls( true, bj_ELEVATOR_WALL_TYPE_ALL, gg_dest_DTrx_0642 )
    call UnitAddAbilityForPeriod(GetLastReplacedUnitBJ(),'Avul',6.0)//Invulnerable
    
    //Below makes the color be neutral
    //if GetUnitTypeId(GetLastReplacedUnitBJ())=='h047' then
        //call SetUnitColor(GetLastReplacedUnitBJ(),ConvertPlayerColor(12))
    //endif
endfunction

//===========================================================================
function InitTrig_AndroidUpgradeDialogClick takes nothing returns nothing
    set gg_trg_AndroidUpgradeDialogClick = CreateTrigger(  )
    call TriggerRegisterDialogEventBJ( gg_trg_AndroidUpgradeDialogClick, udg_AndroidUpgradeDialog )
    call TriggerAddAction( gg_trg_AndroidUpgradeDialogClick, function Trig_AndroidUpgradeDialogClick_Actions )
endfunction

