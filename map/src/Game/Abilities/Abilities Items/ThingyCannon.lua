if Debug then Debug.beginFile "Game/Abilities/Items/ThingyCannon" end
OnInit.trig("ThingyCannon", function(require)
    ---@return boolean
    function Trig_ThingyCannon_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A07R'))) then
            return false
        end
        return true
    end

    function ThingyCannon_Asplode()
        local k = GetExpiredTimer() ---@type timer
        local b = LoadLocationHandle(LS(), GetHandleId(k), StringHash("loc")) ---@type location
        local p = LoadPlayerHandle(LS(), GetHandleId(k), StringHash("player")) ---@type player

        DamageAreaForPlayerTK(p, 150.0, 220.0, GetLocationX(b), GetLocationY(b))
        AddSpecialEffectLoc("war3mapImported\\UDeath.MDX", b)
        SFXThreadClean()
        RemoveLocation(b)
        FlushChildHashtable(LS(), GetHandleId(k))
        DestroyTimer(k)
    end

    function Trig_ThingyCannon_Actions()
        local b = GetSpellTargetLoc() ---@type location
        local c = GetUnitLoc(GetSpellAbilityUnit()) ---@type location
        local k = CreateTimer() ---@type timer
        local a = CreateUnitAtLoc(Player(PLAYER_NEUTRAL_PASSIVE), FourCC('e02L'), c, GetRandomDirectionDeg()) ---@type unit

        SaveLocationHandle(LS(), GetHandleId(k), StringHash("loc"), b)
        SavePlayerHandle(LS(), GetHandleId(k), StringHash("player"), GetOwningPlayer(GetSpellAbilityUnit()))
        TimerStart(k, 2.3, false, ThingyCannon_Asplode)
        AddSpecialEffectLoc("Abilities\\Spells\\Undead\\DeathCoil\\DeathCoilSpecialArt.mdl", c)
        SFXThreadClean()
        BasicAI_IssueDangerArea(b, 220.0, 2.4)
        SetUnitFlyHeight(a, 3500, 600.0)
        SizeUnitOverTime(a, 2.3, 0.1, 2.5, false) --(unit, duration, start, end, bool)
        FadeUnitOverTime(a, 2.4, true)
        RemoveLocation(c)
    end

    --===========================================================================
    gg_trg_ThingyCannon = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ThingyCannon, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_ThingyCannon, Condition(Trig_ThingyCannon_Conditions))
    TriggerAddAction(gg_trg_ThingyCannon, Trig_ThingyCannon_Actions)
end)
if Debug then Debug.endFile() end
