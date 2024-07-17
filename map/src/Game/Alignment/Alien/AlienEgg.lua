if Debug then Debug.beginFile "Game/Allignment/Alien/AlienEgg" end
OnInit.map("AlienEgg", function(require)
    ---@return boolean
    function Trig_AlienEgg_Conditions()
        if (not (GetUnitTypeId(GetTriggerUnit()) == FourCC('e01H'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_AlienEgg_Func003C()
        if (not (CountUnitsInGroup(udg_Parasite_EggGroup) >= 3)) then
            return false
        end
        return true
    end

    function Trig_AlienEgg_Actions()
        if (Trig_AlienEgg_Func003C()) then
            KillUnit(GetTriggerUnit())
        else
            udg_TempPoint = GetUnitLoc(GetTriggerUnit())
            AddSpecialEffectLocBJ(udg_TempPoint, "Objects\\Spawnmodels\\NightElf\\EntBirthTarget\\EntBirthTarget.mdl")
            SFXThreadClean()
            GroupAddUnitSimple(GetTriggerUnit(), udg_Parasite_EggGroup)
            RemoveLocation(udg_TempPoint)
        end
    end

    --===========================================================================
    gg_trg_AlienEgg = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_AlienEgg, GetPlayableMapRect())
    TriggerAddCondition(gg_trg_AlienEgg, Condition(Trig_AlienEgg_Conditions))
    TriggerAddAction(gg_trg_AlienEgg, Trig_AlienEgg_Actions)
end)
if Debug then Debug.endFile() end
