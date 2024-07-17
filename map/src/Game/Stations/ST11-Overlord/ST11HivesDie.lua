if Debug then Debug.beginFile "Game/Stations/ST11/ST11HivesDie" end
OnInit.trig("ST11HivesDie", function(require)
    function Trig_ST11HivesDie_Func004Func003A()
        DisplayTextToPlayer(GetEnumPlayer(), 0, 0,
            "The Overlord has been slain! Flee his body or BE DOOMED TO A HORRIBLE DEATH.")
    end

    ---@return boolean
    function Trig_ST11HivesDie_Func004Func008C()
        if (not (IsUnitAliveBJ(gg_unit_h04X_0172) == false)) then
            return false
        end
        if (not (IsUnitAliveBJ(gg_unit_h04X_0148) == false)) then
            return false
        end
        if (not (IsUnitAliveBJ(gg_unit_h04X_0173) == false)) then
            return false
        end
        if (not (IsUnitAliveBJ(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)]) == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ST11HivesDie_Func004C()
        if (not Trig_ST11HivesDie_Func004Func008C()) then
            return false
        end
        return true
    end

    function Trig_ST11HivesDie_Actions()
        if (Trig_ST11HivesDie_Func004C()) then
            DestroyTrigger(GetTriggeringTrigger())
            SetUnitOwner(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)], Player(PLAYER_NEUTRAL_PASSIVE), false)
            ForForce(GetPlayersAll(), Trig_ST11HivesDie_Func004Func003A)
            DisplayTextToForce(GetForceOfPlayer(udg_Mutant),
                "\nDONT Panic.\nYou have 35 seconds to kill every invader and win the game!")
            StartTimerBJ(udg_OverlordDeath_DestructionTimer, false, 35.00)
            CreateTimerDialogBJ(GetLastCreatedTimerBJ(), "TRIGSTR_4087")
            udg_OverlordDeath_TimerWindow = GetLastCreatedTimerDialogBJ()
        else
        end
    end

    --===========================================================================
    gg_trg_ST11HivesDie = CreateTrigger()
    DisableTrigger(gg_trg_ST11HivesDie)
    TriggerRegisterUnitEvent(gg_trg_ST11HivesDie, gg_unit_h04X_0173, EVENT_UNIT_DEATH)
    TriggerRegisterUnitEvent(gg_trg_ST11HivesDie, gg_unit_h04X_0148, EVENT_UNIT_DEATH)
    TriggerRegisterUnitEvent(gg_trg_ST11HivesDie, gg_unit_h04X_0172, EVENT_UNIT_DEATH)
    TriggerAddAction(gg_trg_ST11HivesDie, Trig_ST11HivesDie_Actions)
end)
if Debug then Debug.endFile() end
