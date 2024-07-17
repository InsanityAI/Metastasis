if Debug then Debug.beginFile "Game/Stations/ST3/ST3Cannon" end
OnInit.trig("ST3Cannon", function(require)
    ---@return boolean
    function Trig_ST3Cannon_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A005'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ST3Cannon_Func003Func004C()
        if ((RectContainsUnit(gg_rct_Space, GetSpellTargetUnit()) ~= true)) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h002'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h02H'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h02L'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h02Q'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h02T'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h02P'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h031'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h032'))) then
            return true
        end
        if ((GetUnitTypeId(GetSpellTargetUnit()) == FourCC('h03J'))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_ST3Cannon_Func003C()
        if (not Trig_ST3Cannon_Func003Func004C()) then
            return false
        end
        return true
    end

    function Trig_ST3Cannon_Actions()
        if (Trig_ST3Cannon_Func003C()) then
            DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, "TRIGSTR_5334")
            IssueImmediateOrderBJ(GetSpellAbilityUnit(), "stop")
            return
        else
        end
        DisplayTextToForce(GetPlayersAll(),
            ("|cffFF0000The Kyo Cannon has been fired at " .. (GetUnitName(GetSpellTargetUnit()) .. "!|r")))
        PlaySoundBJ(gg_snd_HumanDissipate1)
        PolledWait(1.00)
        PlaySoundBJ(gg_snd_ThunderClapCaster)
    end

    --===========================================================================
    gg_trg_ST3Cannon = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_ST3Cannon, gg_unit_h007_0027, EVENT_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_ST3Cannon, Condition(Trig_ST3Cannon_Conditions))
    TriggerAddAction(gg_trg_ST3Cannon, Trig_ST3Cannon_Actions)
end)
if Debug then Debug.endFile() end
