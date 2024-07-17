if Debug then Debug.beginFile "Game/Abilities/Suits/DetonateSlivs" end
OnInit.trigggg("DetonateSlivs", function(require)
    ---@return boolean
    function Trig_DetonateSlivs_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A07S'))) then
            return false
        end
        return true
    end

    --Runs once for each unit inside
    function GetSlivGroupCount()
        udg_TempInt = udg_TempInt + 1
    end

    function Trig_DetonateSlivs_Actions()
        local a = GetSpellAbilityUnit() ---@type unit
        local magneticSlivedGroup ---@type group
        local pickedUnit ---@type unit
        local slivAttacks ---@type integer
        local o ---@type location

        if HaveSavedHandle(LS(), GetHandleId(a), StringHash("Suit_SlivGroup")) then
            magneticSlivedGroup = LoadGroupHandle(LS(), GetHandleId(a), StringHash("Suit_SlivGroup"))
        else
            return
        end

        udg_TempInt = 0
        ForGroup(magneticSlivedGroup, GetSlivGroupCount)

        --Loops and always gets the first of the unit group
        while true do
            --Exitwhen there are no iterations left
            if udg_TempInt == 0 then break end

            --Pick the unit for this loop (works by queue)
            pickedUnit = FirstOfGroup(magneticSlivedGroup)

            if HaveSavedInteger(LS(), GetHandleId(magneticSlivedGroup), GetHandleId(pickedUnit)) and IsUnitAliveBJ(pickedUnit) then
                --Play SFX on unit's location
                o = GetUnitLoc(pickedUnit)
                PlaySoundAtPointBJ(gg_snd_MeatwagonMissileHit1, 100, o, 0)
                RemoveLocation(o)

                --Get how many slivAttacks picked unit has taken
                slivAttacks = LoadInteger(LS(), GetHandleId(magneticSlivedGroup), GetHandleId(pickedUnit))
                --call SaveInteger(LS(),GetHandleId(a),StringHash(I2S(GetHandleId(d)) .. "_SlivsOn"),0)

                --/DEBUG//TODO REMOVE!
                --/call DisplayTextToForce(GetPlayersAll(), "The sliv attacks right before detonation are: ")
                --/call DisplayTextToForce(GetPlayersAll(), I2S(slivAttacks))

                --if 10 attacks (25*10=250), it becomes AoE
                --What it would do single-target - 150, and that 150 becomes AoE now.
                if slivAttacks > 9 then
                    UnitDamageTarget(a, pickedUnit, I2R(slivAttacks) * 25.0 - 150, true, false, ATTACK_TYPE_NORMAL,
                        DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
                    DamageAreaForPlayerTK(GetOwningPlayer(a), 250.0, 150, GetUnitX(pickedUnit), GetUnitY(pickedUnit))
                else --Single target dmg
                    UnitDamageTarget(a, pickedUnit, I2R(slivAttacks) * 25.0, true, false, ATTACK_TYPE_NORMAL,
                        DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
                end

                --Pure Special Effects (visual) below

                AddSpecialEffect("Objects\\Spawnmodels\\NightElf\\NightElfBlood\\NightElfBloodDruidBear.mdl",
                    GetUnitX(pickedUnit), GetUnitY(pickedUnit))
                SFXThreadClean()

                if not (IsUnitType(pickedUnit, UNIT_TYPE_TAUREN)) and not (IsUnitType(pickedUnit, UNIT_TYPE_STRUCTURE)) then
                    if slivAttacks > 3 then
                        AddSpecialEffect("Objects\\Spawnmodels\\Human\\HumanBlood\\BloodElfSpellThiefBlood.mdl",
                            GetUnitX(pickedUnit), GetUnitY(pickedUnit))
                        SFXThreadClean()
                    end

                    if slivAttacks > 5 then
                        AddSpecialEffect("Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl",
                            GetUnitX(pickedUnit), GetUnitY(pickedUnit))
                        SFXThreadClean()
                    end

                    if slivAttacks > 7 then
                        AddSpecialEffect(
                            "Objects\\Spawnmodels\\Undead\\UndeadLargeDeathExplode\\UndeadLargeDeathExplode.mdl",
                            GetUnitX(pickedUnit), GetUnitY(pickedUnit))
                        SFXThreadClean()
                    end

                    if slivAttacks > 9 then
                        AddSpecialEffect("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", GetUnitX(pickedUnit),
                            GetUnitY(pickedUnit))
                        SFXThreadClean()
                    end
                else
                    AddSpecialEffect("Objects\\Spawnmodels\\NightElf\\NECancelDeath\\NECancelDeath.mdl",
                        GetUnitX(pickedUnit), GetUnitY(pickedUnit))
                    SFXThreadClean()

                    if slivAttacks > 5 then
                        AddSpecialEffect("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", GetUnitX(pickedUnit),
                            GetUnitY(pickedUnit))
                        SFXThreadClean()
                    end
                end
                --Special Effects (visual) End
            end

            --Remove unit, so the next picked unit will not be the same ;)
            GroupRemoveUnit(magneticSlivedGroup, pickedUnit)

            udg_TempInt = udg_TempInt - 1
        end

        FlushChildHashtable(LS(), GetHandleId(magneticSlivedGroup))
        DestroyGroup(magneticSlivedGroup)
    end

    --===========================================================================
    gg_trg_DetonateSlivs = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_DetonateSlivs, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_DetonateSlivs, Condition(Trig_DetonateSlivs_Conditions))
    TriggerAddAction(gg_trg_DetonateSlivs, Trig_DetonateSlivs_Actions)
end)
if Debug then Debug.endFile() end
