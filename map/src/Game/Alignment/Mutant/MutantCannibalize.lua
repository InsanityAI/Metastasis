if Debug then Debug.beginFile "Game/Allignment/Mutant/MutnatCannibalize" end
OnInit.trig("MutnatCannibalize", function(require)
    ---@return boolean
    function Trig_MutantCannibalize_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A076'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantCannibalize_Func004Func001Func002C()
        if (not (DistanceBetweenPoints(udg_TempPoint, udg_TempPoint2) <= 140.00)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_MutantCannibalize_Func004Func001C()
        if (not (GetUnitAbilityLevelSwapped(FourCC('A077'), GetEnumUnit()) == 1)) then
            return false
        end
        if (not (GetUnitAbilityLevelSwapped(FourCC('A07P'), GetEnumUnit()) == 0)) then
            return false
        end
        return true
    end

    function Trig_MutantCannibalize_Func004A()
        if (Trig_MutantCannibalize_Func004Func001C()) then
            udg_TempPoint2 = GetUnitLoc(GetEnumUnit())
            if (Trig_MutantCannibalize_Func004Func001Func002C()) then
                SetSoundPositionLocBJ(gg_snd_Devour, udg_TempPoint, 0)
                PlaySoundBJ(gg_snd_Devour)
                RemoveUnit(GetEnumUnit())
                udg_UpgradePointsMutant = (udg_UpgradePointsMutant + 220.00)
                AddSpecialEffectLocBJ(udg_TempPoint2, "Objects\\Spawnmodels\\Orc\\Orcblood\\BattrollBlood.mdl")
                SFXThreadClean()
                AddSpecialEffectLocBJ(udg_TempPoint2, "Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl")
                SFXThreadClean()
            else
            end
            RemoveLocation(udg_TempPoint2)
        else
        end
    end

    function Trig_MutantCannibalize_Actions()
        udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
        ForGroupBJ(GetUnitsOfPlayerAll(Player(PLAYER_NEUTRAL_PASSIVE)), Trig_MutantCannibalize_Func004A)
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_MutantCannibalize = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_MutantCannibalize, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_MutantCannibalize, Condition(Trig_MutantCannibalize_Conditions))
    TriggerAddAction(gg_trg_MutantCannibalize, Trig_MutantCannibalize_Actions)
end)
if Debug then Debug.endFile() end
