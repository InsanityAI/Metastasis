function Trig_ExplorerPower_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A06D' ) ) then
        return false
    endif
    return true
endfunction

function Trig_ExplorerPower_Func005Func001C takes nothing returns boolean
    if not (IsUnitExplorer(GetEnumUnit())) then
    return false
    endif
    return true
endfunction

function Trig_ExplorerPower_Func005A takes nothing returns nothing
    if ( Trig_ExplorerPower_Func005Func001C() ) then
        call UnitAddAbilityBJ( 'A06K', GetEnumUnit() )
        call UnitAddAbilityBJ( 'A06J', GetEnumUnit() )
        call UnitAddAbilityBJ( 'A06I', GetEnumUnit() )
    else
    endif
endfunction

function Trig_ExplorerPower_Actions takes nothing returns nothing
    call TriggerExecute( gg_trg_ResetPowerBonus )
    set udg_Power_Bonus = 2
    call ForGroupBJ( GetUnitsInRectAll(GetPlayableMapRect()), function Trig_ExplorerPower_Func005A )
    call PlaySoundBJ( gg_snd_LightningShieldTarget )
endfunction

//===========================================================================
function InitTrig_ExplorerPower takes nothing returns nothing
    set gg_trg_ExplorerPower = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_ExplorerPower, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_ExplorerPower, Condition( function Trig_ExplorerPower_Conditions ) )
    call TriggerAddAction( gg_trg_ExplorerPower, function Trig_ExplorerPower_Actions )
endfunction

