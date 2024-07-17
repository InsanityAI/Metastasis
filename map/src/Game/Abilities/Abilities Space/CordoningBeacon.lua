if Debug then Debug.beginFile "Game/Abilities/Space/CordoningBeacon" end
OnInit.map("CordoningBeacon", function(require)
     --Spell by: FelFox
     -- Tripwire
     --Functions below are used for configuration of this spell.
     --Sidenote: I had to gut most of my own spell to make it work for Metastasis.
     ---@return integer
     function Cord_AbilCode()
          return FourCC('A07A')
          --The rawcode of the spell.
     end

     ---@return real
     function Cord_Damage()
          return 160.0
          --The damage the tripping unit takes.
     end

     ---@return real
     function Cord_CordDuration()
          return 2.0
          --The duration for which the unit that trips the wire lies on the ground.
     end

     ---@return string
     function Cord_LightningCode()
          return "AWES"
          --The lightning's code.
     end

     ---@return real
     function Cord_MaxDist()
          return 3100.0
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
     function Cord_RegionAddLineSeg(whichRegion, x1, y1, x2, y2)
          local dist  = SquareRoot((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)) ---@type real
          local xdist = x2 - x1 ---@type real
          local ydist = y2 - y1 ---@type real
          while not (x1 > x2 and xdist > 0) do
               if x2 > x1 and xdist < 0 then break end
               if y1 > y2 and ydist > 0 then break end
               if y2 > y1 and ydist < 0 then break end
               RegionAddCell(whichRegion, x1, y1)
               if dist == 0 then break end
               x1 = x1 + 16 * (xdist / dist)
               y1 = y1 + 16 * (ydist / dist)
          end
          --Function by Shvegait. [http://wc3jass.com/viewtopic.php?t=282]
     end

     ---@return boolean
     function Cord_AbilCheck()
          if GetSpellAbilityId() == Cord_AbilCode() then
               return true
          end
          return false
     end

     function CordPush_Determine()
          local k = GetExpiredTimer() ---@type timer
          local f = LoadUnitHandle(LS(), GetHandleId(k), StringHash("f")) ---@type unit
          local r = LoadLocationHandle(LS(), GetHandleId(k), StringHash("r")) ---@type location
          local b = GetUnitLoc(f) ---@type location
          FlushChildHashtable(LS(), GetHandleId(k))
          DestroyTimer(k)
          IssueImmediateOrder(f, "stop")
          PauseUnitForPeriod(f, 2)
          Push(f, 20, 10.0, AngleBetweenPoints(b, r))
          RemoveLocation(b)
          RemoveLocation(r)
          r = nil
          b = nil
          k = nil
     end

     function CordCollide()
          local targetone = LoadUnitHandle(LS(), GetHandleId(GetTriggeringTrigger()), StringHash("target1")) ---@type unit
          local targettwo = LoadUnitHandle(LS(), GetHandleId(GetTriggeringTrigger()), StringHash("target2")) ---@type unit
          --local hashtable h=LoadLightningHandle(LS(), GetHandleId(targettwo),StringHash("lightning"))
          local f         = GetTriggerUnit() ---@type unit
          local p         = LoadPlayerHandle(LS(), GetHandleId(GetTriggeringTrigger()), StringHash("wo")) ---@type player
          local k ---@type timer
          local r1        = GetUnitLoc(f) ---@type location
          local angle     = LoadReal(LS(), GetHandleId(GetTriggeringTrigger()), StringHash("angle")) ---@type real
          local startx    = LoadReal(LS(), GetHandleId(GetTriggeringTrigger()), StringHash("startx")) ---@type real
          local starty    = LoadReal(LS(), GetHandleId(GetTriggeringTrigger()), StringHash("starty")) ---@type real
          local pushangle ---@type real
          if GetUnitY(f) < (TanBJ(angle) * (GetUnitX(f) - startx) + starty) then
               pushangle = angle + 90
          else
               pushangle = angle - 90
          end
          if IsUnitExplorer(f) and GetUnitTypeId(f) ~= FourCC('h02Q') and GetUnitTypeId(f) ~= FourCC('h04E') then
               -- set k=CreateTimer()
               --call SaveUnitHandle(LS(),GetHandleId(k),StringHash("f"),f)
               --call SaveLocationHandle(LS(),GetHandleId(k),StringHash("r"),GetUnitLoc(f))
               --call TimerStart(k,0.01,false, function CordPush_Determine)
               IssueImmediateOrder(f, "stop")
               PauseUnitForPeriod(f, 1.5)
               Push(f, 200, 150.0, pushangle)
          end
          targetone = nil
          targettwo = nil
          f = nil
          p = nil
     end

     function CordDisable()
          local g         = LoadTriggerHandle(LS(), GetHandleId(GetTriggeringTrigger()), StringHash("t")) ---@type trigger
          local targetone = LoadUnitHandle(LS(), GetHandleId(g), StringHash("target1")) ---@type unit
          local targettwo = LoadUnitHandle(LS(), GetHandleId(g), StringHash("target2")) ---@type unit
          local h         = LoadHashtableHandle(LS(), GetHandleId(targettwo), StringHash("lightning")) ---@type hashtable
          DestroyTrigger(GetTriggeringTrigger())
          KillUnit(targetone)
          KillUnit(targettwo)
          RemoveRegion(LoadRegionHandle(LS(), GetHandleId(g), StringHash("region")))
          FlushChildHashtable(LS(), GetHandleId(GetTriggeringTrigger()))
          Delightningize(h)
          FlushParentHashtable(h)
          FlushChildHashtable(LS(), GetHandleId(targetone))
          FlushChildHashtable(LS(), GetHandleId(targettwo))
     end

     function CordAct2()
          local q              = GetSpellAbilityUnit() ---@type unit
          local targetone      = LoadUnitHandle(LS(), GetHandleId(q), StringHash("target1")) ---@type unit
          local targettwo      = CreateUnit(Player(15), FourCC('e024'), GetSpellTargetX(), GetSpellTargetY(),
               GetRandomDirectionDeg()) ---@type unit
          local a              = GetUnitLoc(targetone) ---@type location
          local b              = GetUnitLoc(targettwo) ---@type location
          local h              = InitHashtable() ---@type hashtable
          local Cordtrigger    = CreateTrigger() ---@type trigger
          local hitrect        = CreateRegion() ---@type region
          local disabletrigger = CreateTrigger() ---@type trigger
          local angle ---@type real
          local startx ---@type real
          local starty ---@type real
          if GetLocationX(a) < GetLocationX(b) then
               starty = GetLocationY(a)
               startx = GetLocationX(a)
               angle = AngleBetweenPoints(b, a)
          else
               startx = GetLocationX(b)
               starty = GetLocationY(b)
               angle = AngleBetweenPoints(a, b)
          end
          LightningizeLocs(Cord_LightningCode(), a, b, 500.0, h)
          RemoveLocation(a)
          RemoveLocation(b)
          a = nil
          b = nil
          TriggerRegisterUnitEvent(disabletrigger, targetone, EVENT_UNIT_DEATH)
          TriggerRegisterUnitEvent(disabletrigger, targettwo, EVENT_UNIT_DEATH)
          TriggerAddAction(disabletrigger, CordDisable)
          SaveTriggerHandle(LS(), GetHandleId(disabletrigger), StringHash("t"), Cordtrigger)
          Cord_RegionAddLineSeg(hitrect, GetUnitX(targettwo), GetUnitY(targettwo), GetUnitX(targetone),
               GetUnitY(targetone))
          SaveUnitHandle(LS(), GetHandleId(Cordtrigger), StringHash("target1"), targetone)
          SaveUnitHandle(LS(), GetHandleId(Cordtrigger), StringHash("target2"), targettwo)
          SaveReal(LS(), GetHandleId(Cordtrigger), StringHash("angle"), angle)
          SaveReal(LS(), GetHandleId(Cordtrigger), StringHash("startx"), startx)
          SaveReal(LS(), GetHandleId(Cordtrigger), StringHash("starty"), starty)
          SaveHashtableHandle(LS(), GetHandleId(targettwo), StringHash("lightning"), h)
          SaveUnitHandle(LS(), GetHandleId(q), StringHash("target1"), udg_TheNullUnit)
          SaveRegionHandle(LS(), GetHandleId(Cordtrigger), StringHash("region"), hitrect)
          SavePlayerHandle(LS(), GetHandleId(Cordtrigger), StringHash("wo"), GetOwningPlayer(GetSpellAbilityUnit()))
          TriggerAddAction(Cordtrigger, CordCollide)
          TriggerRegisterEnterRegion(Cordtrigger, hitrect, nil)
          Cordtrigger = nil
          hitrect = nil
     end

     function CordAct()
          local q         = GetSpellAbilityUnit() ---@type unit
          local targetone = CreateUnit(Player(15), FourCC('e024'), GetSpellTargetX(), GetSpellTargetY(),
               GetRandomDirectionDeg()) ---@type unit
          SaveUnitHandle(LS(), GetHandleId(q), StringHash("target1"), targetone)
     end

     function CordDirectAct()
          local v = LoadUnitHandle(LS(), GetHandleId(GetSpellAbilityUnit()), StringHash("target1")) ---@type unit
          local a = GetUnitLoc(v) ---@type location
          local b = GetSpellTargetLoc() ---@type location
          local o = GetOwningPlayer(GetSpellAbilityUnit()) ---@type player
          if o == Player(14) then
               o = udg_Parasite
          end
          if v == udg_TheNullUnit or v == nil then
               CordAct()
          else
               CordAct2()
          end
          RemoveLocation(a)
          RemoveLocation(b)
          a = nil
          b = nil
     end

     --===========================================================================

     gg_trg_CordoningBeacon = CreateTrigger()
     TriggerRegisterAnyUnitEventBJ(gg_trg_CordoningBeacon, EVENT_PLAYER_UNIT_SPELL_EFFECT)
     TriggerAddCondition(gg_trg_CordoningBeacon, Condition(Cord_AbilCheck))
     TriggerAddAction(gg_trg_CordoningBeacon, CordDirectAct)
end)
if Debug then Debug.endFile() end
