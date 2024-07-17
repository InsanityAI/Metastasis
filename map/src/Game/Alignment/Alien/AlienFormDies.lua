if Debug then Debug.beginFile "Game/Allignment/Alien/AlienFormDies" end
OnInit.triggggggggg("AlienFormDies", function(require)
    ---@return boolean
    function Trig_AlienFormDies_Conditions()
        if (not (GetDyingUnit() == udg_AlienForm_Alien)) then
            return false
        end
        return true
    end

    function Trig_AlienFormDies_Actions()
        CreateNUnitsAtLoc(1, FourCC('e000'), udg_Parasite, udg_HoldZone, bj_UNIT_FACING)
        udg_Playerhero[GetConvertedPlayerId(udg_Parasite)] = GetLastCreatedUnit()
        udg_SpawnTemp = false
        KillUnit(GetLastCreatedUnit())
        UnitAddAbilityBJ(FourCC('A02T'), GetLastCreatedUnit())
        UnitRemoveBuffsBJ(bj_REMOVEBUFFS_ALL, GetLastCreatedUnit())
        DisableTrigger(gg_trg_AlienAdjustShop)
    end

    --===========================================================================
    gg_trg_AlienFormDies = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_AlienFormDies, Player(bj_PLAYER_NEUTRAL_EXTRA), EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_AlienFormDies, Condition(Trig_AlienFormDies_Conditions))
    TriggerAddAction(gg_trg_AlienFormDies, Trig_AlienFormDies_Actions)
end)
if Debug then Debug.endFile() end
