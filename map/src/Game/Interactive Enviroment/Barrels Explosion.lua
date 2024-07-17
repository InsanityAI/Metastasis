if Debug then Debug.beginFile "Game/InteractiveEnvironment/BarrelsExplosion" end
OnInit.map("BarrelsExplosion", function(require)
    ---@return boolean
    function Trig_Barrels_Explosion_Conditions()
        if (not (GetUnitTypeId(GetTriggerUnit()) == FourCC('n00J'))) then
            return false
        end
        return true
    end

    function Trig_Barrels_Explosion_Func005A()
        UnitDamageTargetBJ(GetTriggerUnit(), GetEnumUnit(), 150.00, ATTACK_TYPE_MELEE, DAMAGE_TYPE_NORMAL)
    end

    function Trig_Barrels_Explosion_Func008A()
        UnitDamageTargetBJ(GetTriggerUnit(), GetEnumUnit(), 150.00, ATTACK_TYPE_MELEE, DAMAGE_TYPE_NORMAL)
    end

    function Trig_Barrels_Explosion_Actions()
        udg_TempLoc = GetUnitLoc(GetTriggerUnit())
        udg_TempUnitGroup = GetUnitsInRangeOfLocAll(300.00, udg_TempLoc)
        ForGroupBJ(udg_TempUnitGroup, Trig_Barrels_Explosion_Func005A)
        DestroyGroup(udg_TempUnitGroup)
        udg_TempUnitGroup = GetUnitsInRangeOfLocAll(150.00, udg_TempLoc)
        ForGroupBJ(udg_TempUnitGroup, Trig_Barrels_Explosion_Func008A)
        AddSpecialEffectLocBJ(udg_TempLoc,
            "Objects\\Spawnmodels\\Other\\NeutralBuildingExplosion\\NeutralBuildingExplosion.mdl")
        DestroyEffectBJ(GetLastCreatedEffectBJ())
        AddSpecialEffectLocBJ(udg_TempLoc, "Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl")
        DestroyEffectBJ(GetLastCreatedEffectBJ())
        DestroyGroup(udg_TempUnitGroup)
        RemoveUnit(GetTriggerUnit())
        RemoveLocation(udg_TempLoc)
    end

    --===========================================================================
    gg_trg_Barrels_Explosion = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Barrels_Explosion, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Barrels_Explosion, Condition(Trig_Barrels_Explosion_Conditions))
    TriggerAddAction(gg_trg_Barrels_Explosion, Trig_Barrels_Explosion_Actions)
end)
if Debug then Debug.endFile() end
