if Debug then Debug.beginFile "Game/Misc/AnyDeath" end
OnInit.map("AnyDeath", function(require)
    function Trig_AnyDeath_Actions()
        local a = GetDyingUnit() ---@type unit
        local b ---@type unit
        local c = GetOwningPlayer(a) ---@type player
        local o = (a == udg_Playerhero[GetConvertedPlayerId(c)]) ---@type boolean
        if GetUnitPointValue(a) ~= 37 and IsUnitIllusion(a) == false and o then
            udg_Unit_DeathTime[GetUnitUserData(a)] = TimerGetElapsed(udg_GameTimer)
            b = CreateUnit(Player(15), GetUnitTypeId(a), GetUnitX(a), GetUnitY(a), GetUnitFacing(a))
            SetUnitPathing(b, false)
            SetUnitX(b, GetUnitX(a))
            SetUnitY(b, GetUnitY(a))
            UnitAddAbility(b, FourCC('Avul'))
            UnitAddAbility(b, FourCC('Aloc'))
            UnitAddAbility(b, FourCC('A077'))
            if GetOwningPlayer(a) == udg_HiddenAndroid then
                UnitAddAbility(b, FourCC('A07P'))
            end
            SetUnitAnimation(b, "death")
            SetUnitVertexColor(a, 0, 0, 0, 0)
            SaveUnitHandle(LS(), GetHandleId(a), StringHash("Corpse"), b)
            SetUnitColor(b, GetPlayerColor(GetOwningPlayer(a)))

            PolledWait(1.0)
            if udg_Player_IsParasiteSpawn[GetConvertedPlayerId(c)] and IsUnitType(b, UNIT_TYPE_MECHANICAL) == false then
                SetUnitColor(b, ConvertPlayerColor(12))
                --call FadeUnitOverTime(b,5.0,true)
            end
            PolledWait(25.0)
            if not (o) and a ~= nil then
                SetUnitPosition(a, GetLocationX(udg_HoldZone), GetLocationY(udg_HoldZone))
                udg_UnitAssignation[GetUnitAN(a)] = udg_TheNullUnit
                RemoveUnit(a)
            end
        end
    end

    --===========================================================================
    gg_trg_AnyDeath = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_AnyDeath, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddAction(gg_trg_AnyDeath, Trig_AnyDeath_Actions)
end)
if Debug then Debug.endFile() end
