if Debug then Debug.beginFile "Game/Stations/ST4/ST4DefenseDrone2" end
OnInit.map("ST4DefenseDrone2", function(require)
    ---@return boolean
    function Trig_ST4DefenseDrone2_Conditions()
        if (not (IsUnitIllusionBJ(GetTriggerUnit()) == false)) then
            return false
        end
        if (not (GetUnitPointValue(GetTriggerUnit()) ~= 37)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ST4DefenseDrone2_Func004C()
        if (not (IsUnitAliveBJ(gg_unit_h00B_0031) == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ST4DefenseDrone2_Func005C()
        if (not (SubStringBJ(I2S(GetUnitPointValue(GetTriggerUnit())), 1, 1) == "1")) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ST4DefenseDrone2_Func006C()
        if (not (GetOwningPlayer(gg_unit_h00B_0031) == Player(PLAYER_NEUTRAL_PASSIVE))) then
            return false
        end
        return true
    end

    function Trig_ST4DefenseDrone2_Actions()
        if (Trig_ST4DefenseDrone2_Func004C()) then
        else
            DestroyTrigger(GetTriggeringTrigger())
            DestroyTrigger(gg_trg_ST4DefenseDrone2Loss)
        end
        if (Trig_ST4DefenseDrone2_Func005C()) then
            DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0,
                "|cffffcc00This unit cannot pilot space stations/ships.|r")
            return
        else
        end
        if (Trig_ST4DefenseDrone2_Func006C()) then
            SetUnitOwner(gg_unit_h00B_0031, GetOwningPlayer(GetTriggerUnit()), false)
            SelectUnitForPlayerSingle(gg_unit_h00B_0031, GetOwningPlayer(GetTriggerUnit()))
            KillDestructable(gg_dest_XTmp_1429)
            udg_TempUnit = gg_unit_h00B_0031
            udg_TempRect = gg_rct_DD2
            CheckConsoleControl(udg_TempUnit, udg_TempUnit, udg_TempRect)
        else
        end
    end

    --===========================================================================
    gg_trg_ST4DefenseDrone2 = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_ST4DefenseDrone2, gg_rct_DD2)
    TriggerAddCondition(gg_trg_ST4DefenseDrone2, Condition(Trig_ST4DefenseDrone2_Conditions))
    TriggerAddAction(gg_trg_ST4DefenseDrone2, Trig_ST4DefenseDrone2_Actions)
end)
if Debug then Debug.endFile() end
