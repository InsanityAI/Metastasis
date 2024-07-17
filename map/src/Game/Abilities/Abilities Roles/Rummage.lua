if Debug then Debug.beginFile "Game/Abilities/Roles/Rummage" end
OnInit.map("Rummage", function(require)
    ---@return boolean
    function Trig_Rummage_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A04B'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Rummage_Func003Func004Func001Func001Func001C()
        if (not (udg_TempInt == 4)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Rummage_Func003Func004Func001Func001C()
        if (not (udg_TempInt == 3)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Rummage_Func003Func004Func001C()
        if (not (udg_TempInt == 2)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Rummage_Func003Func004C()
        if (not (udg_TempInt == 1)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Rummage_Func003Func005C()
        if (not (udg_TempInt <= 4)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Rummage_Func003Func006C()
        if ((GetDestructableTypeId(GetSpellTargetDestructable()) == FourCC('LTcr'))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_Rummage_Func003C()
        if (not Trig_Rummage_Func003Func006C()) then
            return false
        end
        return true
    end

    function Trig_Rummage_Actions()
        if (Trig_Rummage_Func003C()) then
            udg_TempInt = GetRandomInt(1, 28)
            KillDestructable(GetSpellTargetDestructable())
            if (Trig_Rummage_Func003Func004C()) then
                udg_TempItemType = FourCC('I01K')
            else
                if (Trig_Rummage_Func003Func004Func001C()) then
                    udg_TempItemType = FourCC('I027')
                else
                    if (Trig_Rummage_Func003Func004Func001Func001C()) then
                        udg_TempItemType = FourCC('I028')
                    else
                        if (Trig_Rummage_Func003Func004Func001Func001Func001C()) then
                            udg_TempItemType = FourCC('I01J')
                        else
                        end
                    end
                end
            end
            if (Trig_Rummage_Func003Func005C()) then
                udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
                CreateItemLoc(udg_TempItemType, udg_TempPoint)
                RemoveLocation(udg_TempPoint)
            else
            end
        else
            DisplayTimedTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0, 10.00,
                "This ability is meant to be used with crates.")
        end
    end

    --===========================================================================
    gg_trg_Rummage = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Rummage, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Rummage, Condition(Trig_Rummage_Conditions))
    TriggerAddAction(gg_trg_Rummage, Trig_Rummage_Actions)
end)
if Debug then Debug.endFile() end
