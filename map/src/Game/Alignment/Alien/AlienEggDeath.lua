if Debug then Debug.beginFile "Game/Allignment/Alien/AlienEggDeath" end
OnInit.trig("AlienEggDeath", function(require)
    ---@return boolean
    function Trig_AlienEggDeath_Conditions()
        if (not (GetUnitTypeId(GetDyingUnit()) == FourCC('e01H'))) then
            return false
        end
        if (not (IsUnitInGroup(GetTriggerUnit(), udg_Parasite_EggGroup) == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AlienEggDeath_Func006C()
        if (not (IsUnitType(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)], UNIT_TYPE_MECHANICAL) == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AlienEggDeath_Func013C()
        if not (GetLocalPlayer() == udg_Parasite) then
            return false
        end
        return true
    end

    function Trig_AlienEggDeath_Actions()
        GroupRemoveUnitSimple(GetTriggerUnit(), udg_Parasite_EggGroup)
        udg_UpgradePointsAlien = (udg_UpgradePointsAlien - 75.00)
        if (Trig_AlienEggDeath_Func006C()) then
            UnitDamageTargetBJ(GetKillingUnitBJ(), udg_AlienForm_Alien, 100.00, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL)
        else
        end
        udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(udg_Parasite)])
        AddSpecialEffectLocBJ(udg_TempPoint, "Objects\\Spawnmodels\\NightElf\\NightElfBlood\\NightElfBloodHippogryph.mdl")
        CreateNUnitsAtLoc(1, FourCC('e000'), Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING)
        IssueTargetOrderBJ(GetLastCreatedUnit(), "firebolt", udg_Playerhero[GetConvertedPlayerId(udg_Parasite)])
        RemoveLocation(udg_TempPoint)
        CinematicFilterGenericForPlayer(udg_Parasite, 2.0, BLEND_MODE_BLEND,
            "ReplaceableTextures\\CameraMasks\\DiagonalSlash_mask.blp", 0, 100, 100, 25, 0, 0, 0, 100)
        if (Trig_AlienEggDeath_Func013C()) then
            StartSound(gg_snd_EggSackDeath1)
        else
        end
    end

    --===========================================================================
    gg_trg_AlienEggDeath = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_AlienEggDeath, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_AlienEggDeath, Condition(Trig_AlienEggDeath_Conditions))
    TriggerAddAction(gg_trg_AlienEggDeath, Trig_AlienEggDeath_Actions)
end)
if Debug then Debug.endFile() end
