if Debug then Debug.beginFile "Commands/Test/SpawnUnit" end
OnInit.trig("SpawnUnit", function(require)
    ---@return boolean
    function Trig_SpawnUnit_Conditions()
        if (not (udg_TESTING == true)) then
            return false
        end
        if (not (SubStringBJ(GetEventPlayerChatString(), 1, 7) == "-spawn ")) then
            return false
        end
        return true
    end

    function Trig_SpawnUnit_Actions()
        udg_TempInt = S2I(SubStringBJ(GetEventPlayerChatString(), 8, 99))
        udg_TempUnitType = udg_TempInt
        bj_lastCreatedUnit = nil
        CreateNUnitsAtLoc(1, String2UnitIdBJ(SubStringBJ(GetEventPlayerChatString(), 8, 999)), GetTriggerPlayer(),
            GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())]), bj_UNIT_FACING)
        if bj_lastCreatedUnit == nil then
            DisplayTextToForce(GetPlayersAll(), "Spawn command NOT successful.")
        else
            DisplayTextToForce(GetPlayersAll(), "Spawn command successful.")
        end
    end

    --===========================================================================
    local i          = 0 ---@type integer
    gg_trg_SpawnUnit = CreateTrigger()
    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_SpawnUnit, Player(i), "-spawn ", false)
        i = i + 1
    end
    TriggerAddCondition(gg_trg_SpawnUnit, Condition(Trig_SpawnUnit_Conditions))
    TriggerAddAction(gg_trg_SpawnUnit, Trig_SpawnUnit_Actions)
end)
if Debug then Debug.endFile() end
