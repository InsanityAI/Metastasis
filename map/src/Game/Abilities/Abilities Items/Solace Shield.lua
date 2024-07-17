if Debug then Debug.beginFile "Game/Abilities/Items/SolaceShield" end
OnInit.trig("SolaceShield", function(require)
    ---@return boolean
    function Trig_Solace_Shield_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A054'))) then
            return false
        end
        return true
    end

    ---@param howmanybars integer
    ---@param maximumbars integer
    ---@param r unit
    ---@return texttag
    function CreateBarSolaceShield(howmanybars, maximumbars, r)
        local text = "|c000000FF" ---@type string
        local i    = 0 ---@type integer
        while i <= howmanybars do
            i = i + 1
            text = text .. "I"
        end
        text = text .. "|r"
        i = 0
        while not (i > (maximumbars - howmanybars)) do
            i = i + 1
            text = text .. "I"
        end
        CreateTextTagUnitBJ(text, r, GetUnitFlyHeight(r), 8, 255, 255, 255, 0)
        SetTextTagPermanent(bj_lastCreatedTextTag, false)
        SetTextTagLifespan(bj_lastCreatedTextTag, 0.5)
        SetTextTagFadepointBJ(GetLastCreatedTextTag(), 0.00)
        return bj_lastCreatedTextTag
    end

    function ShieldDamaged()
        BlockDamage(GetTriggerUnit(), GetEventDamage())
        udg_ShieldHP[GetUnitAN(GetTriggerUnit())] = udg_ShieldHP[GetUnitAN(GetTriggerUnit())] - GetEventDamage()
        if udg_ShieldHP[GetUnitAN(GetTriggerUnit())] <= 0.00 then
            DestroyTrigger(GetTriggeringTrigger())
            UnitRemoveBuffBJ(FourCC('B00X'), GetTriggerUnit())
            udg_ShieldHP[GetUnitAN(GetTriggerUnit())] = 0.00
        else
            CreateBarSolaceShield(R2I(udg_ShieldHP[GetUnitAN(GetTriggerUnit())] / 10), 30, GetTriggerUnit())
        end
        if GetUnitState(GetTriggerUnit(), UNIT_STATE_LIFE) <= 0 then
            ReviveHero(GetTriggerUnit(), GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()), false)
        end
    end

    function SolaceShield_Disable()
        local k                    = GetExpiredTimer() ---@type timer
        local x                    = LoadUnitHandle(LS(), GetHandleId(k), StringHash("unit")) ---@type unit
        udg_ShieldHP[GetUnitAN(x)] = 0
        UnitDamageTarget(x, x, 0.00, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
        FlushChildHashtable(LS(), GetHandleId(k))
        DestroyTimer(k)
    end

    function Trig_Solace_Shield_Actions()
        local t ---@type trigger
        local x = GetSpellTargetUnit() ---@type unit
        local k = LoadTimerHandle(LS(), GetHandleId(GetSpellTargetUnit()), StringHash("Solace_Shield_Disable")) ---@type timer
        if k == nil then
            k = CreateTimer()
            SaveUnitHandle(LS(), GetHandleId(k), StringHash("unit"), GetSpellTargetUnit())
        end
        if udg_ShieldHP[GetUnitAN(GetSpellTargetUnit())] ~= 0.00 then
            return
        end
        t = CreateTrigger()
        TriggerRegisterUnitEvent(t, GetSpellTargetUnit(), EVENT_UNIT_DAMAGED)
        TriggerAddAction(t, ShieldDamaged)
        udg_ShieldHP[GetUnitAN(GetSpellTargetUnit())] = 300 + udg_ShieldHP[GetUnitAN(GetSpellTargetUnit())]
        TimerStart(k, 15.0, false, SolaceShield_Disable)
        --call PolledWait(15.0)
    end

    --===========================================================================
    gg_trg_Solace_Shield = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Solace_Shield, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Solace_Shield, Condition(Trig_Solace_Shield_Conditions))
    TriggerAddAction(gg_trg_Solace_Shield, Trig_Solace_Shield_Actions)
end)
if Debug then Debug.endFile() end
