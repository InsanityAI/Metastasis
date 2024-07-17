if Debug then Debug.beginFile "Game/Stations/Moon/GravitationalControl" end
OnInit.trig("GravitationalControl", function(require)
    ---@return boolean
    function Trig_GravitationalControl_Func001C()
        if (not (GetOwningPlayer(GetBuyingUnit()) == Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return false
        end
        return true
    end

    function Trig_GravitationalControl_Actions()
        local d ---@type player
        if (Trig_GravitationalControl_Func001C()) then
            udg_TempPlayer = udg_Parasite
        else
            udg_TempPlayer = GetOwningPlayer(GetBuyingUnit())
        end
        udg_TempPoint = GetUnitLoc(gg_unit_h03T_0209)
        CreateNUnitsAtLoc(1, FourCC('e017'), udg_TempPlayer, udg_TempPoint, bj_UNIT_FACING)
        PanCameraToTimedLocForPlayer(udg_TempPlayer, udg_TempPoint, 0)
        RemoveLocation(udg_TempPoint)
        d = udg_TempPlayer
        SelectUnitForPlayerSingle(GetLastCreatedUnit(), udg_TempPlayer)
        PolledWait(0.01)
        ForceUIKeyBJ(d, "J")
    end

    --===========================================================================
    gg_trg_GravitationalControl = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_GravitationalControl, gg_unit_h012_0217, EVENT_UNIT_SELL_ITEM)

    TriggerAddAction(gg_trg_GravitationalControl, Trig_GravitationalControl_Actions)
end)
if Debug then Debug.endFile() end
