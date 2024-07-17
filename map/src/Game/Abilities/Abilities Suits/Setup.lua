if Debug then Debug.beginFile "Game/Abilities/Suits/Setup" end
OnInit.trig("Setup", function(require)
    ---@return boolean
    function Trig_Setup_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A08Q'))) then
            return false
        end
        return true
    end

    EffectGroupCount = 0 ---@type integer


    ---@return integer
    function CreateEffectGroup()
        EffectGroupCount = EffectGroupCount + 1
        SaveInteger(LS(), StringHash("EffectGroup_" .. I2S(EffectGroupCount)), StringHash("effects_count"), 0)
        return EffectGroupCount
    end

    ---@param groupie integer
    ---@param a effect
    function AddEffectToEffectGroup(groupie, a)
        local i = LoadInteger(LS(), StringHash("EffectGroup_" .. I2S(groupie)), StringHash("effects_count")) +
            1 ---@type integer
        SaveEffectHandle(LS(), StringHash("EffectGroup_" .. I2S(groupie)), StringHash("effect_" .. I2S(i)), a)
        SaveInteger(LS(), StringHash("EffectGroup_" .. I2S(groupie)), StringHash("effects_count"), i)
    end

    ---@param groupie integer
    function DestroyEffectsInEffectGroup(groupie)
        local i = LoadInteger(LS(), StringHash("EffectGroup_" .. I2S(groupie)), StringHash("effects_count")) ---@type integer
        local b = 1 ---@type integer
        while b <= i do
            DestroyEffect(LoadEffectHandle(LS(), StringHash("EffectGroup_" .. I2S(groupie)),
                StringHash("effect_" .. I2S(b))))
            b = b + 1
        end
        FlushChildHashtable(LS(), StringHash("EffectGroup_" .. I2S(groupie)))
    end

    ---@param angle1 real
    ---@param angle2 real
    ---@return real
    function DifferenceBetweenAngles(angle1, angle2)
        if angle2 > angle1 then
            if angle2 - angle1 > 180 then
                return (360 - angle2) + angle1
            else
                return angle2 - angle1
            end
        else
            if angle1 - angle2 > 180 then
                return (360 - angle1) + angle2
            else
                return angle1 - angle2
            end
        end
    end

    ---@param a unit
    ---@param b location
    ---@return real
    function DistanceBetweenUnitAndPoint(a, b)
        local c = GetUnitLoc(a) ---@type location
        local d = DistanceBetweenPoints(c, b) ---@type real
        RemoveLocation(c)
        return d
    end

    function Trig_Setup_Actions()
        local a           = GetSpellAbilityUnit() ---@type unit
        local c           = GetSpellTargetLoc() ---@type location
        local d           = GetUnitLoc(GetSpellAbilityUnit()) ---@type location
        local r           = AngleBetweenPoints(d, c) ---@type real
        local effectgroup = CreateEffectGroup() ---@type integer

        AddEffectToEffectGroup(effectgroup,
            AddSpecialEffectTarget("Abilities\\Spells\\Other\\ImmolationRed\\ImmolationRedTarget.mdl", a, "origin"))
        RemoveLocation(c)
        UnitAddAbilityBJ(FourCC('A08S'), GetSpellAbilityUnit())
        udg_TempPoint2 = d


        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 10
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            udg_TempPoint = PolarProjectionBJ(udg_TempPoint2, (60.00 * I2R(GetForLoopIndexA())),
                (GetUnitFacing(GetSpellAbilityUnit()) + 30.00))
            AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Orc\\Bloodlust\\BloodlustTarget.mdl")
            AddEffectToEffectGroup(effectgroup, bj_lastCreatedEffect)
            RemoveLocation(udg_TempPoint)
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end


        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 10
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            udg_TempPoint = PolarProjectionBJ(udg_TempPoint2, (60.00 * I2R(GetForLoopIndexA())),
                (GetUnitFacing(GetSpellAbilityUnit()) - 30.00))
            AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Orc\\Bloodlust\\BloodlustTarget.mdl")
            AddEffectToEffectGroup(effectgroup, bj_lastCreatedEffect)
            RemoveLocation(udg_TempPoint)
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end


        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 5
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            udg_TempPoint = PolarProjectionBJ(udg_TempPoint2, 600.00,
                (GetUnitFacing(GetSpellAbilityUnit()) + (-30.00 + (I2R(GetForLoopIndexA()) * 12.00))))
            AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Orc\\Bloodlust\\BloodlustTarget.mdl")
            AddEffectToEffectGroup(effectgroup, bj_lastCreatedEffect)
            RemoveLocation(udg_TempPoint)
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end

        while not (DifferenceBetweenAngles(GetUnitFacing(a), r) > 30.0 or DistanceBetweenUnitAndPoint(a, d) > 50.0) do
            TriggerSleepAction(0.10)
        end
        udg_TempUnit = a
        UnitRemoveAbilityBJ(FourCC('A08S'), udg_TempUnit)
        DestroyEffectsInEffectGroup(effectgroup)
        RemoveLocation(d)
    end

    --===========================================================================
    gg_trg_Setup = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Setup, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Setup, Condition(Trig_Setup_Conditions))
    TriggerAddAction(gg_trg_Setup, Trig_Setup_Actions)
end)
if Debug then Debug.endFile() end
