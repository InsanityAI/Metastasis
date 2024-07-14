function Trig_Phase_Vortex_Conditions takes nothing returns boolean
    if ( not ( GetSpellAbilityId() == 'A09L' ) ) then
        return false
    endif
    return true
endfunction

function Trig_Phase_Vortex_Func011A takes nothing returns nothing
    set udg_Manacurrent1 = GetUnitStateSwap(UNIT_STATE_MANA, GetEnumUnit())
    call SetUnitManaBJ( GetEnumUnit(), ( GetUnitStateSwap(UNIT_STATE_MANA, GetEnumUnit()) - 40.00 ) )
    set udg_Manacurrent2 = GetUnitStateSwap(UNIT_STATE_MANA, GetEnumUnit())
    set udg_Manadrained = ( udg_Manacurrent1 - udg_Manacurrent2 )
    call SetUnitLifeBJ( GetEnumUnit(), ( GetUnitStateSwap(UNIT_STATE_LIFE, GetEnumUnit()) - udg_Manadrained ) )
    return
endfunction

function Trig_Phase_Vortex_Actions takes nothing returns nothing
    call SetUnitAnimation( GetTriggerUnit(), "Spell" )
    set udg_TempLoc3 = GetSpellTargetLoc()
    set udg_DMgroup = GetUnitsInRangeOfLocAll(300.00, udg_TempLoc3)
    call AddSpecialEffectLocBJ( udg_TempLoc3, "war3mapImported\\DarkNova.mdx" )
    call DestroyEffectBJ( GetLastCreatedEffectBJ() )
    call CreateTextTagLocBJ( "TRIGSTR_4550", udg_TempLoc3, 0, 8.00, 100, 100, 100, 0 )
    call SetTextTagPermanentBJ( GetLastCreatedTextTag(), false )
    call SetTextTagLifespanBJ( GetLastCreatedTextTag(), 1.50 )
    call ForGroupBJ( udg_DMgroup, function Trig_Phase_Vortex_Func011A )
    call DestroyTextTagBJ( GetLastCreatedTextTag() )
    call RemoveLocation(udg_TempLoc3)
    call DestroyGroup(udg_DMgroup)
endfunction

//===========================================================================
function InitTrig_Phase_Vortex takes nothing returns nothing
    set gg_trg_Phase_Vortex = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Phase_Vortex, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_Phase_Vortex, Condition( function Trig_Phase_Vortex_Conditions ) )
    call TriggerAddAction( gg_trg_Phase_Vortex, function Trig_Phase_Vortex_Actions )
endfunction

