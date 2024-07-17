if Debug then Debug.beginFile "Game/Abilities/Items/VoidCannon" end
OnInit.trig("VoidCannon", function(require)
    ---@return boolean
    function Trig_VoidCannon_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A0A6'))) then --TODO
            return false
        end
        return true
    end

    function VoidCannon_Explode()
        local k = GetExpiredTimer() ---@type timer
        local b = LoadLocationHandle(LS(), GetHandleId(k), StringHash("loc")) ---@type location
        local p = LoadPlayerHandle(LS(), GetHandleId(k), StringHash("player")) ---@type player

        --local unit vfx1
        --local unit vfx2

        --vfx1 = CreateUnitAtLoc(Player(PLAYER_NEUTRAL_PASSIVE), FourCC('e03l'), b, GetRandomDirectionDeg())
        --vfx2 = CreateUnitAtLoc(Player(PLAYER_NEUTRAL_PASSIVE), FourCC('e03J'), b, GetRandomDirectionDeg())

        CreateUnitAtLoc(Player(PLAYER_NEUTRAL_PASSIVE), FourCC('e03I'), b, GetRandomDirectionDeg())
        CreateUnitAtLoc(Player(PLAYER_NEUTRAL_PASSIVE), FourCC('e03J'), b, GetRandomDirectionDeg())

        DamageAreaForPlayerTK(p, 150.0, 700.0, GetLocationX(b), GetLocationY(b))
        RemoveLocation(b)
        FlushChildHashtable(LS(), GetHandleId(k))
        DestroyTimer(k)
    end

    function Trig_VoidCannon_Actions()
        local b = GetSpellTargetLoc() ---@type location
        local c = GetUnitLoc(GetSpellAbilityUnit()) ---@type location
        local k = CreateTimer() ---@type timer
        local a = CreateUnitAtLoc(Player(PLAYER_NEUTRAL_PASSIVE), FourCC('e03F'), c, GetRandomDirectionDeg()) ---@type unit

        SaveLocationHandle(LS(), GetHandleId(k), StringHash("loc"), b)
        SavePlayerHandle(LS(), GetHandleId(k), StringHash("player"), GetOwningPlayer(GetSpellAbilityUnit()))
        TimerStart(k, 2.3, false, VoidCannon_Explode)
        AddSpecialEffectLoc("Abilities\\Spells\\Undead\\DeathCoil\\DeathCoilSpecialArt.mdl", c)
        AddSpecialEffectLoc("Abilities\\Spells\\Other\\HowlOfTerror\\HowlCaster.mdl", c)
        SFXThreadClean()
        BasicAI_IssueDangerArea(b, 220.0, 2.4)
        SetUnitFlyHeight(a, 3500, 600.0)
        --call SizeUnitOverTime(a,2.3,6.0,6.0,false)//(unit, duration, start, end, bool)
        FadeUnitOverTime(a, 2.4, true)
        RemoveLocation(c)
    end

    --===========================================================================
    gg_trg_VoidCannon = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_VoidCannon, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_VoidCannon, Condition(Trig_VoidCannon_Conditions))
    TriggerAddAction(gg_trg_VoidCannon, Trig_VoidCannon_Actions)
end)
if Debug then Debug.endFile() end
