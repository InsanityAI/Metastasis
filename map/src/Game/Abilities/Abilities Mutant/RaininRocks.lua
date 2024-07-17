if Debug then Debug.beginFile "Game/Abilities/Mutant/RaininRocks" end
OnInit.trig("RaininRocks", function(require)
    ---@return boolean
    function Trig_RaininRocks_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A05F'))) then
            return false
        end
        return true
    end

    function RaininRocks_Debris()
        local t = GetExpiredTimer() ---@type timer
        local x = LoadReal(LS(), GetHandleId(t), StringHash("x")) ---@type real
        local y = LoadReal(LS(), GetHandleId(t), StringHash("y")) ---@type real
        local i = 0 ---@type integer
        DestroyTimer(t)
        while i <= 2 do
            CreateDestructable(FourCC('B007'), x + GetRandomReal(-100, 100), y + GetRandomReal(-100, 100),
                GetRandomDirectionDeg(), 1, GetRandomInt(1, 6))
            i = i + 1
        end
    end

    function Trig_RaininRocks_Actions()
        local t        = CreateTimer() ---@type timer
        udg_TempPoint  = GetUnitLoc(GetSpellAbilityUnit())
        udg_TempPoint2 = GetSpellTargetLoc()
        AddSpecialEffectLocBJ(udg_TempPoint, "Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
        SaveReal(LS(), GetHandleId(t), StringHash("x"), GetLocationX(udg_TempPoint2))
        SaveReal(LS(), GetHandleId(t), StringHash("y"), GetLocationY(udg_TempPoint2))
        TimerStart(t, 0.5, false, RaininRocks_Debris)
        SFXThreadClean()
        RemoveLocation(udg_TempPoint)
        RemoveLocation(udg_TempPoint2)
    end

    --===========================================================================
    gg_trg_RaininRocks = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_RaininRocks, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_RaininRocks, Condition(Trig_RaininRocks_Conditions))
    TriggerAddAction(gg_trg_RaininRocks, Trig_RaininRocks_Actions)
end)
if Debug then Debug.endFile() end
