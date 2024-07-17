if Debug then Debug.beginFile "Game/Stations/ST8/CalipeaAttack" end
OnInit.map("CalipeaAttack", function(require)
    ---@return boolean
    function Trig_CalipoaAttack_Conditions()
        if (not (gg_unit_h04E_0259 == GetAttacker())) then
            return false
        end
        return true
    end

    function CalipoaResetAttack()
        local k = GetExpiredTimer() ---@type timer
        local b = LoadLightningHandle(LS(), GetHandleId(gg_unit_h04E_0259), StringHash("attackLightning")) ---@type lightning
        DestroyLightning(b)
        DestroyTimer(k)
        SaveBoolean(LS(), GetHandleId(gg_unit_h04E_0259), StringHash("attackInt"), false)
        StopSound(gg_snd_MagicLariatLoop1, false, true)
    end

    function Trig_CalipoaAttack_Actions()
        local k ---@type timer
        local b ---@type lightning
        local m  = GetTriggerUnit() ---@type unit
        local vb = GetUnitFacing(gg_unit_h04E_0259) * bj_DEGTORAD ---@type real
        if HaveSavedBoolean(LS(), GetHandleId(gg_unit_h04E_0259), StringHash("attackInt")) and LoadBoolean(LS(), GetHandleId(gg_unit_h04E_0259), StringHash("attackInt")) == true then
            k = LoadTimerHandle(LS(), GetHandleId(gg_unit_h04E_0259), StringHash("attackResetTimer"))
            b = LoadLightningHandle(LS(), GetHandleId(gg_unit_h04E_0259), StringHash("attackLightning"))
            TimerStart(k, 0.1, false, CalipoaResetAttack)
            MoveLightningEx(b, false, GetUnitX(gg_unit_h04E_0259) + 90.0 * Cos(vb),
                GetUnitY(gg_unit_h04E_0259) + 90.0 * Sin(vb), -170.0, GetUnitX(m) + 20.0 * Cos(vb),
                GetUnitY(m) + 20.0 * Sin(vb), -170.0)
        else
            k = CreateTimer()
            TimerStart(k, 0.1, false, CalipoaResetAttack)
            SaveTimerHandle(LS(), GetHandleId(gg_unit_h04E_0259), StringHash("attackResetTimer"), k)
            SaveLightningHandle(LS(), GetHandleId(gg_unit_h04E_0259), StringHash("attackLightning"),
                AddLightningEx("AFOD", false, GetUnitX(gg_unit_h04E_0259) + 90.0 * Cos(vb),
                    GetUnitY(gg_unit_h04E_0259) + 90.0 * Sin(vb), -170.0, GetUnitX(m) + 20.0 * Cos(vb),
                    GetUnitY(m) + 20.0 * Sin(vb), -170.0))
            SaveBoolean(LS(), GetHandleId(gg_unit_h04E_0259), StringHash("attackInt"), true)
            SetSoundPosition(gg_snd_MagicLariatLoop1, GetUnitX(gg_unit_h04E_0259), GetUnitY(gg_unit_h04E_0259), 0.0)
            PlaySoundBJ(gg_snd_MagicLariatLoop1)
        end
    end

    --===========================================================================
    gg_trg_CalipoaAttack = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_CalipoaAttack, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_CalipoaAttack, Condition(Trig_CalipoaAttack_Conditions))
    TriggerAddAction(gg_trg_CalipoaAttack, Trig_CalipoaAttack_Actions)
end)
if Debug then Debug.endFile() end
