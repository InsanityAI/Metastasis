if Debug then Debug.beginFile "Game/Abilities/Alien/NeurotoxicPoison" end
OnInit.trig("NeurotoxicPoison", function(require)
    ---@return boolean
    function Trig_NeurotoxicPoison_Conditions()
        if GetUnitAbilityLevel(GetAttacker(), FourCC('A043')) == 0 then
            return false
        end
        if (not (udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetAttackedUnitBJ()))] == GetAttackedUnitBJ())) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_NeurotoxicPoison_Func002C()
        if (not (udg_Player_Poison_Swaying[GetConvertedPlayerId(GetOwningPlayer(GetAttackedUnitBJ()))] == false)) then
            return false
        end
        return true
    end

    function Trig_NeurotoxicPoison_Actions()
        local a = GetAttackedUnitBJ() ---@type unit
        local p = GetOwningPlayer(a) ---@type player
        if IsUnitType(a, UNIT_TYPE_TAUREN) then
            UnitRemoveAbility(a, FourCC('B00P'))
            return
        end
        PolledWait(0.1)
        if (Trig_NeurotoxicPoison_Func002C()) and udg_Player_TetrabinLevel[GetConvertedPlayerId(p)] == 0 then
            udg_Player_Poison_Swaying[GetConvertedPlayerId(p)] = true
            CameraSetSourceNoiseForPlayer(GetOwningPlayer(a), 350.00, 40)
            while not (UnitHasBuffBJ(a, FourCC('B00P')) ~= true or a == nil) do
                PolledWait(1.00)
            end
            if udg_Player_TetrabinLevel[GetConvertedPlayerId(p)] == 0 then
                CameraSetSourceNoiseForPlayer(p, 0, 0)
            end
            udg_Player_Poison_Swaying[GetConvertedPlayerId(p)] = false
        else
        end
    end

    --===========================================================================
    gg_trg_NeurotoxicPoison = CreateTrigger()
    DisableTrigger(gg_trg_NeurotoxicPoison)
    TriggerRegisterAnyUnitEventBJ(gg_trg_NeurotoxicPoison, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_NeurotoxicPoison, Condition(Trig_NeurotoxicPoison_Conditions))
    TriggerAddAction(gg_trg_NeurotoxicPoison, Trig_NeurotoxicPoison_Actions)
end)
if Debug then Debug.endFile() end
