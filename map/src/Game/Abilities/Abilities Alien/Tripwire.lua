if Debug then Debug.beginFile "Game/Abilities/Alien/Tripwire" end
OnInit.map("Tripwire", function(require)
     --Spell by: FelFox
     -- Tripwire
     --Functions below are used for configuration of this spell.
     --Sidenote: I had to gut most of my own spell to make it work for Metastasis.
     ---@return integer
     function Trip_AbilCode()
          return FourCC('A05B')
          --The rawcode of the spell.
     end

     ---@return real
     function Trip_Damage()
          return 160.0
          --The damage the tripping unit takes.
     end

     ---@return real
     function Trip_TripDuration()
          return 2.0
          --The duration for which the unit that trips the wire lies on the ground.
     end

     ---@return string
     function Trip_LightningCode()
          return "DRAL"
          --The lightning's code.
     end

     ---@return real
     function Trip_MaxDist()
          return 900.0
          --Maximum distance between two trees that can be wired.
     end

     --Spell Engine
     --Do not edit beyond this point on pain of death.
     --
     --

     ---@param whichRegion region
     ---@param x1 real
     ---@param y1 real
     ---@param x2 real
     ---@param y2 real
     function Trip_RegionAddLineSeg(whichRegion, x1, y1, x2, y2)
          local dist  = SquareRoot((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)) ---@type real
          local xdist = x2 - x1 ---@type real
          local ydist = y2 - y1 ---@type real
          while not (x1 > x2 and xdist > 0) do
               if x2 > x1 and xdist < 0 then break end
               if y1 > y2 and ydist > 0 then break end
               if y2 > y1 and ydist < 0 then break end
               RegionAddCell(whichRegion, x1, y1)
               if dist == 0 then break end
               x1 = x1 + 32 * (xdist / dist)
               y1 = y1 + 32 * (ydist / dist)
          end
          --Function by Shvegait. [http://wc3jass.com/viewtopic.php?t=282]
     end

     ---@return boolean
     function Trip_AbilCheck()
          if GetSpellAbilityId() == Trip_AbilCode() then
               return true
          end
          return false
     end

     function TripCollide()
          local targetone = LoadUnitHandle(LS(), GetHandleId(GetTriggeringTrigger()), StringHash("target1")) ---@type unit
          local targettwo = LoadUnitHandle(LS(), GetHandleId(GetTriggeringTrigger()), StringHash("target2")) ---@type unit
          local d         = LoadLightningHandle(LS(), GetHandleId(targettwo), StringHash("lightning")) ---@type lightning
          local f         = GetTriggerUnit() ---@type unit
          local p         = LoadPlayerHandle(LS(), GetHandleId(GetTriggeringTrigger()), StringHash("wo")) ---@type player
          if GetUnitPointValue(f) ~= 37 and GetUnitState(f, UNIT_STATE_LIFE) > 0.00 and GetUnitAbilityLevel(f, FourCC('Avul')) == 0 and IsUnitType(f, UNIT_TYPE_MAGIC_IMMUNE) == false and udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(f))] == false and GetOwningPlayer(f) ~= Player(14) and GetOwningPlayer(f) ~= udg_Parasite and IsUnitType(f, UNIT_TYPE_FLYING) == false then
               UnitDamageTarget(udg_Playerhero[GetConvertedPlayerId(p)], f, Trip_Damage(), true, false,
                    ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
               PauseUnit(GetTriggerUnit(), true)
               SetUnitAnimation(GetTriggerUnit(), "death")
               KillUnit(targetone)
               PolledWait(Trip_TripDuration())
               PauseUnit(f, false)

               if GetUnitState(f, UNIT_STATE_LIFE) > 0.00 then
                    SetUnitAnimation(f, "stand")
               end
          end
          targetone = nil
          targettwo = nil
          f = nil
          d = nil
          p = nil
     end

     function TripDisable()
          local g         = LoadTriggerHandle(LS(), GetHandleId(GetTriggeringTrigger()), StringHash("t")) ---@type trigger
          local targetone = LoadUnitHandle(LS(), GetHandleId(g), StringHash("target1")) ---@type unit
          local targettwo = LoadUnitHandle(LS(), GetHandleId(g), StringHash("target2")) ---@type unit
          local d         = LoadLightningHandle(LS(), GetHandleId(targettwo), StringHash("lightning")) ---@type lightning
          DestroyTrigger(GetTriggeringTrigger())
          KillUnit(targetone)
          KillUnit(targettwo)
          RemoveRegion(LoadRegionHandle(LS(), GetHandleId(g), StringHash("region")))
          FlushChildHashtable(LS(), GetHandleId(GetTriggeringTrigger()))
          FlushChildHashtable(LS(), GetHandleId(d))
          DestroyLightning(d)
          FlushChildHashtable(LS(), GetHandleId(targetone))
          FlushChildHashtable(LS(), GetHandleId(targettwo))
     end

     function TripAct2()
          local q              = GetSpellAbilityUnit() ---@type unit
          local targetone      = LoadUnitHandle(LS(), GetHandleId(q), StringHash("target1")) ---@type unit
          local targettwo      = CreateUnit(Player(15), FourCC('e01B'), GetSpellTargetX(), GetSpellTargetY(),
               GetRandomDirectionDeg()) ---@type unit
          local a              = GetUnitLoc(targetone) ---@type location
          local b              = GetUnitLoc(targettwo) ---@type location
          local d              = AddLightningEx(Trip_LightningCode(), false, GetUnitX(targetone), GetUnitY(targetone),
               GetLocationZ(a) + 20.0, GetUnitX(targettwo), GetUnitY(targettwo), GetLocationZ(b) + 20.0) ---@type lightning
          local triptrigger    = CreateTrigger() ---@type trigger
          local hitrect        = CreateRegion() ---@type region
          local disabletrigger = CreateTrigger() ---@type trigger
          SaveBoolean(LS(), GetHandleId(d), StringHash("w"), true)
          RemoveLocation(a)
          RemoveLocation(b)
          a = nil
          b = nil
          TriggerRegisterUnitEvent(disabletrigger, targetone, EVENT_UNIT_DEATH)
          TriggerRegisterUnitEvent(disabletrigger, targettwo, EVENT_UNIT_DEATH)
          TriggerAddAction(disabletrigger, TripDisable)
          SaveTriggerHandle(LS(), GetHandleId(disabletrigger), StringHash("t"), triptrigger)
          Trip_RegionAddLineSeg(hitrect, GetUnitX(targettwo), GetUnitY(targettwo), GetUnitX(targetone),
               GetUnitY(targetone))
          SaveUnitHandle(LS(), GetHandleId(triptrigger), StringHash("target1"), targetone)
          SaveUnitHandle(LS(), GetHandleId(triptrigger), StringHash("target2"), targettwo)
          SaveLightningHandle(LS(), GetHandleId(targettwo), StringHash("lightning"), d)
          SaveUnitHandle(LS(), GetHandleId(q), StringHash("target1"), udg_TheNullUnit)
          SaveRegionHandle(LS(), GetHandleId(triptrigger), StringHash("region"), hitrect)
          SavePlayerHandle(LS(), GetHandleId(triptrigger), StringHash("wo"), GetOwningPlayer(GetSpellAbilityUnit()))
          TriggerAddAction(triptrigger, TripCollide)
          TriggerRegisterEnterRegion(triptrigger, hitrect, nil)
          triptrigger = nil
          hitrect = nil
          LoopDynamicLightningVisibility(d, GetUnitX(targetone), GetUnitY(targetone), GetUnitX(targettwo),
               GetUnitY(targettwo))
     end

     function TripAct()
          local q         = GetSpellAbilityUnit() ---@type unit
          local targetone = CreateUnit(Player(15), FourCC('e01B'), GetSpellTargetX(), GetSpellTargetY(),
               GetRandomDirectionDeg()) ---@type unit
          SaveUnitHandle(LS(), GetHandleId(q), StringHash("target1"), targetone)
     end

     function TripDirectAct()
          local v = LoadUnitHandle(LS(), GetHandleId(GetSpellAbilityUnit()), StringHash("target1")) ---@type unit
          local a = GetUnitLoc(v) ---@type location
          local b = GetSpellTargetLoc() ---@type location
          local o = GetOwningPlayer(GetSpellAbilityUnit()) ---@type player
          if o == Player(14) then
               o = udg_Parasite
          end
          if v == udg_TheNullUnit or v == nil then
               TripAct()
          elseif DistanceBetweenPoints(a, b) <= Trip_MaxDist() then
               TripAct2()
          else
               SetUnitState(GetSpellAbilityUnit(), UNIT_STATE_MANA,
                    GetUnitState(GetSpellAbilityUnit(), UNIT_STATE_MANA) + 15)
               DisplayTextToPlayer(o, 0.0, 0.0, "|cffffcc00The selected points are too far apart.")
               PingMinimapForPlayer(o, GetUnitX(v), GetUnitY(v), 4.0)
          end
          RemoveLocation(a)
          RemoveLocation(b)
          a = nil
          b = nil
     end

     --===========================================================================
     gg_trg_Tripwire = CreateTrigger()
     TriggerRegisterAnyUnitEventBJ(gg_trg_Tripwire, EVENT_PLAYER_UNIT_SPELL_EFFECT)
     TriggerAddCondition(gg_trg_Tripwire, Condition(Trip_AbilCheck))
     TriggerAddAction(gg_trg_Tripwire, TripDirectAct)
end)
if Debug then Debug.endFile() end
