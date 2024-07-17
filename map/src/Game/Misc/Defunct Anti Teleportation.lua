if Debug then Debug.beginFile "Game/Misc/DefunctAntiTeleport" end
OnInit.map("DefunctAntiTeleport", function(require)
    ---@return boolean
    function Trig_Defunct_Anti_Teleportation_Conditions()
        if (not (udg_Defunct_Dead == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Defunct_Anti_Teleportation_Func007Func002C()
        if (not (udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] == GetTriggerUnit())) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Defunct_Anti_Teleportation_Func007C()
        if (not (udg_TempInt == 1)) then
            return false
        end
        return true
    end

    function Trig_Defunct_Anti_Teleportation_Actions()
        udg_TempInt = GetRandomInt(1, 2)
        SetUnitPositionLoc(GetTriggerUnit(), GetRectCenter(gg_rct_BombTeleport))
        AddSpecialEffectLocBJ(GetRectCenter(gg_rct_BombTeleport), "Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl")
        DestroyEffectBJ(GetLastCreatedEffectBJ())
        if (Trig_Defunct_Anti_Teleportation_Func007C()) then
            PanCameraToTimedLocForPlayer(GetOwningPlayer(GetTriggerUnit()), GetRectCenter(gg_rct_BombTeleport), 0)
            if (Trig_Defunct_Anti_Teleportation_Func007Func002C()) then
                SetUnitLifeBJ(GetTriggerUnit(),
                    (GetUnitStateSwap(UNIT_STATE_LIFE, GetTriggerUnit()) - GetRandomReal(150.00, 250.00)))
            else
            end
        else
        end
    end

    --===========================================================================
    gg_trg_Defunct_Anti_Teleportation = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Defunct_Anti_Teleportation, gg_rct_ST2)
    TriggerAddCondition(gg_trg_Defunct_Anti_Teleportation, Condition(Trig_Defunct_Anti_Teleportation_Conditions))
    TriggerAddAction(gg_trg_Defunct_Anti_Teleportation, Trig_Defunct_Anti_Teleportation_Actions)
end)
if Debug then Debug.endFile() end
