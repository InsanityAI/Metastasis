if Debug then Debug.beginFile "Game/Abilities/Alien/LightningStrike" end
OnInit.map("LightningStrike", function(require)
    ---@return boolean
    function Trig_Lightning_Strike_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A03R'))) then
            return false
        end
        return true
    end

    function LightningStrikeDamage()
        if GetOwningPlayer(GetEnumUnit()) ~= Player(14) and GetOwningPlayer(GetEnumUnit()) ~= udg_Parasite and udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] == false then
            UnitDamageTarget(udg_TempUnit4, GetEnumUnit(), 500.0, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL,
                WEAPON_TYPE_WHOKNOWS)
        end
    end

    function Trig_Lightning_Strike_Actions()
        --45 Degree Lightings
        local a ---@type lightning
        local b ---@type lightning
        local c ---@type lightning
        local d ---@type lightning

        --90 degree lightings
        local aa ---@type lightning
        local bb ---@type lightning
        local cc ---@type lightning
        local dd ---@type lightning

        local e = GetSpellTargetLoc() ---@type location
        local f ---@type location
        local j ---@type location
        local g = GetSpellAbilityUnit() ---@type unit


        --45 Degree Lightings
        f = PolarProjectionBJ(e, 340, 45.00)
        AddLightningLoc("CLPB", f, e)
        a = GetLastCreatedLightningBJ()
        RemoveLocation(f)
        f = PolarProjectionBJ(e, 340, 135.00)
        AddLightningLoc("CLPB", f, e)
        b = GetLastCreatedLightningBJ()
        RemoveLocation(f)
        f = PolarProjectionBJ(e, 340, 225.00)
        AddLightningLoc("CLPB", f, e)
        c = GetLastCreatedLightningBJ()
        RemoveLocation(f)
        f = PolarProjectionBJ(e, 340, 315.00)
        AddLightningLoc("CLPB", f, e)
        d = GetLastCreatedLightningBJ()

        --90 Degree Lightings
        f = PolarProjectionBJ(e, 340, 0.00)
        AddLightningLoc("CLPB", f, e)
        aa = GetLastCreatedLightningBJ()
        RemoveLocation(f)
        f = PolarProjectionBJ(e, 340, 90.00)
        AddLightningLoc("CLPB", f, e)
        bb = GetLastCreatedLightningBJ()
        RemoveLocation(f)
        f = PolarProjectionBJ(e, 340, 180.00)
        AddLightningLoc("CLPB", f, e)
        cc = GetLastCreatedLightningBJ()
        RemoveLocation(f)
        f = PolarProjectionBJ(e, 340, 270.00)
        AddLightningLoc("CLPB", f, e)
        dd = GetLastCreatedLightningBJ()


        RemoveLocation(f)
        udg_TempUnitType = FourCC('e00P')
        udg_TempPlayer = GetOwningPlayer(GetSpellAbilityUnit())
        udg_TempReal = 20.00
        ExecuteFunc("AlienRequirementRemove")
        ExecuteFunc("AlienRequirementRestore")
        PolledWait(2.5)
        udg_TempUnit4 = g
        udg_TempUnitGroup = GetUnitsInRangeOfLocAll(340.0, e)
        ForGroup(udg_TempUnitGroup, LightningStrikeDamage)
        DestroyGroup(udg_TempUnitGroup)

        DestroyLightning(a)
        DestroyLightning(b)
        DestroyLightning(c)
        DestroyLightning(d)

        DestroyLightning(aa)
        DestroyLightning(bb)
        DestroyLightning(cc)
        DestroyLightning(dd)

        g = nil

        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 35
        SetSoundPositionLocBJ(gg_snd_MonsoonLightningHit, e, 0)
        PlaySoundBJ(gg_snd_MonsoonLightningHit)
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            j = PolarProjectionBJ(e, GetRandomReal(0, 300.00), GetRandomDirectionDeg())
            AddSpecialEffectLocBJ(j, "Doodads\\Cinematic\\Lightningbolt\\Lightningbolt.mdl")
            RemoveLocation(j)
            SFXThreadClean()
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        RemoveLocation(e)
        e = nil
    end

    --===========================================================================
    gg_trg_Lightning_Strike = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Lightning_Strike, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Lightning_Strike, Condition(Trig_Lightning_Strike_Conditions))
    TriggerAddAction(gg_trg_Lightning_Strike, Trig_Lightning_Strike_Actions)
end)
if Debug then Debug.endFile() end
