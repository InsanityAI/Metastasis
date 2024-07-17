if Debug then Debug.beginFile "Game/Stations/ST11/OvelordPods" end
OnInit.map("OvelordPods", function(require)
    ---@return boolean
    function Trig_Overlord_Pods_Conditions()
        if (GetSpellAbilityId() ~= FourCC('A08H')) then
            return false
        end
        return true
    end

    function TransportedDestruction()
        if IsUnitInTransport(GetEnumUnit(), udg_TempUnit) then
            KillUnit(GetEnumUnit())
        end
    end

    function Trig_Overlord_Pods_Actions()
        local a       = GetSpellAbilityUnit() ---@type unit
        local b       = GetSpellTargetUnit() ---@type unit
        local qrqr    = GetOwningPlayer(a) ---@type player
        local c ---@type unit
        local r ---@type rect
        local loc ---@type location
        local loc2 ---@type location
        local d ---@type real
        local targetX = GetUnitX(b) ---@type real
        local targetY = GetUnitY(b) ---@type real
        local currentX ---@type real
        local currentY ---@type real
        local d2 ---@type real
        local flag ---@type boolean
        local g ---@type group
        local g2 ---@type group
        local g3 ---@type group

        loc           = GetUnitLoc(udg_Sector_Space[GetUnitSector(a)])
        flag          = false
        d             = udg_SpaceObject_CollideRadius[GetUnitAN(b)] * 1.2
        d2            = d * d

        if (d < 150) then
            d = 150
            d2 = d * d
        end

        if (GetUnitTypeId(b) == FourCC('h03T')) then
            r = gg_rct_MoonEscapePod
        else
            if (GetUnitTypeId(b) == FourCC('h007')) then
                r = gg_rct_ST3EscapePod
            else
                if (GetUnitTypeId(b) == FourCC('h008')) then
                    r = gg_rct_PlanetEscapePod
                else
                    if (GetUnitTypeId(b) == FourCC('h003')) then
                        r = gg_rct_ST1EscapePod
                    else
                        if (GetUnitTypeId(b) == FourCC('h009')) then
                            r = gg_rct_ST4EscapePod
                        else
                            if (GetUnitTypeId(b) == FourCC('h00X')) then
                                r = gg_rct_ST5EscapePod
                            else
                                if (GetUnitTypeId(b) == FourCC('h04T')) then
                                    r = gg_rct_ST9EscapePod
                                else
                                    if (GetUnitTypeId(b) == FourCC('h04V')) then
                                        r = gg_rct_ST10EscapePod
                                    else
                                        if (GetUnitTypeId(b) == FourCC('h04E')) then
                                            r = gg_rct_ST8EscapePod
                                        else
                                            if IsUnitExplorer(b) then
                                                r = udg_Spaceship_EnterExit[GetUnitAN(b)]
                                            else
                                                DisplayTextToPlayer(GetOwningPlayer(a), 0, 0,
                                                    "|cffFF0000INVALID TARGET|r")
                                                flag = true
                                                --return null
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        if (not (flag)) then
            c = CreateUnitAtLoc(Player(PLAYER_NEUTRAL_PASSIVE), FourCC('h04Z'), loc, 0)

            SetUnitX(a, GetRectCenterX(gg_rct_Timeout))
            SetUnitY(a, GetRectCenterY(gg_rct_Timeout))
            --call SetUnitOwner(a, Player(PLAYER_NEUTRAL_PASSIVE), true)
            UnitAddAbility(a, FourCC('A08I'))
            UnitAddAbility(a, FourCC('Aloc'))

            --call DisplayTextToPlayer(Player(0), 0, 0, GetUnitName(c))
            --call DisplayTextToPlayer(Player(0), 0, 0, GetLocationX(loc2) + "," + GetLocationY(loc2) + " " + GetUnitX(c) + " " + GetUnitY(c))


            while not (flag) do
                currentX = GetUnitX(c)
                currentY = GetUnitY(c)
                targetX = GetUnitX(b)
                targetY = GetUnitY(b)
                flag = ((Pow(targetX - currentX, 2) + Pow(targetY - currentY, 2)) <= d2)
                loc2 = Location(targetX, targetY)
                loc2 = Location(targetX, targetY)
                IssuePointOrderLocBJ(c, "move", loc2)
                IssuePointOrderLoc(c, "move", loc2)
                RemoveLocation(loc2)
                if (GetUnitLifePercent(c) == 0) then
                    --call RemoveUnit(a)
                    g3 = GetUnitsOfPlayerAll(qrqr)
                    udg_TempUnit = a
                    ForGroup(g3, TransportedDestruction)
                    DestroyGroup(g3)
                    KillUnit(a)
                    KillUnit(c)
                    return
                end
                if GetUnitLifePercent(b) == 0 then
                    b = gg_unit_h008_0196
                    r = gg_rct_PlanetEscapePod
                end

                PolledWait(0.2)
            end
            RemoveLocation(loc2)
            --call SetUnitOwner(a, udg_Mutant, true)
            --call PolledWait(0.01)
            UnitRemoveAbility(a, FourCC('A08I'))
            UnitRemoveAbility(a, FourCC('Aloc'))
            SetUnitX(a, GetRectCenterX(r))
            SetUnitY(a, GetRectCenterY(r))
            UnitDamageTarget(a, b, 10000, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
            KillUnit(a)
            KillUnit(c)
            RemoveLocation(loc)
            PolledWait(0.001)
            g = GetUnitsInRectOfPlayer(r, udg_Mutant)
            g2 = CreateGroup()
            while true do
                a = FirstOfGroup(g)
                if a == nil then break end
                if (UnitHasBuffBJ(a, FourCC('B01C'))) then
                    UnitRemoveBuffBJ(FourCC('B01C'), a)
                    UnitAddAbility(a, FourCC('Avul'))
                    GroupAddUnit(g2, a)
                end
                GroupRemoveUnit(g, a)
            end
            PolledWait(2.0)
            while true do
                a = FirstOfGroup(g2)
                if a == nil then break end
                UnitRemoveAbility(a, FourCC('Avul'))
            end
            DestroyGroup(g2)
        end
    end

    --===========================================================================
    gg_trg_Overlord_Pods = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Overlord_Pods, EVENT_PLAYER_UNIT_SPELL_CAST)
    TriggerAddCondition(gg_trg_Overlord_Pods, Condition(Trig_Overlord_Pods_Conditions))
    TriggerAddAction(gg_trg_Overlord_Pods, Trig_Overlord_Pods_Actions)
end)
if Debug then Debug.endFile() end
