if Debug then Debug.beginFile "Game/Misc/DamageSys" end
OnInit.map("DamageSys", function(require)
    ---@return boolean
    function Trig_DamageSys_Func001C()
        if (not (udg_TempInt ~= 37)) then
            return false
        end
        return true
    end

    function VendorDisabling_Damage()
        if GetUnitAbilityLevel(GetEnumUnit(), FourCC('A07Q')) >= 1 then
            VendorIsDamaged(GetEnumUnit())
            --call UnitDamageTarget(udg_TempUnit,GetEnumUnit(),0.1,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
            --call SetUnitLifeBJ(GetEnumUnit(),GetUnitState(GetEnumUnit(),UNIT_STATE_LIFE)+0.1)
        end
    end

    ---@param a unit
    function VendorDisabling(a)
        local c ---@type location
        local g ---@type group
        while not (GetGameTime() - udg_Unit_VendorDisablingTime[GetUnitAN(a)] > 9.5) do
            c = GetUnitLoc(a)
            g = GetUnitsInRangeOfLocAll(650.0, c)
            udg_TempUnit = a
            ForGroup(g, VendorDisabling_Damage)
            RemoveLocation(c)
            DestroyGroup(g)
            PolledWait(0.25)
        end
        udg_Unit_VendorDisabling[GetUnitAN(a)] = false
    end

    function UponDamage()
        local a  = GetEventDamageSource() ---@type unit
        local k  = GetEventDamage() ---@type real
        local r  = GetTriggerUnit() ---@type unit
        local o  = GetUnitState(GetTriggerUnit(), UNIT_STATE_LIFE) ---@type real
        local ag ---@type group
        local op ---@type unit
        local ir = 0 ---@type integer
        if k > o then
            k = o
        end
        --

        if UnitHasBuffBJ(r, FourCC('B009')) or UnitHasBuffBJ(r, FourCC('B01F')) then
            udg_Unit_IsInfected[GetUnitAN(r)] = true
            udg_Unit_InfectionType[GetUnitAN(r)] = 1
        else
            if UnitHasBuffBJ(r, FourCC('B00H')) or UnitHasBuffBJ(r, FourCC('B01G')) then
                udg_Unit_IsInfected[GetUnitAN(r)] = true
                udg_Unit_InfectionType[GetUnitAN(r)] = 2
            else
                udg_Unit_IsInfected[GetUnitAN(r)] = false
            end
        end
        --if udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(r))] == r then
        --set udg_Player_DamageTaken[GetConvertedPlayerId(GetOwningPlayer(r))] = udg_Player_DamageTaken[GetConvertedPlayerId(GetOwningPlayer(r))] + k
        --endif
        if k == 4.39 or k == 6.53 or k == 8.53 or k == 0.0 then
            --Exact damage of acid suit's acid and various infections
            return
        end
        --Force suit attack detection
        --if GetUnitTypeId(a)==FourCC('h03L')  and (TimerGetElapsed(udg_GameTimer)-udg_ForceSuit_LastAttackTime[GetUnitAN(a)]==0.375 or TimerGetElapsed(udg_GameTimer)-udg_ForceSuit_LastAttackTime[GetUnitAN(a)]==0.5) then
        --call ExecuteFunc("Trig_ForceSuitAttack_Actions")
        --return
        --endif
        --

        if (GetOwningPlayer(a) == udg_Mutant or udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(a))]) and r == udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(r))] and GetOwningPlayer(r) ~= udg_Mutant and udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(r))] == false and RectContainsUnit(gg_rct_Space, r) == false then
            if udg_Mutant_DamageToPlayer[GetConvertedPlayerId(GetOwningPlayer(r))] < 1 then
                udg_Mutant_DamageToPlayer[GetConvertedPlayerId(GetOwningPlayer(r))] = udg_Mutant_DamageToPlayer
                    [GetConvertedPlayerId(GetOwningPlayer(r))] + k / GetUnitState(r, UNIT_STATE_MAX_LIFE)
                if udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(a))] then
                    udg_UpgradePointsMutant = udg_UpgradePointsMutant + (k / GetUnitState(r, UNIT_STATE_MAX_LIFE)) * 50
                else
                    if udg_Mutant_IsPerfection then
                        udg_UpgradePointsMutant = udg_UpgradePointsMutant + (k / GetUnitState(r, UNIT_STATE_MAX_LIFE)) *
                            200
                    else
                        udg_UpgradePointsMutant = udg_UpgradePointsMutant + (k / GetUnitState(r, UNIT_STATE_MAX_LIFE)) *
                            50
                    end
                end
            end
        end


        if a ~= nil and (GetOwningPlayer(a) == udg_HiddenAndroid or GetOwningPlayer(r) == udg_HiddenAndroid) and r == udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(r))] then
            LogTKPoints(GetOwningPlayer(a), GetOwningPlayer(r), k)
        end
        if IsUnitPlayerhero(r) then
            udg_Unit_VendorDisablingTime[GetUnitAN(r)] = GetGameTime()
            if not (udg_Unit_VendorDisabling[GetUnitAN(r)]) then
                udg_Unit_VendorDisabling[GetUnitAN(r)] = true
                VendorDisabling(r)
            end
        end
    end

    function Trig_DamageSys_Actions()
        if (Trig_DamageSys_Func001C()) then
            TriggerRegisterUnitEvent(udg_DamageTrig, GetTriggerUnit(), EVENT_UNIT_DAMAGED)
        end
    end

    function Trig_DamageSys_2Actions()
        if (Trig_DamageSys_Func001C()) then
            TriggerRegisterUnitEvent(udg_DamageTrig, GetEnumUnit(), EVENT_UNIT_DAMAGED)
        end
    end

    --===========================================================================
    gg_trg_DamageSys = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_DamageSys, GetPlayableMapRect())
    TriggerAddAction(gg_trg_DamageSys, Trig_DamageSys_Actions)
    udg_DamageTrig = CreateTrigger()
    TriggerAddAction(udg_DamageTrig, UponDamage)
    udg_TempUnitGroup = GetUnitsInRectAll(GetPlayableMapRect())
    ForGroup(udg_TempUnitGroup, Trig_DamageSys_2Actions)
    DestroyGroup(udg_TempUnitGroup)
end)
if Debug then Debug.endFile() end
