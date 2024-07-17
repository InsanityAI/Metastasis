if Debug then Debug.beginFile "Game/Suits/PulseSuitAttack" end
OnInit.trig("PulseSuitAttack", function(require)
    ---@return boolean
    function Trig_PulseSuitAttack_Conditions()
        if GetUnitTypeId(GetAttacker()) == FourCC('h04M') then
            return true
        end
        return false
    end

    function PulseResetAttack()
        local k = GetExpiredTimer() ---@type timer

        local r = LoadUnitHandle(LS(), GetHandleId(k), StringHash("unit")) ---@type unit
        local b = LoadLightningHandle(LS(), GetHandleId(r), StringHash("attackLightning")) ---@type lightning
        local s = LoadSoundHandle(LS(), GetHandleId(k), StringHash("loopingSound")) ---@type sound
        StopSound(s, true, true)
        SetUnitTimeScale(r, 1)
        DestroyLightning(b)
        DestroyTimer(k)
        SaveBoolean(LS(), GetHandleId(r), StringHash("attackInt"), false)
        StopSound(gg_snd_MagicLariatLoop1, false, true)
    end

    ---@param a real
    ---@param b real
    ---@return real
    function Cap(a, b)
        if a > b then
            return b
        end
        return a
    end

    function Trig_PulseSuitAttack_Actions()
        local k ---@type timer
        local b ---@type lightning
        local m           = GetTriggerUnit() ---@type unit
        local r           = GetAttacker() ---@type unit
        local vb          = GetUnitFacing(r) * bj_DEGTORAD ---@type real
        local zget        = GetUnitLoc(r) ---@type location
        local zget2       = GetUnitLoc(m) ---@type location
        local z1          = GetLocationZ(zget) ---@type real
        local z2          = GetLocationZ(zget2) ---@type real
        local currentMana = GetUnitState(r, UNIT_STATE_MANA) ---@type real
        local usedMana    = (85 * currentMana / 100) * 0.05 ---@type real
        local damage      = usedMana * 3 ---@type real
        local s ---@type sound

        damage            = Cap(damage, 175 * 0.05)
        SetUnitState(r, UNIT_STATE_MANA, currentMana - usedMana)
        if IsUnitIllusionBJ(GetAttacker()) == false then
            UnitDamageTarget(r, m, damage, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
        else
        end
        if GetRandomReal(0, 1.2) <= damage / 7.2 then
            AddSpecialEffect("Abilities\\Spells\\Human\\MarkOfChaos\\MarkOfChaosDone.mdl", GetUnitX(m), GetUnitY(m))
            SFXThreadClean()
        end
        RemoveLocation(zget)
        RemoveLocation(zget2)
        zget = nil
        zget2 = nil
        if HaveSavedBoolean(LS(), GetHandleId(r), StringHash("attackInt")) and LoadBoolean(LS(), GetHandleId(r), StringHash("attackInt")) == true then
            k = LoadTimerHandle(LS(), GetHandleId(r), StringHash("attackResetTimer"))
            b = LoadLightningHandle(LS(), GetHandleId(r), StringHash("attackLightning"))
            TimerStart(k, .2, false, PulseResetAttack)
            MoveLightningEx(b, false, GetUnitX(r) + 50.0 * Cos(vb) + 19 * Cos(vb - bj_PI / 2),
                GetUnitY(r) + 50.0 * Sin(vb) + 19 * Sin(vb - bj_PI / 2), z1 + 50, GetUnitX(m) + 20.0 * Cos(vb),
                GetUnitY(m) + 20.0 * Sin(vb), z2 + 30)
            SetLightningColor(b, 1, 1, 1, Cap((damage) / 7 * 1 + 0.1, 1))
            SetSoundVolume(LoadSoundHandle(LS(), GetHandleId(k), StringHash("loopingSound")),
                R2I(Cap(damage / 7 * 125 + 50, 126)))
        else
            SetUnitTimeScale(r, 2)
            k = CreateTimer()
            s = CreateSound("Sound\\Ambient\\DoodadEffects\\EnchantedCellLoop.wav", true, true, true, 126, 126, "")
            SetSoundPitch(s, 1.3)
            SetSoundPosition(s, GetUnitX(r), GetUnitY(r), 0.0)
            PlaySoundBJ(s)
            SaveBoolean(LS(), GetHandleId(r), StringHash("attackInt"), true)
            TimerStart(k, .2, false, PulseResetAttack)
            SaveSoundHandle(LS(), GetHandleId(k), StringHash("loopingSound"), s)
            SaveTimerHandle(LS(), GetHandleId(r), StringHash("attackResetTimer"), k)
            SaveUnitHandle(LS(), GetHandleId(k), StringHash("unit"), r)
            SaveLightningHandle(LS(), GetHandleId(r), StringHash("attackLightning"),
                AddLightningEx("AFOD", false, GetUnitX(r) + 50.0 * Cos(vb) + 19 * Cos(vb - bj_PI / 2),
                    GetUnitY(r) + 50.0 * Sin(vb) + 19 * Sin(vb - bj_PI / 2), z1 + 30, GetUnitX(m) + 20.0 * Cos(vb),
                    GetUnitY(m) + 20.0 * Sin(vb), z2 + 30))

            s = CreateSound("Abilities\\Spells\\Human\\InnerFire\\InnerFireBirth.wav", false, true, true, 126, 126, "")
            SetSoundPosition(s, GetUnitX(r), GetUnitY(r), 0.0)

            StartSound(s)
            KillSoundWhenDone(s)
        end
    end

    --===========================================================================
    gg_trg_PulseSuitAttack = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_PulseSuitAttack, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_PulseSuitAttack, Condition(Trig_PulseSuitAttack_Conditions))
    TriggerAddAction(gg_trg_PulseSuitAttack, Trig_PulseSuitAttack_Actions)
end)
if Debug then Debug.endFile() end
