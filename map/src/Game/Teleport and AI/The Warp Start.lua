if Debug then Debug.beginFile "Game/TeleportAndAI/TheWarpStart" end
OnInit.map("TheWarpStart", function(require)
    ---@return boolean
    function Trig_The_Warp_Start_Conditions()
        if (not (udg_Warp_enabled == false)) then
            return false
        end
        return true
    end

    function Trig_The_Warp_Start_Func003A()
        ForceAddPlayerSimple(GetOwningPlayer(GetEnumUnit()), udg_Warp_PG)
        DisplayTextToPlayer(GetOwningPlayer(GetEnumUnit()), 0, 0,
            "|CFFE55BB0Error: Teleportation UN-SUCCESFUL.\n\nLocation: U.N.K.N.O.W.N.\n\nRelocation initiating in_ 30 seconds.")
    end

    function Trig_The_Warp_Start_Func007A()
        TimerDialogDisplayForPlayerBJ(true, GetLastCreatedTimerDialogBJ(), GetEnumPlayer())
    end

    function Trig_The_Warp_Start_Actions()
        udg_TempUnitGroup2 = GetUnitsInRectAll(gg_rct_Warp)
        ForGroupBJ(udg_TempUnitGroup2, Trig_The_Warp_Start_Func003A)
        StartTimerBJ(udg_WarpTimer, false, 30.00)
        CreateTimerDialogBJ(udg_WarpTimer, "TRIGSTR_4649")
        TimerDialogDisplayBJ(false, GetLastCreatedTimerDialogBJ())
        ForForce(udg_Warp_PG, Trig_The_Warp_Start_Func007A)
        DestroyGroup(udg_TempUnitGroup2)
        udg_Warp_Timer_Window = GetLastCreatedTimerDialogBJ()
        PlaySoundAtPointBJ(gg_snd_MarkOfChaos, 100, GetRectCenter(gg_rct_Warp), 0)
        udg_Warp_Effect = GetRandomLocInRect(gg_rct_Warp)
        AddSpecialEffectLocBJ(udg_Warp_Effect, "Abilities\\Spells\\Human\\Feedback\\ArcaneTowerAttack.mdl")
        DestroyEffectBJ(GetLastCreatedEffectBJ())
        AddSpecialEffectLocBJ(udg_Warp_Effect, "Abilities\\Spells\\Human\\FlameStrike\\FlameStrikeTarget.mdl")
        DestroyEffectBJ(GetLastCreatedEffectBJ())
        CreateNUnitsAtLocFacingLocBJ(1, FourCC(FourCC('n00H')), Player(PLAYER_NEUTRAL_AGGRESSIVE),
            GetRandomLocInRect(gg_rct_Warp), GetRandomLocInRect(gg_rct_Warp))
        RemoveLocation(udg_Warp_Effect)
        EnableTrigger(gg_trg_The_Warp_ongoing)
        EnableTrigger(gg_trg_The_Warp_relocation)
        EnableTrigger(gg_trg_The_Warp_ongoing_spawn)
        DisableTrigger(GetTriggeringTrigger())
    end

    --===========================================================================
    gg_trg_The_Warp_Start = CreateTrigger()
    DisableTrigger(gg_trg_The_Warp_Start)
    TriggerAddCondition(gg_trg_The_Warp_Start, Condition(Trig_The_Warp_Start_Conditions))
    TriggerAddAction(gg_trg_The_Warp_Start, Trig_The_Warp_Start_Actions)
end)
if Debug then Debug.endFile() end
