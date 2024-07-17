if Debug then Debug.beginFile "System/HeroSelectSys/SelectorUpdate" end
OnInit.trig("SelectorUpdate", function(require)
    ---@return boolean
    function Trig_SelectorUpdate_Func002Func003C()
        if (not (IsUnitAliveBJ(udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]) == true)) then
            return false
        end
        return true
    end

    function Trig_SelectorUpdate_Func002A()
        SetUnitLifePercentBJ(GetEnumUnit(),
            (GetUnitLifePercent(udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]) + 1.00))
        SetUnitManaPercentBJ(GetEnumUnit(),
            GetUnitManaPercent(udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]))
        if (Trig_SelectorUpdate_Func002Func003C()) then
            SetUnitPosition(GetEnumUnit(), GetUnitX(GetPlayerheroU(GetEnumUnit())),
                GetUnitY(GetPlayerheroU(GetEnumUnit())))
        else
        end
    end

    function Trig_SelectorUpdate_Actions()
        ForGroupBJ(udg_SelectorGroup, Trig_SelectorUpdate_Func002A)
    end

    --===========================================================================
    gg_trg_SelectorUpdate = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_SelectorUpdate, 0.25)
    TriggerAddAction(gg_trg_SelectorUpdate, Trig_SelectorUpdate_Actions)
end)
if Debug then Debug.endFile() end
