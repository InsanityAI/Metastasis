if Debug then Debug.beginFile "Game/Abilities/Alien/Petrify" end
OnInit.trig("Petrify", function(require)
    ---@return boolean
    function Trig_Petrify_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A045'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Petrify_Func006C()
        if (not (udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] == GetSpellTargetUnit())) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Petrify_Func013C()
        if (not (udg_Player_PetrifiedHero[GetConvertedPlayerId(GetOwningPlayer(udg_TempUnit))] == udg_TempUnit)) then
            return false
        end
        return true
    end

    ---@param a unit
    function Depetrify(a)
        SetUnitTimeScalePercent(a, 100.00)
        PauseUnitBJ(false, a)
        SetUnitVertexColorBJ(a, 100.00, 100.00, 100.00, 0)
        UnitRemoveAbilityBJ(FourCC('Avul'), a)
        SetUnitColor(a, GetPlayerColor(GetOwningPlayer(a)))
        udg_TempUnit = a
        if (Trig_Petrify_Func013C()) then
            udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(a))] = a
        else
        end
    end

    function DepetrifyInRange()
        --local unit a=GetHandleUnit(GetTriggeringTrigger(), "unit")
        local a = LoadUnitHandle(LS(), GetHandleId(GetTriggeringTrigger()), StringHash("unit")) ---@type unit
        local d = GetOwningPlayer(GetTriggerUnit()) ---@type player
        local f = GetTriggerUnit() ---@type unit
        if GetUnitPointValue(f) ~= 37 and IsPlayerHuman(d) and f == GetPlayerheroU(f) then
            Depetrify(a)
            CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), FourCC('e00U'), GetUnitX(a), GetUnitY(a), GetRandomDirectionDeg())
            DestroyTrigger(LoadTriggerHandle(LS(), GetHandleId(GetTriggeringTrigger()), StringHash("d")))
            DestroyTrigger(GetTriggeringTrigger())
        end
    end

    function Petrify_Neutralize()
        if GetSpellTargetUnit() ~= GetEnumUnit() then
            SetUnitOwner(GetEnumUnit(), Player(PLAYER_NEUTRAL_PASSIVE), false)
        end
    end

    function Petrified_Death()
        udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))] = CreateUnit(
            GetOwningPlayer(GetDyingUnit()), FourCC('e000'), 0, 0, 0)
        KillUnit(udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetDyingUnit()))])
        DestroyTrigger(GetTriggeringTrigger())
    end

    function Trig_Petrify_Actions()
        local k = CreateTrigger() ---@type trigger
        local d ---@type group
        local q = CreateTrigger() ---@type trigger
        TriggerRegisterUnitEvent(q, GetSpellTargetUnit(), EVENT_UNIT_DEATH)
        SaveTriggerHandle(LS(), GetHandleId(k), StringHash("d"), q)
        TriggerAddAction(q, Petrified_Death)
        SaveUnitHandle(LS(), GetHandleId(k), StringHash("unit"), GetSpellTargetUnit())
        DisplayTextToPlayer(GetOwningPlayer(GetSpellTargetUnit()), 0, 0,
            "|cff408080You have been petrified! You will not be able to move and cannot attack or be damaged (except by station/ship destruction). If a friendly human walks close enough to you, you will depetrify.|r")
        TriggerRegisterUnitInRangeSimple(k, 100.0, GetSpellTargetUnit())
        TriggerAddAction(k, DepetrifyInRange)
        SetUnitTimeScalePercent(GetSpellTargetUnit(), 0.00)
        PauseUnitBJ(true, GetSpellTargetUnit())
        SetUnitVertexColorBJ(GetSpellTargetUnit(), 20.00, 20.00, 20.00, 0)
        UnitAddAbilityBJ(FourCC('Avul'), GetSpellTargetUnit())
        SetUnitColor(GetSpellTargetUnit(), ConvertPlayerColor(12))
        if (Trig_Petrify_Func006C()) then
            udg_Player_PetrifiedHero[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] = GetSpellTargetUnit()
            udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetSpellTargetUnit()))] = nil
            d = GetUnitsOfPlayerAll(GetOwningPlayer(GetSpellTargetUnit()))
            ForGroup(d, Petrify_Neutralize)
            DestroyGroup(d)
            TriggerExecute(gg_trg_WinCheck)
        else
        end
        udg_TempUnitType = FourCC('e00V')
        udg_TempPlayer = GetOwningPlayer(GetSpellAbilityUnit())
        udg_TempReal = 20.00
        ExecuteFunc("AlienRequirementRemove")
        ExecuteFunc("AlienRequirementRestore")
    end

    --===========================================================================
    gg_trg_Petrify = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Petrify, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Petrify, Condition(Trig_Petrify_Conditions))
    TriggerAddAction(gg_trg_Petrify, Trig_Petrify_Actions)
end)
if Debug then Debug.endFile() end
