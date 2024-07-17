if Debug then Debug.beginFile "Game/Stations/ST4/RepositioningDriveGo" end
OnInit.map("RepositioningDriveGo", function(require)
    ---@return boolean
    function Trig_RepositioningDriveGo_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A074'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_RepositioningDriveGo_Func002C()
        if (not (RectContainsLoc(gg_rct_Space, udg_TempPoint) == false)) then
            return false
        end
        return true
    end

    function Trig_RepositioningDriveGo_Actions()
        local a ---@type location
        local b ---@type location
        udg_TempPoint = GetSpellTargetLoc()
        a = udg_TempPoint
        if (Trig_RepositioningDriveGo_Func002C()) then
            IssueImmediateOrderBJ(gg_unit_h009_0029, "stop")
            RemoveLocation(udg_TempPoint)
            return
        else
        end
        PauseUnit(gg_unit_h009_0029, true)
        b = GetUnitLoc(gg_unit_h009_0029)
        CreateNUnitsAtLoc(1, FourCC('e021'), Player(PLAYER_NEUTRAL_PASSIVE), b, bj_UNIT_FACING)
        SizeUnitOverTime(GetLastCreatedUnit(), 20.0, 0.1, 8, true)
        TintUnitOverTime(gg_unit_h009_0029, 20.2, 0, 100, 10)
        PolledWait(16.50)
        SetSoundPositionLocBJ(gg_snd_Poweringup, b, 0)
        PlaySoundBJ(gg_snd_Poweringup)
        PolledWait(3.5)
        PauseUnit(gg_unit_h009_0029, false)
        CreateNUnitsAtLoc(1, FourCC('e005'), Player(PLAYER_NEUTRAL_PASSIVE), a, bj_UNIT_FACING)
        SetUnitScale(GetLastCreatedUnit(), 6, 6, 6)
        SetUnitTimeScale(GetLastCreatedUnit(), 2.0)
        CreateNUnitsAtLoc(1, FourCC('e005'), Player(PLAYER_NEUTRAL_PASSIVE), b, bj_UNIT_FACING)
        SetUnitScale(GetLastCreatedUnit(), 6, 6, 6)
        SetUnitTimeScale(GetLastCreatedUnit(), 2.0)
        SetUnitPositionLoc(gg_unit_h009_0029, a)
        SetSoundPositionLocBJ(gg_snd_NightElfBuildingDeathSmall1, a, 0)
        PlaySoundBJ(gg_snd_NightElfBuildingDeathSmall1)
        SetSoundPositionLocBJ(gg_snd_NightElfBuildingDeathSmall1, b, 0)
        PlaySoundBJ(gg_snd_NightElfBuildingDeathSmall1)
        RemoveLocation(a)
        RemoveLocation(b)
        PolledWait(2.0)
        SetUnitVertexColor(gg_unit_h009_0029, 256, 256, 256, 256)
    end

    --===========================================================================
    gg_trg_RepositioningDriveGo = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_RepositioningDriveGo, gg_unit_h009_0029, EVENT_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_RepositioningDriveGo, Condition(Trig_RepositioningDriveGo_Conditions))
    TriggerAddAction(gg_trg_RepositioningDriveGo, Trig_RepositioningDriveGo_Actions)
end)
if Debug then Debug.endFile() end
