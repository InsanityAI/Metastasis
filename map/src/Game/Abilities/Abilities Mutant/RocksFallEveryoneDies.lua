if Debug then Debug.beginFile "Game/Abilities/Mutant/RockFallEveryoneDies" end
OnInit.map("RockFallEveryoneDies", function(require)
    ---@return boolean
    function Trig_RocksFallEveryoneDies_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A01Q'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_RocksFallEveryoneDies_Func005C()
        if (not (udg_TempReal >= -600.00)) then
            return false
        end
        return true
    end

    function Trig_RocksFallEveryoneDies_Actions()
        udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
        udg_TempReal = GetLocationZ(udg_TempPoint)
        if (Trig_RocksFallEveryoneDies_Func005C()) then
            TerrainDeformationCraterBJ(0.5, true, udg_TempPoint, 512, 150.00)
        else
        end
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 36
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            udg_TempPoint2 = PolarProjectionBJ(udg_TempPoint, 512.00, (I2R(GetForLoopIndexA()) * 10.00))
            CreateDestructableLoc(FourCC('B007'), udg_TempPoint2, GetRandomDirectionDeg(), 1.00, 0)
            AddSpecialEffectLocBJ(udg_TempPoint2, "Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
            SFXThreadClean()
            RemoveLocation(udg_TempPoint2)
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_RocksFallEveryoneDies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_RocksFallEveryoneDies, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_RocksFallEveryoneDies, Condition(Trig_RocksFallEveryoneDies_Conditions))
    TriggerAddAction(gg_trg_RocksFallEveryoneDies, Trig_RocksFallEveryoneDies_Actions)
end)
if Debug then Debug.endFile() end
