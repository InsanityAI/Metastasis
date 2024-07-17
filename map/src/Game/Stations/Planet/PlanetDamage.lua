if Debug then Debug.beginFile "Game/Stations/Planet/PlanetDamage" end
OnInit.trig("PlanetDamage", function(require)
    function Trig_PlanetDamage_DestructDamage()
        KillDestructable(GetEnumDestructable())
        if GetDestructableTypeId(GetEnumDestructable()) == FourCC('B006') then
            RemoveDestructable(GetEnumDestructable())
        end
    end

    function PBombardment_Damage()
        if IsUnitExplorer(GetEnumUnit()) then
            UnitDamageTarget(GetEventDamageSource(), GetEnumUnit(), 10000.0, true, false, ATTACK_TYPE_NORMAL,
                DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
        else
            UnitDamageTarget(GetEventDamageSource(), GetEnumUnit(), 4900.0, true, false, ATTACK_TYPE_NORMAL,
                DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
        end
    end

    function PlanetDamageExplosion()
        local t       = GetExpiredTimer() ---@type timer
        local ht      = GetHandleId(t) ---@type integer
        local damager = LoadUnitHandle(udg_hash, ht, StringHash("Damager")) ---@type unit
        local targetX = LoadReal(udg_hash, ht, StringHash("TargetX")) ---@type real
        local targetY = LoadReal(udg_hash, ht, StringHash("TargetY")) ---@type real
        local e       = AddSpecialEffect("SFX\\Explosions\\NuclearExplosion.mdl", targetX, targetY) ---@type effect
        local r       = Rect(targetX - 712.0, targetY - 712.0, targetX + 712.0, targetY + 712.0) ---@type rect
        local g       = CreateGroup() ---@type group
        local swaggerHealth ---@type real
        if UnitAlive(gg_unit_h008_0196) then
            BlzSetSpecialEffectScale(e, 2.00)
            BlzSetSpecialEffectTimeScale(e, 0.75)

            e = AddSpecialEffect("Abilities\\Spells\\Undead\\Darksummoning\\DarkSummonTarget.mdl", targetX, targetY)
            BlzSetSpecialEffectColor(e, 255, 126, 255)
            BlzSetSpecialEffectScale(e, 7.00)
            BlzSetSpecialEffectTime(e, 0.5)
            BlzSetSpecialEffectTimeScale(e, 0.00)

            EnumDestructablesInRect(r, DESTRUCT_FILTER, Trig_PlanetDamage_DestructDamage)
            RemoveRect(r)

            GroupEnumUnitsInRange(g, targetX, targetY, 600.0, UNIT_FILTER)
            ForGroup(g, PBombardment_Damage)
            DestroyGroup(g)

            TerrainDeformCrater(targetX, targetY, 600.00, 128.00, 1, true)
            SetBlight(Player(PLAYER_NEUTRAL_AGGRESSIVE), targetX, targetY, 600.0, true)

            if udg_Swagger_Grounded == true and UnitAlive(gg_unit_h00X_0049) then
                UnitDamageTarget(damager, gg_unit_h00X_0049, 20000, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL,
                    WEAPON_TYPE_WHOKNOWS)
                swaggerHealth = GetUnitState(gg_unit_h00X_0049, UNIT_STATE_LIFE) / 20000.0
                DisplayTextToForce(GetPlayersAll(),
                    "|cffFF0000WARNING: Atmospheric disturbance is damaging U.S.I. Swagger hull integrity. An immediate launch is recommended. Estimated " ..
                    I2S(R2I(swaggerHealth)) .. " impacts remaining before hull integrity failure.")
            end
        end

        FlushChildHashtable(udg_hash, ht)
        DestroyTimer(t)
    end

    function Trig_PlanetDamage_Actions()
        local iteration           = 1 ---@type integer
        local maxX                = GetRectMaxX(gg_rct_Planet) ---@type real
        local minX                = GetRectMinX(gg_rct_Planet) ---@type real
        local maxY                = GetRectMaxY(gg_rct_Planet) ---@type real
        local minY                = GetRectMinY(gg_rct_Planet) ---@type real
        local targetX ---@type real
        local targetY ---@type real
        local boomX ---@type real
        local boomY ---@type real
        local angle ---@type real
        local distance ---@type real
        local e ---@type effect
        local t ---@type timer
        local ht ---@type integer
        local damageIteration     = 0 ---@type integer

        udg_MinerthaDamageCounter = udg_MinerthaDamageCounter + GetEventDamage()
        while udg_MinerthaDamageCounter >= 30000 do
            udg_MinerthaDamageCounter = udg_MinerthaDamageCounter - 30000.00
            if UnitAlive(gg_unit_h008_0196) then
                boomX = GetRandomReal(minX, maxX)
                boomY = GetRandomReal(minY, maxY)

                while iteration <= 36 do
                    angle     = 2 * bj_PI * I2R(iteration) / 36
                    targetX   = boomX + 600 * Cos(angle)
                    targetY   = boomY + 600 * Sin(angle)
                    e         = AddSpecialEffect("Abilities\\Spells\\Other\\TalkToMe\\TalkToMe.mdl", targetX, targetY)
                    iteration = iteration + 1

                    EffectRemove(e, 10.0 + damageIteration * 0.1)
                end
                udg_MinerthaDamagePerSecond = udg_MinerthaDamagePerSecond + 3.0
                iteration                   = 1
                while iteration <= 36 do
                    distance  = GetRandomReal(0, 590.00)
                    angle     = GetRandomReal(0, 2 * bj_PI)
                    targetX   = boomX + distance * Cos(angle)
                    targetY   = boomY + distance * Sin(angle)
                    e         = AddSpecialEffect("Abilities\\Spells\\Other\\TalkToMe\\TalkToMe.mdl", targetX, targetY)
                    iteration = iteration + 1

                    EffectRemove(e, 10.0 + damageIteration * 0.1)
                end

                t  = CreateTimer()
                ht = GetHandleId(t)
                SaveReal(udg_hash, ht, StringHash("TargetX"), boomX)
                SaveReal(udg_hash, ht, StringHash("TargetY"), boomY)
                SaveUnitHandle(udg_hash, ht, StringHash("Damager"), GetEventDamageSource())

                TimerStart(t, 10.00 + damageIteration * 0.1, false, PlanetDamageExplosion)


                PingMinimapEx(boomX, boomY, 10.00, 64, 64, 255, false)
            end
            damageIteration = damageIteration + 1
        end
        SetUnitState(gg_unit_h008_0196, UNIT_STATE_MANA, udg_MinerthaDamageCounter)
    end

    --===========================================================================
    gg_trg_PlanetDamage = CreateTrigger()
    TriggerRegisterUnitEvent(gg_trg_PlanetDamage, gg_unit_h008_0196, EVENT_UNIT_DAMAGED)
    TriggerAddAction(gg_trg_PlanetDamage, Trig_PlanetDamage_Actions)
end)
if Debug then Debug.endFile() end
