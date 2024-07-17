if Debug then Debug.beginFile "Game/Stations/ST4/LaboratorySpawnExperiments" end
OnInit.map("LaboratorySpawnExperiments", function(require)
    ---@return boolean
    function Trig_LaboratorySpawnExperiments_Func003C()
        if (not (GetRandomInt(0, 1) == 0)) then
            return false
        end
        return true
    end

    function Trig_LaboratorySpawnExperiments_Actions()
        udg_TempPoint = GetRectCenter(gg_rct_ST4EscapePod)
        if (Trig_LaboratorySpawnExperiments_Func003C()) then
            CreateNUnitsAtLoc(1, FourCC('n000'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg())
        else
            CreateNUnitsAtLoc(1, FourCC('n001'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg())
        end
        CreateNUnitsAtLoc(1, FourCC('e006'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg())
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_LaboratorySpawnExperiments = CreateTrigger()
    DisableTrigger(gg_trg_LaboratorySpawnExperiments)
    TriggerRegisterTimerEventPeriodic(gg_trg_LaboratorySpawnExperiments, 22.00)
    TriggerAddAction(gg_trg_LaboratorySpawnExperiments, Trig_LaboratorySpawnExperiments_Actions)
end)
if Debug then Debug.endFile() end
