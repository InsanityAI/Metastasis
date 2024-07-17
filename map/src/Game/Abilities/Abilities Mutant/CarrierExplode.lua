if Debug then Debug.beginFile "Game/Abilities/Mutant/CarrierExplode" end
OnInit.trig("CarrierExplode", function(require)
    ---@return boolean
    function Trig_CarrierExplode_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A020'))) then
            return false
        end
        return true
    end

    function Trig_CarrierExplode_Actions()
        udg_TempUnit = GetSpellAbilityUnit()
        udg_CountUpBarColor = "|cffFF0000"
        CountUpBar(udg_TempUnit, 60, 0.05, "CarrierSackExplosion")
    end

    --===========================================================================
    gg_trg_CarrierExplode = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_CarrierExplode, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_CarrierExplode, Condition(Trig_CarrierExplode_Conditions))
    TriggerAddAction(gg_trg_CarrierExplode, Trig_CarrierExplode_Actions)
end)
if Debug then Debug.endFile() end
