if Debug then Debug.beginFile "Game/Stations/ST8/NeurotoxinStart" end
OnInit.trig("NeurotoxinStart", function(require)
    ---@return boolean
    function Trig_NeurotoxinStart_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A07D'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_NeurotoxinStart_Func001C()
        if (not (not (IsUnitExplorer(GetSpellTargetUnit()) or IsUnitStation(GetSpellTargetUnit())))) then
            return false
        end
        return true
    end

    function NeurotoxicDamage2()
        local o ---@type group
        local p ---@type player

        if GetPlayerheroU(GetEnumUnit()) == GetEnumUnit() and IsUnitType(GetEnumUnit(), UNIT_TYPE_STRUCTURE) == false and udg_HiddenAndroid ~= GetOwningPlayer(GetEnumUnit()) and GetOwningPlayer(GetEnumUnit()) ~= Player(PLAYER_NEUTRAL_PASSIVE) then
            UnitDamageTarget(GetEnumUnit(), GetEnumUnit(), udg_TempReal, false, false, ATTACK_TYPE_NORMAL,
                DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
            if udg_Player_TetrabinLevel[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] <= 0 then
                p = GetOwningPlayer(GetEnumUnit())
                if p == Player(bj_PLAYER_NEUTRAL_EXTRA) then
                    p = udg_Parasite
                end
                CinematicFilterGenericForPlayer(p, 12.0, BLEND_MODE_BLEND,
                    "ReplaceableTextures\\CameraMasks\\DreamFilter_Mask.blp", 20, 100, 20, 0, 0, 0, 0, 100)
            end
        end
        if IsUnitExplorer(GetEnumUnit()) then
            o = GetUnitsInRectAll(udg_SpaceObject_Rect[GetUnitAN(GetEnumUnit())])
            ForGroup(o, NeurotoxicDamage2)
            DestroyGroup(o)
        end
    end

    function NeurotoxinDamage()
        local k      = GetExpiredTimer() ---@type timer
        local damage = LoadReal(LS(), GetHandleId(k), StringHash("damage")) ---@type real
        local m      = LoadRectHandle(LS(), GetHandleId(k), StringHash("rect")) ---@type rect
        local o      = GetUnitsInRectAll(m) ---@type group
        udg_TempReal = damage
        ForGroup(o, NeurotoxicDamage2)
        SaveReal(LS(), GetHandleId(k), StringHash("damage"), damage + 0.03)
        DestroyGroup(o)
    end

    function Trig_NeurotoxinStart_Actions()
        local k ---@type timer
        local m  = GetSpellTargetUnit() ---@type unit
        local vb = GetUnitFacing(GetSpellAbilityUnit()) ---@type real
        if (Trig_NeurotoxinStart_Func001C()) or udg_SpaceObject_Rect[GetUnitAN(m)] == nil then
            IssueImmediateOrderBJ(gg_unit_h04E_0259, "stop")
            return
        else
        end
        k = CreateTimer()
        --bizarre but there are no hashtable functions for weather effects
        SaveLightningHandle(LS(), GetHandleId(gg_unit_h04E_0259), StringHash("neuroLightning"),
            AddLightningEx("DRAL", false, GetUnitX(m) + 20.0 * Cos(vb), GetUnitY(m) + 20.0 * Sin(vb), -170.0,
                GetUnitX(gg_unit_h04E_0259) + 90.0 * Cos(vb), GetUnitY(gg_unit_h04E_0259) + 90.0 * Sin(vb), -170.0))

        TimerStart(k, 1, true, NeurotoxinDamage)
        SaveReal(LS(), GetHandleId(k), StringHash("damage"), 5.0)
        SaveRectHandle(LS(), GetHandleId(k), StringHash("rect"), udg_SpaceObject_Rect[GetUnitAN(m)])
        SaveTimerHandle(LS(), GetHandleId(GetSpellAbilityUnit()), StringHash("neurotoxin_unit"), k)
    end

    --===========================================================================
    gg_trg_NeurotoxinStart = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_NeurotoxinStart, gg_unit_h04E_0259, EVENT_UNIT_SPELL_CHANNEL)
    TriggerAddCondition(gg_trg_NeurotoxinStart, Condition(Trig_NeurotoxinStart_Conditions))
    TriggerAddAction(gg_trg_NeurotoxinStart, Trig_NeurotoxinStart_Actions)
end)
if Debug then Debug.endFile() end
