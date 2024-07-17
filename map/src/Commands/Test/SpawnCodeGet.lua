if Debug then Debug.beginFile "Commands/Test/SpawnCodeGet" end
OnInit.trig("SpawnCodeGet", function(require)
    ---@return boolean
    function Trig_SpawnCodeGet_Conditions()
        if (not (udg_TESTING == true)) then
            return false
        end
        return true
    end

    function DisplaySpawnCode()
        DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "Spawn code " .. UnitId2String(GetUnitTypeId(GetEnumUnit())))
    end

    function Trig_SpawnCodeGet_Actions()
        local g = GetUnitsSelectedAll(GetTriggerPlayer()) ---@type group
        ForGroup(g, DisplaySpawnCode)
        DestroyGroup(g)
    end

    --===========================================================================
    local i             = 0 ---@type integer
    gg_trg_SpawnCodeGet = CreateTrigger()
    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_SpawnCodeGet, Player(i), "-spawncode", true)
        i = i + 1
    end
    TriggerAddCondition(gg_trg_SpawnCodeGet, Condition(Trig_SpawnCodeGet_Conditions))
    TriggerAddAction(gg_trg_SpawnCodeGet, Trig_SpawnCodeGet_Actions)
end)
if Debug then Debug.endFile() end
