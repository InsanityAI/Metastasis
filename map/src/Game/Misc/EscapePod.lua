if Debug then Debug.beginFile "Game/Misc/EscapePod" end
OnInit.map("EscapePod", function(require)
    ---@return boolean
    function Trig_EscapePod_Conditions()
        if (not (GetItemTypeId(GetSoldItem()) == FourCC('I010'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_EscapePod_Func002Func001C()
        if (not (udg_EscapePodVendor_Harbor[GetUnitUserData(GetSellingUnit())] == gg_unit_h00X_0049)) then
            return false
        end
        if (not (IsTriggerEnabled(gg_trg_SwaggerTeleportToPlanet) == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_EscapePod_Func002C()
        if (not Trig_EscapePod_Func002Func001C()) then
            return false
        end
        if (udg_Blackout == true) then
            return true
        end
        return true
    end

    ---@return boolean
    function Trig_EscapePod_Func003Func029Func001C()
        if ((udg_Parasite == GetOwningPlayer(udg_TempUnit))) then
            return true
        end
        if ((Player(bj_PLAYER_NEUTRAL_EXTRA) == GetOwningPlayer(udg_TempUnit))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_EscapePod_Func003Func029C()
        if (not Trig_EscapePod_Func003Func029Func001C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_EscapePod_Func003Func033C()
        if ((udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetBuyingUnit()))] ~= GetBuyingUnit())) then
            return true
        end
        if ((GetUnitTypeId(GetBuyingUnit()) == FourCC('h01Q'))) then
            return true
        end
        if ((GetOwningPlayer(GetBuyingUnit()) == Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_EscapePod_Func003C()
        if (not (GetUnitTypeId(GetBuyingUnit()) ~= FourCC('e00L'))) then
            return false
        end
        if (not Trig_EscapePod_Func003Func033C()) then
            return false
        end
        return true
    end

    function PodDamageCheck()
        local om     = GetTriggeringTrigger() ---@type trigger
        local damage = LoadReal(LS(), GetHandleId(om), StringHash("damagetaken")) + GetEventDamage() ---@type real
        local b      = LoadUnitHandle(LS(), GetHandleId(om), StringHash("b")) ---@type unit
        local c      = LoadUnitHandle(LS(), GetHandleId(om), StringHash("c")) ---@type unit
        if udg_ShieldHP[GetUnitAN(GetTriggerUnit())] > 0.0 then
            damage = 300.0
        end
        SaveReal(LS(), GetHandleId(om), StringHash("damagetaken"), damage)
        if damage >= 35.0 then
            ShowUnitHide(b)
            ShowUnitHide(c)
            SetUnitPosition(b, GetLocationX(udg_HoldZone), GetLocationY(udg_HoldZone))
            SetUnitPosition(c, GetLocationX(udg_HoldZone), GetLocationY(udg_HoldZone))
        end
    end

    function Trig_EscapePod_Actions()
        local b ---@type unit
        local c ---@type unit
        local d = GetBuyingUnit() ---@type unit
        local e ---@type location
        local q = GetSellingUnit() ---@type unit
        local om ---@type trigger

        if GetUnitTypeId(d) == FourCC('e00L') then
            d = udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(d))]
        end

        RemoveItem(GetSoldItem())
        if TimerGetElapsed(udg_GameTimer) - udg_Player_LastPodTime[GetConvertedPlayerId(GetOwningPlayer(d))] < 100.0 then
            DisplayTextToPlayer(GetOwningPlayer(d), 0, 0,
                "|cffFF0000We're sorry, but you may not use a pod at this time. Please wait " +
                R2S(100 -
                    (TimerGetElapsed(udg_GameTimer) - udg_Player_LastPodTime[GetConvertedPlayerId(GetOwningPlayer(d))])) +
                " seconds.")
            return
        end
        if (Trig_EscapePod_Func002C()) or GetUnitAbilityLevel(d, FourCC('A07E')) > 0 then
            DisplayTextToPlayer(GetOwningPlayer(d), 0, 0, "TRIGSTR_2849")
            --call AdjustPlayerStateBJ( 2000, GetOwningPlayer(d), PLAYER_STATE_RESOURCE_GOLD )
            return
        end
        if GetUnitTypeId(d) == FourCC('h02X') then
            DisplayTextToPlayer(GetOwningPlayer(d), 0, 0, "TRIGSTR_2849")
            return
        end

        if (Trig_EscapePod_Func003C()) then
            DisplayTextToPlayer(GetOwningPlayer(d), 0, 0, "TRIGSTR_2852")
            --call AdjustPlayerStateBJ( 2000, GetOwningPlayer(d), PLAYER_STATE_RESOURCE_GOLD )
        else
            udg_TempPoint3 = GetUnitLoc(d)
            CreateNUnitsAtLoc(1, FourCC('e01F'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint3, GetRandomDirectionDeg())
            SetUnitFlyHeightBJ(GetLastCreatedUnit(), 180.00, 45.00)
            b = GetLastCreatedUnit()
            CreateNUnitsAtLoc(1, FourCC('e01F'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint3, GetRandomDirectionDeg())
            SetUnitFlyHeightBJ(GetLastCreatedUnit(), 180.00, 0.00)
            SetUnitFlyHeightBJ(GetLastCreatedUnit(), 0.00, 45.00)
            c = GetLastCreatedUnit()
            om = CreateTrigger()
            TriggerRegisterUnitEvent(om, d, EVENT_UNIT_DAMAGED)
            TriggerAddAction(om, PodDamageCheck)
            SaveReal(LS(), GetHandleId(om), StringHash("damagetaken"), 0)
            SaveUnitHandle(LS(), GetHandleId(om), StringHash("b"), b)
            SaveUnitHandle(LS(), GetHandleId(om), StringHash("c"), c)
            udg_TempUnit = c
            udg_CountUpBarColor = "|cff00FF00"
            DisplayTextToPlayer(GetOwningPlayer(d), 0, 0, "TRIGSTR_2850")
            RemoveLocation(udg_TempPoint3)
            e = GetUnitLoc(d)
            CountUpBar(udg_TempUnit, 40, 0.1, "DoNothing")
            if GetUnitAbilityLevel(d, FourCC('A07E')) > 0 then
                DisplayTextToPlayer(GetOwningPlayer(d), 0, 0, "TRIGSTR_2849")
                return
            end
            udg_TempUnit = d
            if (GetUnitTypeId(udg_TempUnit) == FourCC('e00L')) then
                udg_TempUnit = udg_AlienForm_Alien
            else
            end
            udg_TempPoint3 = GetUnitLoc(d)
            if GetUnitAbilityLevel(udg_TempUnit, FourCC('A07E')) >= 1 or LoadReal(LS(), GetHandleId(om), StringHash("damagetaken")) >= 35.0 or IsUnitDeadBJ(udg_TempUnit) == true or DistanceBetweenPoints(udg_TempPoint3, e) >= 90.0 then
                DisplayTextToPlayer(GetOwningPlayer(d), 0, 0, "TRIGSTR_2851")
                --  call AdjustPlayerStateBJ( 2000, GetOwningPlayer(udg_TempUnit), PLAYER_STATE_RESOURCE_GOLD )
                RemoveLocation(e)
                RemoveLocation(udg_TempPoint3)
                FlushChildHashtable(LS(), GetHandleId(om))
                DestroyTrigger(om)
                ShowUnitHide(b)
                ShowUnitHide(c)
                return
            else
                FlushChildHashtable(LS(), GetHandleId(om))
                DestroyTrigger(om)
                ShowUnitHide(b)
                ShowUnitHide(c)
                RemoveLocation(e)
                RemoveLocation(udg_TempPoint3)
            end
            udg_Player_LastPodTime[GetConvertedPlayerId(GetOwningPlayer(d))] = TimerGetElapsed(udg_GameTimer)
            ShowUnitHide(udg_TempUnit)
            PauseUnitBJ(true, udg_TempUnit)
            UnitAddAbilityBJ(FourCC('A04V'), udg_TempUnit)
            SetUnitPositionLoc(udg_TempUnit, udg_HoldZone)
            udg_TempPoint = GetUnitLoc(udg_EscapePodVendor_Harbor[GetUnitUserData(q)])
            CreateNUnitsAtLoc(1, FourCC('h02P'), GetOwningPlayer(udg_TempUnit), udg_TempPoint, bj_UNIT_FACING)
            NewUnitRegister(GetLastCreatedUnit())
            SaveInteger(LS(), GetHandleId(GetLastCreatedUnit()), StringHash("PushTolerance"), 0)
            udg_EscapePod_LifeReset[GetUnitUserData(GetLastCreatedUnit())] = GetUnitLifePercent(udg_TempUnit)
            udg_EscapePod_Owner[GetUnitUserData(GetLastCreatedUnit())] = GetOwningPlayer(udg_TempUnit)
            if (udg_TempUnit == udg_AlienForm_Alien) then
                SelectUnitForPlayerSingle(GetLastCreatedUnit(), udg_Parasite)
                PanCameraToTimedLocForPlayer(udg_Parasite, udg_TempPoint, 1)
            else
                SelectUnitForPlayerSingle(GetLastCreatedUnit(), GetOwningPlayer(udg_TempUnit))
                PanCameraToTimedLocForPlayer(GetOwningPlayer(udg_TempUnit), udg_TempPoint, 0)
            end
            RemoveLocation(udg_TempPoint)
            RemoveLocation(udg_TempPoint2)
            if (udg_Mutant == GetOwningPlayer(udg_TempUnit)) then
                DisableTrigger(gg_trg_MutantUpgrade)
            end
            if (Trig_EscapePod_Func003Func029C()) then
                DisableTrigger(gg_trg_ParasiteUpgrade)
            end
        end
    end

    --===========================================================================
    gg_trg_EscapePod = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_EscapePod, EVENT_PLAYER_UNIT_SELL_ITEM)
    TriggerAddCondition(gg_trg_EscapePod, Condition(Trig_EscapePod_Conditions))
    TriggerAddAction(gg_trg_EscapePod, Trig_EscapePod_Actions)
end)
if Debug then Debug.endFile() end
