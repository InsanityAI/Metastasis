if Debug then Debug.beginFile "Game/Abilities/Items/EMGrenadeForceKill" end
OnInit.map("EMGrenadeForceKill", function(require)
    ---@return boolean
    function Trig_EMGrenadeForceKill_Conditions()
        if (not (GetUnitTypeId(GetEnteringUnit()) == FourCC('e00W'))) then
            return false
        end
        return true
    end

    function Trig_EMGrenadeForceKill_Actions()
        UnitApplyTimedLifeBJ(1.23, FourCC('BTLF'), GetEnteringUnit())
    end

    --===========================================================================
    gg_trg_EMGrenadeForceKill = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_EMGrenadeForceKill, GetPlayableMapRect())
    TriggerAddCondition(gg_trg_EMGrenadeForceKill, Condition(Trig_EMGrenadeForceKill_Conditions))
    TriggerAddAction(gg_trg_EMGrenadeForceKill, Trig_EMGrenadeForceKill_Actions)
end)
if Debug then Debug.endFile() end
