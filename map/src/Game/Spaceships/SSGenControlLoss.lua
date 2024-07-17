if Debug then Debug.beginFile "Game/Spaceships/SSGenControlLoss" end
OnInit.trig("SSGenControlLoss", function(require)
    ---@return boolean
    function Trig_SSGenControlLoss_Conditions()
        if (not (GetOwningPlayer(GetTriggerUnit()) == GetOwningPlayer(udg_Spaceship_Console[GetUnitUserData(udg_TempUnit)]))) then
            return false
        end
        if (not (GetUnitPointValue(GetTriggerUnit()) ~= 37)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SSGenControlLoss_Func006C()
        if (not (GetUnitAbilityLevelSwapped(FourCC('A0A5'), udg_SS_Space[GetUnitUserData(udg_TempUnit)]) == 1)) then
            return false
        end
        return true
    end

    function Trig_SSGenControlLoss_Actions()
        SetUnitOwner(udg_Spaceship_Console[GetUnitUserData(udg_TempUnit)], Player(PLAYER_NEUTRAL_PASSIVE), false)
        SetUnitOwner(udg_SS_Space[GetUnitUserData(udg_TempUnit)], Player(PLAYER_NEUTRAL_PASSIVE), false)
        -- If Ace -> Remove atk speed buff
        if (Trig_SSGenControlLoss_Func006C()) then
            UnitRemoveAbilityBJ(FourCC('A0A5'), udg_SS_Space[GetUnitUserData(udg_TempUnit)])
        else
        end
    end

    --===========================================================================
    gg_trg_SSGenControlLoss = CreateTrigger()
    TriggerAddCondition(gg_trg_SSGenControlLoss, Condition(Trig_SSGenControlLoss_Conditions))
    TriggerAddAction(gg_trg_SSGenControlLoss, Trig_SSGenControlLoss_Actions)
end)
if Debug then Debug.endFile() end
