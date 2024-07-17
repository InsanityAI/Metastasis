if Debug then Debug.beginFile "Game/Abilities/Alien/BackFromHellEldritchDeath" end
OnInit.trig("BackFromHellEldritchDeath", function(require)
    ---@return boolean
    function Trig_BackFromHellEldritchDeath_Conditions()
        if (not (GetUnitTypeId(GetTriggerUnit()) == FourCC('h02Z'))) then
            return false
        end
        return true
    end

    function Trig_BackFromHellEldritchDeath_Actions()
        udg_EldritchBeastExists = false
    end

    --===========================================================================
    gg_trg_BackFromHellEldritchDeath = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_BackFromHellEldritchDeath, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_BackFromHellEldritchDeath, Condition(Trig_BackFromHellEldritchDeath_Conditions))
    TriggerAddAction(gg_trg_BackFromHellEldritchDeath, Trig_BackFromHellEldritchDeath_Actions)
end)
if Debug then Debug.endFile() end
