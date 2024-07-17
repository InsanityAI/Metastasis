if Debug then Debug.beginFile "Game/Abilities/Mutant/TotalInfection" end
OnInit.trig("TotalInfection", function(require)
    ---@return boolean
    function Trig_TotalInfection_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A01V'))) then
            return false
        end
        return true
    end

    function Trig_TotalInfection_Actions()
        local a ---@type integer
        local b ---@type integer
        a = 1
        b = 12
        while a <= b do
            if (udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(udg_Playerhero[a]))] == false) then
                if (GetOwningPlayer(udg_Playerhero[a]) ~= udg_Mutant) then
                    udg_TempPoint = GetUnitLoc(udg_Playerhero[a])
                    CreateNUnitsAtLoc(1, FourCC('e000'), udg_Mutant, udg_TempPoint, bj_UNIT_FACING)
                    RemoveLocation(udg_TempPoint)
                    IssueTargetOrderBJ(GetLastCreatedUnit(), "parasite", udg_Playerhero[a])
                end
            end
            a = a + 1
        end
    end

    --===========================================================================
    gg_trg_TotalInfection = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_TotalInfection, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_TotalInfection, Condition(Trig_TotalInfection_Conditions))
    TriggerAddAction(gg_trg_TotalInfection, Trig_TotalInfection_Actions)
end)
if Debug then Debug.endFile() end
