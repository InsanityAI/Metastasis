if Debug then Debug.beginFile "Game/RandomEvents/Snoeglays" end
OnInit.trig("Snoeglays", function(require)
    ---@return boolean
    function Trig_Snoeglays_Func004Func003C()
        if (not (GetOwningPlayer(GetLastReplacedUnitBJ()) == Player(PLAYER_NEUTRAL_PASSIVE))) then
            return false
        end
        return true
    end

    function Trig_Snoeglays_Func004A()
        udg_TempPoint = GetUnitLoc(GetEnumUnit())
        ReplaceUnitBJ(GetEnumUnit(), FourCC('h02E'), bj_UNIT_STATE_METHOD_RELATIVE)
        if (Trig_Snoeglays_Func004Func003C()) then
            SetUnitOwner(GetLastReplacedUnitBJ(), Player(PLAYER_NEUTRAL_AGGRESSIVE), true)
        else
        end
        DropItemFromUnitOnDeath(GetLastReplacedUnitBJ(), FourCC('I024'))
        AddSpecialEffectLocBJ(udg_TempPoint, "Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl")
        SFXThreadClean()
        RemoveLocation(udg_TempPoint)
    end

    function Trig_Snoeglays_Actions()
        DestroyTrigger(GetTriggeringTrigger())
        udg_RandomEvent_On[5] = true
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_1357")
        ForGroupBJ(GetUnitsOfTypeIdAll(FourCC('n003')), Trig_Snoeglays_Func004A)
        StartTimerBJ(udg_RandomEvent, false, GetRandomReal(90.00, 1200.00))
    end

    --===========================================================================
    gg_trg_Snoeglays = CreateTrigger()
    DisableTrigger(gg_trg_Snoeglays)
    TriggerAddAction(gg_trg_Snoeglays, Trig_Snoeglays_Actions)
end)
if Debug then Debug.endFile() end
