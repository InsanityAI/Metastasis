if Debug then Debug.beginFile "Libraries/LS" end
OnInit.main("LS", function(require)
    udg_hash = InitHashtable() ---@type hashtable

    -- ===========================

    do
        LIBRARY_LS = true
        local SCOPE_PREFIX = "LS_" ---@type string
        ---@return hashtable
        function LS()
            --Returns hashtable for use in saving data to handles
            return udg_hash
        end
    end

    ---@return real
    function GetGameTime()
        return TimerGetElapsed(udg_GameTimer)
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    ---@param a player
    ---@return unit
    function GetPlayerhero(a)
        return udg_Playerhero[GetConvertedPlayerId(a)]
    end

    ---@param o unit
    ---@return unit
    function GetPlayerheroU(o)
        return udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(o))]
    end

    ---@param o unit
    ---@return boolean
    function IsUnitPlayerhero(o)
        return GetPlayerheroU(o) == o
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    ---@param a player
    ---@return boolean
    function IsPlayerAlien(a)
        --If players is main alien or spawn returns true.
        return udg_Parasite == a or udg_Player_IsParasiteSpawn[GetConvertedPlayerId(a)] or
            a == Player(bj_PLAYER_NEUTRAL_EXTRA)
    end

    ---@param a player
    ---@return boolean
    function IsPlayerMutant(a)
        --If players is main mutant or spawn returns true.
        return udg_Mutant == a or udg_Player_IsMutantSpawn[GetConvertedPlayerId(a)]
    end

    ---@param a player
    ---@return boolean
    function IsPlayerInfected(a)
        if IsPlayerAlien(a) or IsPlayerMutant(a) then
            return true
        else
            return false
        end
    end

    ---@param a player
    ---@return boolean
    function IsPlayerMainInfected(a)
        return udg_Parasite == a or udg_Mutant == a or a == Player(bj_PLAYER_NEUTRAL_EXTRA)
    end

    ---@param a player
    ---@return boolean
    function IsPlayerNonhuman(a)
        if IsPlayerAlien(a) or IsPlayerMutant(a) or udg_HiddenAndroid == a then
            return true
        else
            return false
        end
    end

    ---@param a player
    ---@return boolean
    function IsPlayerHuman(a)
        return not (IsPlayerNonhuman(a))
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    function CreateCTLRequirement()
        --Allows the temporal control alien to cast closed time-like loop 11 seconds after he is createed.
        PolledWait(11.0)
        CreateNUnitsAtLoc(1, FourCC('e00K'), Player(bj_PLAYER_NEUTRAL_EXTRA), udg_HoldZone, bj_UNIT_FACING)
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    ---@param t handle
    ---@param h string
    ---@param value integer
    function SetHandleInt(t, h, value)
        --Alias of SaveInteger, less work for my conversion from pre 1.24 to a post 1.24 world.
        SaveInteger(LS(), GetHandleId(t), StringHash(h), value)
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    function AddAbilityForPeriod_Remove()
        local o          = GetExpiredTimer() ---@type timer
        local a          = LoadUnitHandle(LS(), GetHandleId(o), StringHash("unit")) ---@type unit
        local theability = LoadInteger(LS(), GetHandleId(o), StringHash("Ability")) ---@type integer
        FlushChildHashtable(LS(), GetHandleId(o))
        DestroyTimer(o)
        o = nil
        UnitRemoveAbility(a, theability)
    end

    ---@param a unit
    ---@param theability integer
    ---@param duration real
    function UnitAddAbilityForPeriod(a, theability, duration)
        --This function will add an ability to a unit for a period so that if this function is called again while the unit has the ability
        --And adds it for another duration then only the later duration will remove the ability.
        --For example, if you wanted to code a grace period of invulnerability for 3 seconds but then had an ability that also made the caster
        --invulnerable and both were triggered, you should use this function so that as the grace period for invulnerability ends it does not
        --short circuit the invulnerable ability.
        local o = nil ---@type timer
        if HaveSavedHandle(LS(), GetHandleId(a), StringHash("AbilityTimed_Timer_" .. I2S(theability))) then
            o = LoadTimerHandle(LS(), GetHandleId(a), StringHash("AbilityTimed_Timer_" .. I2S(theability)))
        end
        if o ~= nil then
            if TimerGetRemaining(o) < duration then
                --If the ability is scheduled for removal at a later date than this addition will imply, we do nothing.
                --If not then we proceed regularly.
                TimerStart(o, duration, false, AddAbilityForPeriod_Remove)
            end
        else
            if GetUnitAbilityLevel(a, theability) >= 1 then
                return
            else
                o = CreateTimer()
                SaveInteger(LS(), GetHandleId(o), StringHash("Ability"), theability)
                SaveUnitHandle(LS(), GetHandleId(o), StringHash("unit"), a)
                SaveTimerHandle(LS(), GetHandleId(a), StringHash("AbilityTimed_Timer_" .. I2S(theability)), o)
                TimerStart(o, duration, false, AddAbilityForPeriod_Remove)
                UnitAddAbility(a, theability)
            end
        end
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////

    ---@param whichUnit unit
    ---@param cloneOwner player
    ---@param cloneX real
    ---@param cloneY real
    ---@param cloneFacing real
    ---@return unit
    function CloneUnit(whichUnit, cloneOwner, cloneX, cloneY, cloneFacing)
        --Abuses gamecaches to make a clone of unit, which restores inventories, health, etc. Used by masquerader.
        local clone ---@type unit
        local g = InitGameCache("CloneCache.w3v") ---@type gamecache
        --Clones a unit. Got this function from somewhere.
        StoreUnit(g, "clone", "clone", whichUnit)
        clone = RestoreUnit(g, "clone", "clone", cloneOwner, cloneX, cloneY, cloneFacing)
        SetUnitState(clone, UNIT_STATE_LIFE, GetUnitState(whichUnit, UNIT_STATE_LIFE))
        SetUnitState(clone, UNIT_STATE_MANA, GetUnitState(whichUnit, UNIT_STATE_MANA))
        FlushGameCache(g)
        g = nil
        return clone
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////

    function AlienRequirementRestore()
        --I realize that using temporary globals is not the prettiest way to pass arguments, but seeing as I'm lazy
        --And like the convenience of using GUI and JASS this will have to do.
        --This function restores an alien requirement to use an ability after TempReal seconds to TempPlayer of TempUnitType.
        --TempUnitType being the name of the unit type required for the ability to be cast.
        local a = udg_TempUnitType ---@type integer
        local b = udg_TempPlayer ---@type player
        local k = udg_TempReal ---@type real
        --Restores a requirement unit after k seconds.
        --Use ExecuteFunc to not steal thread focus
        PolledWait(k)
        CreateUnitAtLoc(b, a, udg_HoldZone, 270)
    end

    function AlienRequirementRemove_Child()
        RemoveUnit(GetEnumUnit())
    end

    function AlienRequirementRemove()
        local b = GetUnitsOfPlayerAndTypeId(udg_TempPlayer, udg_TempUnitType) ---@type group
        --Removes the requirements from tempplayer for the spell that needs tempunittype.
        ForGroup(b, AlienRequirementRemove_Child)
        DestroyGroup(b)
        b = nil
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////


    function ParseEnteredString()
        local r          = GetEventPlayerChatString() ---@type string
        local lasti      = 0 ---@type integer
        local i          = 0 ---@type integer
        local argumenton = 1 ---@type integer
        local k          = StringLength(r) ---@type integer
        local n ---@type integer
        --Divides an entered string into spaces. "-liquidate lightblue" becomes udg_arguments[0]=-liquidate and udg_arguments[1]=lightblue
        while i <= k do
            if SubString(r, i - 1, i) == " " then
                n = lasti - 1
                if n < 0 then
                    n = 0
                end
                udg_arguments[argumenton] = SubString(r, lasti - 1, i - 1)
                argumenton = argumenton + 1
                lasti = i + 1
            end
            i = i + 1
        end
        udg_arguments[argumenton] = SubString(r, lasti - 1, 999)
    end

    function ClearArguments()
        local i = 0 ---@type integer
        --Preps the arguments bank so that arguments from the last are not considered
        while i <= 100 do
            udg_arguments[i] = ""
            i = i + 1
        end
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////

    function MurderPart2()
        local a = udg_TempUnit ---@type unit
        local b = udg_TempPlayer ---@type player
        --Executes the MurderPart2 trigger after 4 seconds, preserving local data.
        --This hack brought to you by the Board of Hackery and Bad Code.
        PolledWait(1.1)
        udg_TempUnit = a
        udg_TempPlayer = b
        TriggerExecute(gg_trg_PlayerMurderPart2)
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////






    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    --Counter bars!


    ---@param k timer
    function DestroyBar(k)
        --Given a timer k, this will destroy the associated countdown bar.
        local a = LoadTextTagHandle(LS(), GetHandleId(k), StringHash("countdown")) ---@type texttag
        FlushChildHashtable(LS(), GetHandleId(a))
        FlushChildHashtable(LS(), GetHandleId(k))
        PauseTimer(k)
        DestroyTimer(k)
        ShowTextTagForceBJ(false, a, GetPlayersAll())
        DestroyTextTag(a)
    end

    ---@param a unit
    function DestroyUnitBar(a)
        --Destroys a countup bar given a unit a.
        if HaveSavedHandle(LS(), GetHandleId(a), StringHash("CountupTimer")) then
            DestroyBar(LoadTimerHandle(LS(), GetHandleId(a), StringHash("CountupTimer")))
        end
    end

    ---@param k timer
    function DestroyBarStop(k)
        --Destroys a bar and stops its endfunction from executing
        local a    = LoadTextTagHandle(LS(), GetHandleId(k), StringHash("countdown")) ---@type texttag
        local end_ = LoadTimerHandle(LS(), GetHandleId(k), StringHash("endtimer")) ---@type timer
        FlushChildHashtable(LS(), GetHandleId(a))
        FlushChildHashtable(LS(), GetHandleId(k))
        FlushChildHashtable(LS(), GetHandleId(end_))
        PauseTimer(end_)
        DestroyTimer(end_)
        PauseTimer(k)
        DestroyTimer(k)
        ShowTextTagForceBJ(false, a, GetPlayersAll())
        DestroyTextTag(a)
    end

    ---@param a unit
    function DestroyUnitBarStop(a)
        --Destroys a countup bar given a unit a.
        if HaveSavedHandle(LS(), GetHandleId(a), StringHash("CountupTimer")) then
            DestroyBarStop(LoadTimerHandle(LS(), GetHandleId(a), StringHash("CountupTimer")))
        end
    end

    function CountUpBar_Execute()
        --This uses a seperate timer to precisely execute the necessary function.
        local end_    = GetExpiredTimer() ---@type timer
        local k       = LoadTimerHandle(LS(), GetHandleId(end_), StringHash("k")) ---@type timer
        local whofor  = LoadUnitHandle(LS(), GetHandleId(end_), StringHash("whofor")) ---@type unit
        local endfunc = LoadStr(LS(), GetHandleId(end_), StringHash("endfunc")) ---@type string
        FlushChildHashtable(LS(), GetHandleId(end_))
        DestroyTimer(end_)
        DestroyBar(k)
        udg_CountupBarTemp = whofor
        ExecuteFunc(endfunc)
    end

    ---@param howmanybars integer
    ---@param whatunit unit
    ---@param interval real
    ---@param k timer
    ---@return texttag
    function AddCountdown(howmanybars, whatunit, interval, k)
        --Creates a text tag.
        local barcount = " " ---@type string
        local i        = 1 ---@type integer
        local a ---@type texttag
        local c        = GetUnitLoc(whatunit) ---@type location
        while i <= howmanybars do
            barcount = barcount .. "I"
            i = i + 1
        end
        CreateTextTagLocBJ(barcount, c, 0, 6, 100, 100, 100, 0)
        SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
        a = bj_lastCreatedTextTag
        SetTextTagFadepointBJ(a, howmanybars * interval)
        SetTextTagLifespanBJ(a, howmanybars * interval + 1)
        SaveTextTagHandle(LS(), GetHandleId(k), StringHash("countdown"), a)
        SaveInteger(LS(), GetHandleId(k), StringHash("progress"), 0)
        SaveInteger(LS(), GetHandleId(k), StringHash("barcount"), howmanybars)
        RemoveLocation(c)
        return a
    end

    ---@param k timer
    function AddBarProgress(k)
        --Updates a countup texttag.
        --Not sure why I coded things into so many seperate functions but I did.
        local a         = LoadTextTagHandle(LS(), GetHandleId(k), StringHash("countdown")) ---@type texttag
        local progress  = LoadInteger(LS(), GetHandleId(k), StringHash("progress")) ---@type integer
        local barcount  = LoadInteger(LS(), GetHandleId(k), StringHash("barcount")) ---@type integer
        local barstring = LoadStr(LS(), GetHandleId(k), StringHash("barcolor")) ---@type string
        local i         = 1 ---@type integer
        if barcount <= progress then
            DestroyBar(k)
        end
        while i <= progress do
            barstring = barstring .. "I"
            i = i + 1
        end
        barstring = barstring .. "|r"
        while i <= barcount do
            barstring = barstring .. "I"
            i = i + 1
        end
        SetTextTagTextBJ(a, barstring, 6.0)
        SaveInteger(LS(), GetHandleId(k), StringHash("progress"), progress + 1)
    end

    ---@param a texttag
    ---@param whatfunc string
    ---@param k timer
    function RegisterOnBarFull(a, whatfunc, k)
        SaveStr(LS(), GetHandleId(k), StringHash("onend"), whatfunc)
    end

    function BarCountUpLoop()
        --This is t he part that is called first every update.
        local a = LoadUnitHandle(LS(), GetHandleId(GetExpiredTimer()), StringHash("countuploop")) ---@type unit
        local t = LoadTextTagHandle(LS(), GetHandleId(GetExpiredTimer()), StringHash("countdown")) ---@type texttag
        SetTextTagPos(t, GetUnitX(a), GetUnitY(a), 0.00)
        AddBarProgress(GetExpiredTimer())
    end

    ---@param whofor unit
    ---@param howmanybars integer
    ---@param interval real
    ---@param endfunc string
    function CountUpBar(whofor, howmanybars, interval, endfunc)
        --Please note that because this uses a PolledWait for compatability that this function will time out code execution for its duration.
        --This is mostly a compatability thing.
        --udg_CountUpBarColor, a later introduction to this function, uses a global string variable to work now. If you don't se it before
        --calling this function you will have no control over the color of the bar.
        --If you set CountupBar_HideTempBool=true and provide a TempPlayerGroup with which not to show the text tag too this function will
        --handle that. But it will also destroy the player group that you pass it.
        local duration = I2R(howmanybars) * interval ---@type real
        local k        = CreateTimer() ---@type timer
        local end_     = CreateTimer() ---@type timer
        local a        = AddCountdown(howmanybars, whofor, interval, k) ---@type texttag
        SaveStr(LS(), GetHandleId(k), StringHash("barcolor"), udg_CountUpBarColor)
        SaveInteger(LS(), GetHandleId(k), StringHash("progress"), 1)
        RegisterOnBarFull(a, endfunc, k)
        SaveUnitHandle(LS(), GetHandleId(k), StringHash("countuploop"), whofor)
        TimerStart(k, interval, true, BarCountUpLoop)
        if udg_CountupBar_HideTempBool == true then
            udg_CountupBar_HideTempBool = false
            ShowTextTagForceBJ(false, a, udg_TempPlayerGroup)
            DestroyForce(udg_TempPlayerGroup)
        end
        SaveUnitHandle(LS(), GetHandleId(end_), StringHash("whofor"), whofor)
        SaveStr(LS(), GetHandleId(end_), StringHash("endfunc"), endfunc)
        SaveTimerHandle(LS(), GetHandleId(end_), StringHash("k"), k)
        SaveTimerHandle(LS(), GetHandleId(whofor), StringHash("CountupTimer"), k)
        SaveTextTagHandle(LS(), GetHandleId(k), StringHash("countdown"), a)
        SaveTimerHandle(LS(), GetHandleId(k), StringHash("end"), end_)
        TimerStart(end_, duration, false, CountUpBar_Execute)
        PolledWait(duration)
        udg_CountupBarTemp = whofor
        --PolledWait for compatibility with older versions
        --call FlushChildHashtable(LS(), GetHandleId(k))
        --call PauseTimer(k)
        --call DestroyTimer(k)
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    --This entire section below is basically the same as above but it dynamically checks for visibility to show the text tag.
    --If you notice, fusion bombs don't do this but landing ships do.
    --//////////////////////////////////////////////
    function CountdownBar_ShowLocal()
        if IsLocationVisibleToPlayer(udg_TempPoint, GetEnumPlayer()) then
            if GetLocalPlayer() == GetEnumPlayer() then
                SetTextTagVisibility(udg_TempTexttag, true)
            end
        else
            if GetLocalPlayer() == GetEnumPlayer() then
                SetTextTagVisibility(udg_TempTexttag, false)
            end
        end
    end

    ---@param k timer
    function DestroyBar_Local(k)
        local a = LoadTextTagHandle(LS(), GetHandleId(k), StringHash("countdown")) ---@type texttag
        FlushChildHashtable(LS(), GetHandleId(a))
        FlushChildHashtable(LS(), GetHandleId(k))
        PauseTimer(k)
        DestroyTimer(k)
        ShowTextTagForceBJ(false, a, GetPlayersAll())
        DestroyTextTag(a)
    end

    function CountUpBar_Execute_Local()
        local end_    = GetExpiredTimer() ---@type timer
        local k       = LoadTimerHandle(LS(), GetHandleId(end_), StringHash("k")) ---@type timer
        local whofor  = LoadUnitHandle(LS(), GetHandleId(end_), StringHash("whofor")) ---@type unit
        local endfunc = LoadStr(LS(), GetHandleId(end_), StringHash("endfunc")) ---@type string
        FlushChildHashtable(LS(), GetHandleId(end_))
        DestroyTimer(end_)
        DestroyBar_Local(k)
        udg_CountupBarTemp = whofor
        ExecuteFunc(endfunc)
    end

    ---@param howmanybars integer
    ---@param whatunit unit
    ---@param interval real
    ---@param k timer
    ---@return texttag
    function AddCountdown_Local(howmanybars, whatunit, interval, k)
        local barcount = " " ---@type string
        local i        = 1 ---@type integer
        local a ---@type texttag
        local c        = GetUnitLoc(whatunit) ---@type location
        while i <= howmanybars do
            barcount = barcount .. "I"
            i = i + 1
        end
        CreateTextTagLocBJ(barcount, c, 0, 6, 100, 100, 100, 0)
        SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
        a = bj_lastCreatedTextTag
        SetTextTagFadepointBJ(a, howmanybars * interval)
        SetTextTagLifespanBJ(a, howmanybars * interval .. 1)
        SaveTextTagHandle(LS(), GetHandleId(k), StringHash("countdown"), a)
        SaveInteger(LS(), GetHandleId(k), StringHash("progress"), 0)
        SaveInteger(LS(), GetHandleId(k), StringHash("barcount"), howmanybars)
        RemoveLocation(c)
        return a
    end

    ---@param k timer
    function AddBarProgress_Local(k)
        local a         = LoadTextTagHandle(LS(), GetHandleId(k), StringHash("countdown")) ---@type texttag
        local progress  = LoadInteger(LS(), GetHandleId(k), StringHash("progress")) ---@type integer
        local barcount  = LoadInteger(LS(), GetHandleId(k), StringHash("barcount")) ---@type integer
        local barstring = LoadStr(LS(), GetHandleId(k), StringHash("barcolor")) ---@type string
        local i         = 1 ---@type integer
        if barcount <= progress then
            DestroyBar(k)
        end
        while i <= progress do
            barstring = barstring .. "I"
            i = i + 1
        end
        barstring = barstring .. "|r"
        while i <= barcount do
            barstring = barstring .. "I"
            i = i + 1
        end
        SetTextTagTextBJ(a, barstring, 6.0)
        SaveInteger(LS(), GetHandleId(k), StringHash("progress"), progress + 1)
    end

    ---@param a texttag
    ---@param whatfunc string
    ---@param k timer
    function RegisterOnBarFull_Local(a, whatfunc, k)
        SaveStr(LS(), GetHandleId(k), StringHash("onend"), whatfunc)
    end

    function BarCountUpLoop_Local()
        local a         = LoadUnitHandle(LS(), GetHandleId(GetExpiredTimer()), StringHash("countuploop")) ---@type unit
        local t         = LoadTextTagHandle(LS(), GetHandleId(GetExpiredTimer()), StringHash("countdown")) ---@type texttag
        local n         = GetUnitLoc(a) ---@type location
        udg_TempPoint   = n
        udg_TempTexttag = t
        ForForce(GetPlayersAll(), CountdownBar_ShowLocal)
        RemoveLocation(n)
        SetTextTagPos(t, GetUnitX(a), GetUnitY(a), 0.00)
        AddBarProgress(GetExpiredTimer())
    end

    ---@param whofor unit
    ---@param howmanybars integer
    ---@param interval real
    ---@param endfunc string
    function CountUpBar_Local(whofor, howmanybars, interval, endfunc)
        local duration = I2R(howmanybars) * interval ---@type real
        local k        = CreateTimer() ---@type timer
        local lolz ---@type boolexpr
        local end_     = CreateTimer() ---@type timer
        local a        = AddCountdown(howmanybars, whofor, interval, k) ---@type texttag
        SaveStr(LS(), GetHandleId(k), StringHash("barcolor"), udg_CountUpBarColor)
        SaveInteger(LS(), GetHandleId(k), StringHash("progress"), 1)
        RegisterOnBarFull_Local(a, endfunc, k)
        SaveUnitHandle(LS(), GetHandleId(k), StringHash("countuploop"), whofor)
        TimerStart(k, interval, true, BarCountUpLoop_Local)
        if udg_CountupBar_HideTempBool == true then
            udg_CountupBar_HideTempBool = false
            ShowTextTagForceBJ(false, a, udg_TempPlayerGroup)
            DestroyForce(udg_TempPlayerGroup)
        end
        SaveUnitHandle(LS(), GetHandleId(end_), StringHash("whofor"), whofor)
        SaveStr(LS(), GetHandleId(end_), StringHash("endfunc"), endfunc)
        SaveTimerHandle(LS(), GetHandleId(end_), StringHash("k"), k)
        SaveTimerHandle(LS(), GetHandleId(whofor), StringHash("CountupTimer"), k)
        SaveTextTagHandle(LS(), GetHandleId(k), StringHash("countdown"), a)
        SaveTimerHandle(LS(), GetHandleId(k), StringHash("end"), end_)
        TimerStart(end_, duration, false, CountUpBar_Execute_Local)
        PolledWait(duration)
        udg_CountupBarTemp = whofor
        --PolledWait for compatibility with older versions
        --call FlushChildHashtable(LS(), GetHandleId(k))
        --call PauseTimer(k)
        --call DestroyTimer(k)
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    function BarLocal_RunDummy()
        --This function, used in conjunction with ExecuteFunc(), won't block thread execution.
        CountUpBar_Local(udg_TempUnit, udg_TempInt, udg_TempReal, udg_TempString)
    end

    --
    ----------------------------

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    --Various dummy functions to link JASS counter bars with GUI triggers.
    function MutantUpgrade()
        TriggerExecute(gg_trg_MutantUpgradeFinish)
    end

    function ParasiteUpgrade()
        TriggerExecute(gg_trg_ParasiteUpgradeFinish)
    end

    function FusionBombExplosion()
        TriggerExecute(gg_trg_FusionBombExplode)
    end

    function FusionBombExplosion2()
        TriggerExecute(gg_trg_ProjectedExplosionExplode)
    end

    function CarrierSackExplosion()
        TriggerExecute(gg_trg_CarrierSackExplode)
    end

    function TeleportBombExplosion()
        TriggerExecute(gg_trg_TeleportBombExplode)
    end

    function BlackHoleExplosion()
        TriggerExecute(gg_trg_BlackHoleExplode)
    end

    function TacNukeExplosion()
        TriggerExecute(gg_trg_TacticalNuclearExplosion)
    end

    function ShieldsGoUp()
        TriggerExecute(gg_trg_ShieldsUp)
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    --
    --From trial and error we have learned the ExecuteFunc("SFXClean") many times in a row
    --will disconnect the silly Macintosh users, a la planetary bombardment.
    --Thinking about it maybe these still disconnect silly Macintosh users?
    --Note that the stuff below just destroys the last created function after like 10 seconds.
    function SFXClean()
        local a = GetLastCreatedEffectBJ() ---@type effect
        PolledWait(10.0)
        DestroyEffect(a)
    end

    function CleanSFX()
        local a = GetLastCreatedEffectBJ() ---@type effect
        PolledWait(10.0)
        DestroyEffect(a)
    end

    function SFXClean2()
        local a = GetLastCreatedEffectBJ() ---@type effect
        PolledWait(0.5)
        DestroyEffect(a)
    end

    function SFXThreadClean_Child()
        local t = GetExpiredTimer() ---@type timer
        DestroyEffect(LoadEffectHandle(LS(), GetHandleId(t), StringHash("a")))
        FlushChildHashtable(LS(), GetHandleId(t))
        DestroyTimer(t)
    end

    function SFXThreadClean()
        --Uses a timer for thread safety.
        local a = GetLastCreatedEffectBJ() ---@type effect
        local t = CreateTimer() ---@type timer
        TimerStart(t, 10.0, false, SFXThreadClean_Child)
        SaveEffectHandle(LS(), GetHandleId(t), StringHash("a"), a)
    end

    function SFXThreadCleanTimed()
        --Uses a timer for thread safety.
        local a = GetLastCreatedEffectBJ() ---@type effect
        local t = CreateTimer() ---@type timer
        TimerStart(t, udg_TempReal, false, SFXThreadClean_Child)
        SaveEffectHandle(LS(), GetHandleId(t), StringHash("a"), a)
    end

    --
    --
    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    --
    function BombEndShaking()
        --This will stop shaking the camera after the player has viewed a fusion bomb.
        local a = udg_TempPlayer ---@type player
        PolledWait(3.00)
        CameraClearNoiseForPlayer(a)
    end

    function Remove2_CallBack()
        local t = GetExpiredTimer() ---@type timer
        local a = LoadUnitHandle(LS(), GetHandleId(t), StringHash("u")) ---@type unit
        FlushChildHashtable(LS(), GetHandleId(t))
        DestroyTimer(t)
        RemoveUnit(a)
    end

    function Remove2()
        local t = CreateTimer() ---@type timer
        --Removes a unit after like two seconds.
        local a = udg_TempUnit ---@type unit
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("u"), a)
        TimerStart(t, 2.0, false, Remove2_CallBack)
    end

    function Preserve4()
        --Preserves a unit as tempunit for 4 seconds.
        --Do not ExecuteFunc(), that would be pointless
        local a = udg_TempUnit ---@type unit
        PolledWait(4)
        udg_TempUnit = a
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    ---@param whichPlayer player
    ---@param duration real
    ---@param bmode blendmode
    ---@param tex string
    ---@param red0 real
    ---@param green0 real
    ---@param blue0 real
    ---@param trans0 real
    ---@param red1 real
    ---@param green1 real
    ---@param blue1 real
    ---@param trans1 real
    function CinematicFilterGenericForPlayer(whichPlayer, duration, bmode, tex, red0, green0, blue0, trans0, red1, green1,
                                             blue1, trans1)
        --A cinematic filter that can be used locally.
        if udg_Player_Blinded[GetConvertedPlayerId(whichPlayer)] ~= true then
            if (GetLocalPlayer() == whichPlayer) then
                SetCineFilterTexture(tex)
                SetCineFilterBlendMode(bmode)
                SetCineFilterTexMapFlags(TEXMAP_FLAG_NONE)
                SetCineFilterStartUV(0, 0, 1, 1)
                SetCineFilterEndUV(0, 0, 1, 1)
                SetCineFilterStartColor(PercentTo255(red0), PercentTo255(green0), PercentTo255(blue0),
                    PercentTo255(100 - trans0))
                SetCineFilterEndColor(PercentTo255(red1), PercentTo255(green1), PercentTo255(blue1),
                    PercentTo255(100 - trans1))
                SetCineFilterDuration(duration)
                DisplayCineFilter(true)
            end
        end
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////








    --/
    --/

    --Returns the number of the 'sector' of the map that the point is in.
    --Used to make sure units can't attack/damage nearby spaceships and the like.
    --Unsure of the performance hit, if any.
    --If a new sector is made then add that sector to this list.
    ---@param l location
    ---@return integer
    function GetSector(l)
        local x = 0 ---@type integer

        if RectContainsLoc(gg_rct_ST1, l) == true then
            x = 1
        elseif RectContainsLoc(gg_rct_ST2, l) == true then
            x = 2
        elseif RectContainsLoc(gg_rct_ST3, l) == true then
            x = 3
        elseif RectContainsLoc(gg_rct_ST4S2, l) == true then
            x = 4
        elseif RectContainsLoc(gg_rct_ST5, l) == true then
            x = 5
        elseif RectContainsLoc(gg_rct_LostStation, l) == true then
            x = 6
        elseif RectContainsLoc(gg_rct_PirateShip, l) == true then
            x = 7
        elseif RectContainsLoc(gg_rct_Planet, l) == true then
            x = 8
        elseif RectContainsLoc(gg_rct_SS1, l) == true then
            x = 9
        elseif RectContainsLoc(gg_rct_SS2, l) == true then
            x = 10
        elseif RectContainsLoc(gg_rct_SS3, l) == true then
            x = 11
        elseif RectContainsLoc(gg_rct_SS4, l) == true then
            x = 12
        elseif RectContainsLoc(gg_rct_SS5, l) == true then
            x = 13
        elseif RectContainsLoc(gg_rct_SS6, l) == true then
            x = 14
        elseif RectContainsLoc(gg_rct_SS7, l) == true then
            x = 15
        elseif RectContainsLoc(gg_rct_SS8, l) == true then
            x = 16
        elseif RectContainsLoc(gg_rct_SS9, l) == true then
            x = 17
        elseif RectContainsLoc(gg_rct_SS10, l) == true then
            x = 18
        elseif RectContainsLoc(gg_rct_SS11, l) == true then
            x = 19
        elseif RectContainsLoc(gg_rct_SS12, l) == true then
            x = 20
        elseif RectContainsLoc(gg_rct_Space, l) == true then
            x = 21
        elseif RectContainsLoc(gg_rct_MoonRect, l) == true then
            x = 22
        elseif RectContainsLoc(gg_rct_ST8, l) == true then
            x = 23
        elseif RectContainsLoc(gg_rct_ST9, l) == true then
            x = 24
        elseif RectContainsLoc(gg_rct_ST10, l) == true then
            x = 25
            --Would be sheepyship
            --elseif RectContainsLoc(gg_rct_ST13,l)==true then
            --set x=26
        elseif RectContainsLoc(gg_rct_OverlordRect, l) then
            x = 27
        elseif RectContainsLoc(gg_rct_Mirror_Arena, l) then
            x = 28
        end

        return x
    end

    ---@param a unit
    ---@return integer
    function GetUnitSector(a)
        local r ---@type integer
        local b = GetUnitLoc(a) ---@type location

        --Returns the sector of a unit
        r       = GetSector(b)
        RemoveLocation(b)
        b = nil
        return r
    end

    ---@param a location
    ---@param i integer
    ---@return boolean
    function LocInSector(a, i)
        --Checks if a loc is in a sector, given the sector's number.
        --Faster!
        if RectContainsLoc(udg_SectorId[i], a) then
            return true
        end
        return false
    end

    ---@param a unit
    ---@param i integer
    ---@return boolean
    function UnitInSector(a, i)
        local k = GetUnitLoc(a) ---@type location

        --Same thing as above but accepts a unit.
        if RectContainsLoc(udg_SectorId[i], k) then
            RemoveLocation(k)
            k = nil
            return true
        end

        RemoveLocation(k)
        k = nil
        return false
    end

    ---@param a unit
    ---@param i integer
    ---@return boolean
    function UnitInSectorLax(a, i)
        local k = GetUnitLoc(a) ---@type location

        --Same thing as above but returns true if the sector that the unit is in is contained within another sector. I.E. landed ships
        if RectContainsLoc(udg_SectorId[i], k) or (GetUnitAbilityLevel(udg_SS_Landed[GetUnitUserData(udg_Sector_Space[GetUnitSector(a)])], FourCC('A071')) == 1 and UnitInSector(udg_SS_Landed[GetUnitUserData(udg_Sector_Space[GetUnitSector(a)])], i)) then
            RemoveLocation(k)
            k = nil
            return true
        end
        RemoveLocation(k)
        k = nil
        return false
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    --/

    ---@param a unit
    ---@return boolean
    function IsUnitExplorer(a)
        --local integer k=GetUnitTypeId(a)
        --Returns true if the unit is an explorer class ship.
        --if k==FourCC('h03K') or k==FourCC('h001') or k==FourCC('h02k') or k==FourCC('h02I') or k==FourCC('h012') or k==FourCC('h02S') or k==FourCC('h03J') or k==FourCC('h002') or k==FourCC('h02L') or k==FourCC('h02H') or k==FourCC('h02Q') then
        --return true
        --else
        --return false
        --endif
        return GetUnitAbilityLevel(a, FourCC('A071')) == 1
    end

    ---@param a unit
    ---@return boolean
    function IsUnitSuit(a)
        --local integer k=GetUnitTypeId(a)
        --if k==FourCC('h02R') or k==FourCC('h00K') or k==FourCC('h00J') or k==FourCC('h00L') or k==FourCC('h00E') or k==FourCC('h03L') or k==FourCC('h02G') or k==FourCC('h00M') or k==FourCC('h03U') or k==FourCC('h024') or k==FourCC('h00F') or k==FourCC('h00D') or k==FourCC('h00N') or k==FourCC('h00C') or k==FourCC('h027') or k==FourCC('h00I') then
        --return true
        --else
        --return false
        --endif
        return GetUnitAbilityLevel(a, FourCC('A070')) == 1
    end

    ---@param a unit
    ---@return boolean
    function IsUnitStation(a)
        --local integer i=GetUnitTypeId(q)
        --if i==FourCC('h009') or i==FourCC('h003') or i==FourCC('h008') or i==FourCC('h007') or i==FourCC('h03T') or i==FourCC('h005') or i==FourCC('h00X') or i==FourCC('h02B') or i==FourCC('h040') or i==FourCC('h041') or i==FourCC('h042')  then
        --return true
        --else
        --return false
        --endif]
        return GetUnitAbilityLevel(a, FourCC('A072')) == 1
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    function PendUpgrade()
        local a = udg_TempUnit ---@type unit
        local q = udg_TempUnitType ---@type integer
        local b ---@type integer
        local k = udg_TempPlayer ---@type player
        local o ---@type unit
        --Waits for a good time to apply spawn upgrades. A good time is considered as when you are not in an escape pod.
        repeat
            PolledWait(1.0)
        until RectContainsUnit(gg_rct_Timeout, a) == false
        b = GetConvertedPlayerId(k)
        bj_forLoopBIndex = 1
        bj_forLoopBIndexEnd = 6
        while bj_forLoopBIndex <= bj_forLoopBIndexEnd do
            udg_TempItemArray[GetForLoopIndexB()] = UnitItemInSlotBJ(udg_Playerhero[b], GetForLoopIndexB())
            UnitRemoveItemFromSlotSwapped(GetForLoopIndexB(), udg_Playerhero[b])
            bj_forLoopBIndex = bj_forLoopBIndex + 1
        end
        --set k=GetOwningPlayer(a)
        o = ReplaceUnitBJ(a, q, bj_UNIT_STATE_METHOD_RELATIVE)
        udg_Playerhero[GetConvertedPlayerId(k)] = o
        bj_forLoopBIndex = 1
        bj_forLoopBIndexEnd = 6
        while bj_forLoopBIndex <= bj_forLoopBIndexEnd do
            UnitAddItemSwapped(udg_TempItemArray[GetForLoopIndexB()], o)
            udg_TempItemArray[GetForLoopIndexB()] = nil
            bj_forLoopBIndex = bj_forLoopBIndex + 1
        end
        SelectUnitForPlayerSingle(o, GetOwningPlayer(o))
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    function DoorResetLock()
        --Used in the engineer's role ability, DoorHack.
        --Opens and enables said door.
        local a         = udg_CountupBarTemp ---@type unit
        local k         = LoadDestructableHandle(LS(), GetHandleId(a), StringHash("kittens")) ---@type destructable
        udg_TempTrigger = LoadTriggerHandle(LS(), GetHandleId(k), StringHash("t1"))
        EnableTrigger(udg_TempTrigger)
        TriggerExecute(udg_TempTrigger)
        KillDestructable(LoadDestructableHandle(LS(), GetHandleId(udg_TempTrigger), StringHash("doorpath")))
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////

    ---@param l lightning
    ---@param startx real
    ---@param starty real
    ---@param endx real
    ---@param endy real
    function LoopDynamicLightningVisibility(l, startx, starty, endx, endy)
        local midx = (startx + endx) / 2.0 ---@type real
        local midy = (starty + endy) / 2.0 ---@type real
        local i ---@type integer
        local r    = GetHandleId(l) ---@type integer
        local k ---@type boolean
        --WC3's lightning system sucks in that if you want to have lightning that lasts a long time and is only visible if you are next to it,
        --The lightning will not show if you could not see its creation, or alternatively shows to everyone!
        --With this system, lightning will dynamically check visibility to see if players should see the lightning.
        --It hides the lightning with alpha!
        while not (LoadBoolean(LS(), GetHandleId(l), StringHash("w")) ~= true) do
            i = 0
            while i <= 11 do
                if IsVisibleToPlayer(startx, starty, Player(i)) or IsVisibleToPlayer(midx, midy, Player(i)) or IsVisibleToPlayer(endx, endy, Player(i)) then
                    if GetLocalPlayer() == Player(i) then
                        SetLightningColor(l, 1, 1, 1, 1)
                    end
                else
                    if GetLocalPlayer() == Player(i) then
                        SetLightningColor(l, 1, 1, 1, 0)
                    end
                end
                i = i + 1
            end
            PolledWait(0.2)
        end
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    ---@param achievement integer
    ---@param achiever player
    function AwardAchievement(achievement, achiever)
        SaveBoolean(LS(), GetHandleId(gg_trg_AchievementsInit),
            StringHash("Player_" .. I2S(GetConvertedPlayerId(achiever)) .. "_won_" .. I2S(achievement)), true)
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////

    function RubbleDestroy()
        if GetDestructableTypeId(GetEnumDestructable()) == FourCC('B003') or GetDestructableTypeId(GetEnumDestructable()) == FourCC('B007') then
            KillDestructable(GetEnumDestructable())
        end
    end

    function FleshGolemLoop()
        --The flesh golem crushes nearby rubble and this is the triggering for it.
        local a = udg_TempUnit ---@type unit
        local b ---@type location
        while not (IsUnitDeadBJ(a)) do
            b = GetUnitLoc(a)
            EnumDestructablesInCircleBJ(225.0, b, RubbleDestroy)
            RemoveLocation(b)
            PolledWait(0.1)
        end
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    --Not documenting this function since force shields are no longer in the game!
    --
    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    function BlockDamage_RemoveAbility()
        local t       = GetExpiredTimer() ---@type timer
        local blockee = LoadUnitHandle(LS(), GetHandleId(t), StringHash("blockee")) ---@type unit
        local o       = GetUnitState(blockee, UNIT_STATE_LIFE) ---@type real
        UnitRemoveAbility(blockee, FourCC('A05G'))
        SaveBoolean(LS(), GetHandleId(t), StringHash("DamageBlock_Thread"), false)
        SetUnitState(blockee, UNIT_STATE_LIFE, LoadReal(LS(), GetHandleId(t), StringHash("restore")) - (90000 - o))
        FlushChildHashtable(LS(), GetHandleId(t))
        DestroyTimer(t)
    end

    ---@param blockee unit
    ---@param amount real
    function BlockDamage(blockee, amount)
        --Blocks the damage a unit would recieve.
        --This needs to be executed before the damage happens, which is when AnyUnitIsDamaged triggers.
        local t = CreateTimer() ---@type timer
        local o = GetUnitState(blockee, UNIT_STATE_LIFE) ---@type real
        if not (HaveSavedBoolean(LS(), GetHandleId(blockee), StringHash("DamageBlock_Thread")) and LoadBoolean(LS(), GetHandleId(blockee), StringHash("DamageBlock_Thread"))) then
            SaveUnitHandle(LS(), GetHandleId(t), StringHash("blockee"), blockee)
            SaveBoolean(LS(), GetHandleId(t), StringHash("DamageBlock_Thread"), true)
            SaveReal(LS(), GetHandleId(t), StringHash("restore"), o + amount)
            UnitAddAbility(GetTriggerUnit(), FourCC('A05G'))
            SetUnitState(blockee, UNIT_STATE_LIFE, 90000)
            TimerStart(t, 0, false, BlockDamage_RemoveAbility)
        end
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    function RectOfDoom_Kill()
        KillUnit(GetEnumUnit())
    end

    ---@param r rect
    function RectOfDoom(r)
        --This keeps murdering everything in a dead ship or station for about five minutes.
        local i = 0 ---@type integer
        local g ---@type group
        while i <= 300 do
            i = i + 1
            PolledWait(1.0)
            g = GetUnitsInRectAll(r)
            ForGroup(g, RectOfDoom_Kill)
            DestroyGroup(g)
        end
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    --All of these are mostly obvious, and use straightforward linear gradients.
    function FadeUnitOverTime_Child()
        local t            = GetExpiredTimer() ---@type timer
        local alpha        = LoadReal(LS(), GetHandleId(t), StringHash("alpha")) ---@type real
        local alphaPerTick = LoadReal(LS(), GetHandleId(t), StringHash("alphaPerTick")) ---@type real
        local a            = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) ---@type unit
        SetUnitVertexColorBJ(a, 100, 100, 100, alpha + alphaPerTick)
        if alpha + alphaPerTick <= 0 then
            if LoadBoolean(LS(), GetHandleId(t), StringHash("remove")) then
                RemoveUnit(a)
            end
            PauseTimer(t)
            DestroyTimer(t)
            FlushChildHashtable(LS(), GetHandleId(t))
            return
        end
        SaveReal(LS(), GetHandleId(t), StringHash("alpha"), alpha + alphaPerTick)
    end

    ---@param a unit
    ---@param duration real
    ---@param remove boolean
    function FadeUnitOverTime(a, duration, remove)
        local t = CreateTimer() ---@type timer
        SaveReal(LS(), GetHandleId(t), StringHash("alpha"), 100)
        SaveReal(LS(), GetHandleId(t), StringHash("alphaPerTick"), -100 / (duration / 0.04))
        SaveBoolean(LS(), GetHandleId(t), StringHash("remove"), remove)
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), a)
        TimerStart(t, 0.04, true, FadeUnitOverTime_Child)
    end

    function TintUnitOverTime_Child()
        local t            = GetExpiredTimer() ---@type timer
        local red          = LoadReal(LS(), GetHandleId(t), StringHash("red")) ---@type real
        local green        = LoadReal(LS(), GetHandleId(t), StringHash("green")) ---@type real
        local blue         = LoadReal(LS(), GetHandleId(t), StringHash("blue")) ---@type real
        local redPerTick   = LoadReal(LS(), GetHandleId(t), StringHash("redPerTick")) ---@type real
        local greenPerTick = LoadReal(LS(), GetHandleId(t), StringHash("greenPerTick")) ---@type real
        local bluePerTick  = LoadReal(LS(), GetHandleId(t), StringHash("bluePerTick")) ---@type real
        local a            = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) ---@type unit
        local duration     = LoadReal(LS(), GetHandleId(t), StringHash("duration")) ---@type real
        local elapsed      = LoadReal(LS(), GetHandleId(t), StringHash("elapsed")) ---@type real
        SetUnitVertexColor(a, R2I(red + redPerTick), R2I(green + greenPerTick), R2I(blue + bluePerTick), 255)
        if elapsed >= duration then
            PauseTimer(t)
            DestroyTimer(t)
            FlushChildHashtable(LS(), GetHandleId(t))
            return
        end
        SaveReal(LS(), GetHandleId(t), StringHash("elapsed"), elapsed + 0.1)
        SaveReal(LS(), GetHandleId(t), StringHash("green"), green + greenPerTick)
        SaveReal(LS(), GetHandleId(t), StringHash("blue"), blue + bluePerTick)
        SaveReal(LS(), GetHandleId(t), StringHash("red"), red + redPerTick)
    end

    ---@param a unit
    ---@param duration real
    ---@param red integer
    ---@param green integer
    ---@param blue integer
    function TintUnitOverTime(a, duration, red, green, blue)
        local t = CreateTimer() ---@type timer
        SaveReal(LS(), GetHandleId(t), StringHash("red"), 255)
        SaveReal(LS(), GetHandleId(t), StringHash("green"), 255)
        SaveReal(LS(), GetHandleId(t), StringHash("blue"), 255)
        SaveReal(LS(), GetHandleId(t), StringHash("greenPerTick"), (green - 255) / (duration / 0.10))
        SaveReal(LS(), GetHandleId(t), StringHash("bluePerTick"), (blue - 255) / (duration / 0.10))
        SaveReal(LS(), GetHandleId(t), StringHash("redPerTick"), (red - 255) / (duration / 0.10))
        SaveReal(LS(), GetHandleId(t), StringHash("duration"), duration)
        SaveReal(LS(), GetHandleId(t), StringHash("elapsed"), 0)
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), a)
        TimerStart(t, 0.10, true, TintUnitOverTime_Child)
    end

    function SizeUnitOverTime_Child()
        local t           = GetExpiredTimer() ---@type timer
        local startsize   = LoadReal(LS(), GetHandleId(t), StringHash("startsize")) ---@type real
        local sizePerTick = LoadReal(LS(), GetHandleId(t), StringHash("sizePerTick")) ---@type real
        local a           = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) ---@type unit
        SetUnitScale(a, startsize + sizePerTick, startsize + sizePerTick, startsize + sizePerTick)
        if sizePerTick > 0 then
            if startsize + sizePerTick >= LoadReal(LS(), GetHandleId(t), StringHash("endsize")) then
                if LoadBoolean(LS(), GetHandleId(t), StringHash("remove")) then
                    RemoveUnit(a)
                end
                PauseTimer(t)
                DestroyTimer(t)
                FlushChildHashtable(LS(), GetHandleId(t))
                return
            end
        else
            if startsize + sizePerTick <= LoadReal(LS(), GetHandleId(t), StringHash("endsize")) then
                if LoadBoolean(LS(), GetHandleId(t), StringHash("remove")) then
                    RemoveUnit(a)
                end
                PauseTimer(t)
                DestroyTimer(t)
                FlushChildHashtable(LS(), GetHandleId(t))
                return
            end
        end
        SaveReal(LS(), GetHandleId(t), StringHash("startsize"), startsize + sizePerTick)
    end

    ---@param a unit
    ---@param duration real
    ---@param startsize real
    ---@param endsize real
    ---@param remove boolean
    function SizeUnitOverTime(a, duration, startsize, endsize, remove)
        --Sadly this function cannot get a unit's default size.
        local t = CreateTimer() ---@type timer
        SaveReal(LS(), GetHandleId(t), StringHash("startsize"), startsize)
        SaveReal(LS(), GetHandleId(t), StringHash("endsize"), endsize)
        SaveReal(LS(), GetHandleId(t), StringHash("sizePerTick"), (endsize - startsize) / (duration / 0.04))
        SaveBoolean(LS(), GetHandleId(t), StringHash("remove"), remove)
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), a)
        TimerStart(t, 0.04, true, SizeUnitOverTime_Child)
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////




    function DamageUnitOverTime_Child()
        local t       = GetExpiredTimer() ---@type timer
        local damage  = LoadReal(LS(), GetHandleId(t), StringHash("damage")) ---@type real
        local a       = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) ---@type unit
        local damager = LoadUnitHandle(LS(), GetHandleId(t), StringHash("damager")) ---@type unit
        UnitDamageTarget(damager, a, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
    end

    function DamageUnitOverTime_End()
        local o = GetExpiredTimer() ---@type timer
        local t = LoadTimerHandle(LS(), GetHandleId(o), StringHash("timer")) ---@type timer
        FlushChildHashtable(LS(), GetHandleId(t))
        FlushChildHashtable(LS(), GetHandleId(o))
        PauseTimer(t)
        DestroyTimer(t)
        DestroyTimer(o)
    end

    ---@param target unit
    ---@param damager unit
    ---@param duration real
    ---@param damage real
    function DamageUnitOverTime(target, damager, duration, damage)
        local t = CreateTimer() ---@type timer
        local o = CreateTimer() ---@type timer
        --Used in the Kyo cannon's hit.
        SaveReal(LS(), GetHandleId(t), StringHash("damage"), damage / duration / 25)
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), target)
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("damager"), damager)
        SaveTimerHandle(LS(), GetHandleId(o), StringHash("timer"), t)
        TimerStart(t, 0.04, true, DamageUnitOverTime_Child)
        TimerStart(o, duration, false, DamageUnitOverTime_End)
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////




    ---@param p player
    ---@return boolean
    function Player_IsDead(p)
        return IsPlayerInForce(p, udg_DeadGroup)
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////

    --Tiny push library
    --Only for SPEHSS.
    --As in, it won't work if the unit goes outside the space region.
    --Literally.
    --Don't try.
    function Push_Move()
        local k     = GetExpiredTimer() ---@type timer
        local a     = LoadUnitHandle(LS(), GetHandleId(k), StringHash("pushlibrary_unit")) ---@type unit
        local dps   = LoadReal(LS(), GetHandleId(k), StringHash("dps")) ---@type real
        local angle = LoadReal(LS(), GetHandleId(k), StringHash("angle")) ---@type real
        local decay = LoadReal(LS(), GetHandleId(k), StringHash("decay")) ---@type real
        local x     = GetUnitX(a) + dps * Cos(angle * bj_DEGTORAD) // 25.0 ---@type real
        local y     = GetUnitY(a) + dps * Sin(angle * bj_DEGTORAD) / 25.0 ---@type real
        if dps <= 0.0 then
            FlushChildHashtable(LS(), GetHandleId(k))
            PauseTimer(k)
            DestroyTimer(k)
            return
        end
        if RectContainsCoords(gg_rct_Space, x, y) then
            if GetUnitMoveSpeed(a) == 0.0 then
                SetUnitPosition(a, x, y)
            else
                SetUnitX(a, x)
                SetUnitY(a, y)
            end
        end
        SaveReal(LS(), GetHandleId(k), StringHash("dps"), dps - decay / 25.0)
    end

    ---@param a unit
    ---@param dps real
    ---@param decay real
    ---@param angle real
    function Push(a, dps, decay, angle)
        local k = CreateTimer() ---@type timer
        SaveUnitHandle(LS(), GetHandleId(k), StringHash("pushlibrary_unit"), a)
        TimerStart(k, 0.04, true, Push_Move)
        SaveReal(LS(), GetHandleId(k), StringHash("angle"), angle)
        SaveReal(LS(), GetHandleId(k), StringHash("dps"), dps)
        SaveReal(LS(), GetHandleId(k), StringHash("decay"), decay)
    end

    --//////////
    --This push can be used in stations and has pathing
    --Scaled by unit's mass index, which is saved in the UnitCustomData init trigger.
    --Default for a non-registered unit is 100.
    function Push2_Move()
        local k      = GetExpiredTimer() ---@type timer
        local a      = LoadUnitHandle(LS(), GetHandleId(k), StringHash("pushlibrary_unit")) ---@type unit
        local dps    = LoadReal(LS(), GetHandleId(k), StringHash("dps")) ---@type real
        local angle  = LoadReal(LS(), GetHandleId(k), StringHash("angle")) ---@type real
        local decay  = LoadReal(LS(), GetHandleId(k), StringHash("decay")) ---@type real
        local x      = GetUnitX(a) + dps * Cos(angle * bj_DEGTORAD) // 50.0 ---@type real
        local y      = GetUnitY(a) + dps * Sin(angle * bj_DEGTORAD) / 50.0 ---@type real
        local b      = Location(x, y) ---@type location
        local height = GetLocationZ(b) ---@type real
        local hay ---@type real
        RemoveLocation(b)
        b = nil
        b = GetUnitLoc(a)
        hay = GetLocationZ(b)
        RemoveLocation(b)
        b = nil
        if dps <= 0.0 then
            FlushChildHashtable(LS(), GetHandleId(k))
            PauseTimer(k)
            DestroyTimer(k)
            return
        end
        if IsPointPathable(x, y, false) and height <= hay + 20.0 and GetTerrainCliffLevel(GetUnitX(a), GetUnitY(a)) == GetTerrainCliffLevel(x, y) then
            if GetUnitMoveSpeed(a) == 0.0 then
                SetUnitPosition(a, x, y)
            else
                SetUnitX(a, x)
                SetUnitY(a, y)
            end
        end
        SaveReal(LS(), GetHandleId(k), StringHash("dps"), dps - decay / 50.0)
    end

    ---@param a unit
    ---@param dps real
    ---@param decay real
    ---@param angle real
    function Push2(a, dps, decay, angle)
        local k = CreateTimer() ---@type timer
        SaveUnitHandle(LS(), GetHandleId(k), StringHash("pushlibrary_unit"), a)
        TimerStart(k, 0.02, true, Push2_Move)
        SaveReal(LS(), GetHandleId(k), StringHash("angle"), angle)
        SaveReal(LS(), GetHandleId(k), StringHash("dps"), dps * 100 / GetUnitMass(a))
        SaveReal(LS(), GetHandleId(k), StringHash("decay"), decay)
    end

    --This one uses SetUnitPosition instead of SetUnitX
    --Its original purpose, of being used for units with 0 move speed, is obsolete. However you may still want to use this for
    --making a unit unable to move while being pushed.
    function Push3_Move()
        local k     = GetExpiredTimer() ---@type timer
        local a     = LoadUnitHandle(LS(), GetHandleId(k), StringHash("pushlibrary_unit")) ---@type unit
        local dps   = LoadReal(LS(), GetHandleId(k), StringHash("dps")) ---@type real
        local angle = LoadReal(LS(), GetHandleId(k), StringHash("angle")) ---@type real
        local decay = LoadReal(LS(), GetHandleId(k), StringHash("decay")) ---@type real
        local x     = GetUnitX(a) + dps * Cos(angle * bj_DEGTORAD) // 25.0 ---@type real
        local y     = GetUnitY(a) + dps * Sin(angle * bj_DEGTORAD) / 25.0 ---@type real
        if dps <= 0.0 then
            FlushChildHashtable(LS(), GetHandleId(k))
            PauseTimer(k)
            DestroyTimer(k)
            return
        end
        if RectContainsCoords(gg_rct_Space, x, y) then
            SetUnitPosition(a, x, y)
        end
        SaveReal(LS(), GetHandleId(k), StringHash("dps"), dps - decay / 25.0)
    end

    ---@param a unit
    ---@param dps real
    ---@param decay real
    ---@param angle real
    function Push3(a, dps, decay, angle)
        local k = CreateTimer() ---@type timer
        SaveUnitHandle(LS(), GetHandleId(k), StringHash("pushlibrary_unit"), a)
        TimerStart(k, 0.04, true, Push3_Move)
        SaveReal(LS(), GetHandleId(k), StringHash("angle"), angle)
        SaveReal(LS(), GetHandleId(k), StringHash("dps"), dps)
        SaveReal(LS(), GetHandleId(k), StringHash("decay"), decay)
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////

    --///

    --///////////
    function SunLoop_Blind()
        if GetEnumUnit() == GetPlayerheroU(GetEnumUnit()) then
            CinematicFilterGenericForPlayer(GetOwningPlayer(GetEnumUnit()), 7.0, BLEND_MODE_BLEND,
                "ReplaceableTextures\\CameraMasks\\White_mask.blp", 100, 100, 100, udg_TempReal / 9, 0, 0, 0, 100)
        end
    end

    ---@param a unit
    function SunLoop(a)
        local sun = gg_unit_h01A_0197 ---@type unit
        local q ---@type location
        local b ---@type location
        local r ---@type real
        local om  = udg_SpaceObject_Rect[GetUnitUserData(a)] ---@type rect
        local g ---@type group
        while true do
            q = GetUnitLoc(a)
            b = GetUnitLoc(sun)
            r = DistanceBetweenPoints(q, b)
            RemoveLocation(q)
            RemoveLocation(b)
            if r > 850 then break end
            UnitDamageTarget(sun, a, udg_SunDamage * (850 - r), false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL,
                WEAPON_TYPE_WHOKNOWS)
            if om ~= nil then
                g = GetUnitsInRectAll(om)
                udg_TempReal = r
                ForGroup(g, SunLoop_Blind)
                DestroyGroup(g)
            end
            PolledWait(1.0)
        end
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////

    ---@param a unit
    ---@param b unit
    ---@return real
    function AngleBetweenUnits(a, b)
        --local location c=GetUnitLoc(a)
        --local location d=GetUnitLoc(b)
        --local real r=AngleBetweenPoints(c,d)
        --call RemoveLocation(c)
        --set c=null
        --call RemoveLocation(d)
        --set d=null
        --return r
        return bj_RADTODEG * Atan2(GetUnitY(b) - GetUnitY(a), GetUnitX(b) - GetUnitX(a))
    end

    ---@param unitA unit
    ---@param unitB unit
    ---@return real
    function DistanceBetweenUnits(unitA, unitB)
        return SquareRoot((GetUnitX(unitB) - GetUnitX(unitA)) * (GetUnitX(unitB) - GetUnitX(unitA)) +
            (GetUnitY(unitB) - GetUnitY(unitA)) * (GetUnitY(unitB) - GetUnitY(unitA)))
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    function DefilerGoo_Create()
        local k = GetExpiredTimer() ---@type timer
        local a = LoadUnitHandle(LS(), GetHandleId(k), StringHash("a")) ---@type unit
        local b ---@type location
        local r = LoadRegionHandle(LS(), GetHandleId(k), StringHash("r")) ---@type region
        local q ---@type rect
        if Player_IsDead(GetOwningPlayer(a)) then
            PauseTimer(k)
            FlushChildHashtable(LS(), GetHandleId(k))
            RemoveRegion(r)
            DestroyTimer(k)
        else
            b = GetUnitLoc(a)
            if not (IsLocationInRegion(r, b)) then
                AddSpecialEffectLoc("Abilities\\Spells\\NightElf\\MoonWell\\MoonWellTarget.mdl", b)
                q = Rect(GetLocationX(b) - 20.0, GetLocationY(b) - 20.0, GetLocationX(b) + 20.0, GetLocationY(b) + 20.0)
                RegionAddRect(r, q)
                RemoveRect(q)
                q = nil
            end
            RemoveLocation(b)
            b = nil
        end
    end

    function DefilerGoo_UnDamage()
        SaveBoolean(LS(), GetHandleId(GetTriggerUnit()), StringHash("DefilerGoo_Thread"), true)
    end

    function DefilerGoo_Damage()
        local r = LoadRegionHandle(LS(), GetHandleId(GetTriggeringTrigger()), StringHash("r")) ---@type region
        local b = GetTriggerUnit() ---@type unit
        local m ---@type boolean
        if not (HaveSavedBoolean(LS(), GetHandleId(b), StringHash("DefilerGoo_Thread"))) then
            m = true
        else
            m = LoadBoolean(LS(), GetHandleId(b), StringHash("DefilerGoo_Thread"))
        end
        if m and not (IsPlayerMutant(GetOwningPlayer(b))) then
            SaveBoolean(LS(), GetHandleId(b), StringHash("DefilerGoo_Thread"), true)
            while not (IsUnitInRegion(r, b) == false) do
                UnitDamageTarget(b, b, 10.0, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
                PolledWait(0.5)
            end
        end
    end

    function DefilerGoo()
        local a = GetLastCreatedUnit() ---@type unit
        local k = CreateTimer() ---@type timer
        local r = CreateRegion() ---@type region
        local b = CreateTrigger() ---@type trigger
        local c = CreateTrigger() ---@type trigger
        SaveUnitHandle(LS(), GetHandleId(k), StringHash("a"), a)
        SaveRegionHandle(LS(), GetHandleId(b), StringHash("r"), r)
        SaveRegionHandle(LS(), GetHandleId(k), StringHash("r"), r)
        TimerStart(k, 0.1, true, DefilerGoo_Create)
        TriggerRegisterEnterRegionSimple(b, r)
        TriggerAddAction(b, DefilerGoo_Damage)
        TriggerRegisterLeaveRegionSimple(b, r)
        TriggerAddAction(b, DefilerGoo_UnDamage)
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    ---@return boolean
    function HostileSpaceAI_Cond()
        if GetOwningPlayer(GetFilterUnit()) ~= Player(PLAYER_NEUTRAL_AGGRESSIVE) and IsUnitAliveBJ(GetFilterUnit()) then
            return true
        end
        return false
    end

    ---@param a unit
    function HostileSpaceAI(a)
        --Will break thread execution!
        --Use below function to circumvent this.
        --Basic AI is to just attack towards units in space. Will not attack Minertha until everything else is dead.
        local g ---@type group
        local o ---@type location

        while not (IsUnitDeadBJ(a)) do
            o = GetUnitLoc(a)
            g = GetUnitsInRectMatching(gg_rct_Space, Condition(HostileSpaceAI_Cond))
            RemoveLocation(o)

            o = GetUnitLoc(FirstOfGroup(g))
            IssuePointOrderLoc(a, "attack", o)
            RemoveLocation(o)
            DestroyGroup(g)

            PolledWait(10.0)
        end
    end

    function HostileSpaceAIForTempUnit()
        --For continued thread execution.
        HostileSpaceAI(udg_TempUnit)
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    ---@param toplay sound
    ---@param playfor player
    function PlaySoundForPlayer(toplay, playfor)
        if GetLocalPlayer() == playfor then
            StartSound(toplay)
        end
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////



    function PauseUnitForPeriod_Remove()
        local o = GetExpiredTimer() ---@type timer
        local a = LoadUnitHandle(LS(), GetHandleId(o), StringHash("unit")) ---@type unit
        FlushChildHashtable(LS(), GetHandleId(o))
        SaveTimerHandle(LS(), GetHandleId(a), StringHash("PauseTimed_Timer"), nil)
        DestroyTimer(o)
        o = nil
        PauseUnit(a, false)
    end

    ---@param a unit
    ---@param duration real
    function PauseUnitForPeriod(a, duration)
        --This ability is like UnitAddAbilityForPeriod, but instead of adding an ability it pauses the unit.
        local o = nil ---@type timer
        o       = LoadTimerHandle(LS(), GetHandleId(a), StringHash("PauseTimed_Timer"))
        if o ~= nil and HaveSavedHandle(LS(), GetHandleId(a), StringHash("PauseTimed_Timer")) then
            if TimerGetRemaining(o) < duration then
                --If the ability is scheduled for removal at a later date than this addition will imply, we do nothing.
                --If not then we proceed regularly.
                TimerStart(o, duration, false, PauseUnitForPeriod_Remove)
            end
        else
            o = CreateTimer()
            SaveUnitHandle(LS(), GetHandleId(o), StringHash("unit"), a)
            SaveTimerHandle(LS(), GetHandleId(a), StringHash("PauseTimed_Timer"), o)
            TimerStart(o, duration, false, PauseUnitForPeriod_Remove)
            PauseUnit(a, true)
        end
    end

    ---@param a unit
    function RemoveUnitPeriodPause(a)
        local o = nil ---@type timer
        o       = LoadTimerHandle(LS(), GetHandleId(a), StringHash("PauseTimed_Timer"))
        if o ~= nil and HaveSavedHandle(LS(), GetHandleId(a), StringHash("PauseTimed_Timer")) then
            FlushChildHashtable(LS(), GetHandleId(o))
            DestroyTimer(o)
        end
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////




    ---@param sluggly unit
    function SlugglyAssassin(sluggly)
        --Part of the amusing but mostly impossible black hole secret.
        local g ---@type group
        local o ---@type unit
        local r = udg_SectorId[GetUnitSector(sluggly)] ---@type rect
        UnitAddAbility(sluggly, FourCC('AInv'))
        UnitAddItemByIdSwapped(FourCC('I00N'), sluggly)
        UnitAddItemByIdSwapped(FourCC('I00R'), sluggly)
        UnitAddAbility(sluggly, FourCC('A03U'))
        UnitAddAbilityBJ(FourCC('A02I'), sluggly)
        UnitAddAbilityBJ(FourCC('AIl2'), sluggly)
        while not (IsUnitAliveBJ(sluggly) == false) do
            g = GetUnitsInRectAll(r)
            while not (FirstOfGroup(g) == nil) do
                o = FirstOfGroup(g)
                GroupRemoveUnit(g, o)
                if UnitHasItemOfTypeBJ(o, FourCC('I01F')) then
                    if UnitHasItemOfTypeBJ(sluggly, FourCC('I00N')) then
                        UnitUseItemPoint(sluggly, UnitItemInSlotBJ(sluggly, 1), GetUnitX(o), GetUnitY(o))
                    else
                        if UnitHasItemOfTypeBJ(sluggly, FourCC('I00R')) then
                            if DistanceBetweenUnits(sluggly, o) <= 600.0 then
                                UnitUseItemPoint(sluggly, UnitItemInSlotBJ(sluggly, 2), GetUnitX(o), GetUnitY(o))
                            else
                                IssuePointOrder(sluggly, "move", GetUnitX(o), GetUnitY(o))
                            end
                        else
                            UnitAddItemByIdSwapped(FourCC('I00N'), sluggly)
                            UnitAddItemByIdSwapped(FourCC('I00R'), sluggly)
                        end
                    end
                end
            end
            DestroyGroup(g)
            g = nil
            PolledWait(2.0)
        end
    end

    function SlugglyAssassinAIForTempUnit()
        SlugglyAssassin(udg_TempUnit)
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    function RoboButler_Move()
        local k     = GetExpiredTimer() ---@type timer
        local a     = LoadUnitHandle(LS(), GetHandleId(k), StringHash("u")) ---@type unit
        local c     = LoadPlayerHandle(LS(), GetHandleId(k), StringHash("u2")) ---@type player
        local b     = GetPlayerhero(c) ---@type unit
        local angle = bj_RADTODEG * Atan2(GetUnitY(a) - GetUnitY(b), GetUnitX(a) - GetUnitX(b)) ---@type real
        local x     = GetUnitX(b) + 75.0 * CosBJ(angle) ---@type real
        local y     = GetUnitY(b) + 75.0 * SinBJ(angle) ---@type real
        --Will not follow spacial alien into space. Instead will magically stay at the same spot, and warp to spacial alien when
        --it boards.
        if IsUnitDeadBJ(b) or b == nil then
            RemoveUnit(a)
            FlushChildHashtable(LS(), GetHandleId(k))
            PauseTimer(k)
            DestroyTimer(k)
            return
        end
        if RectContainsCoords(gg_rct_Space, x, y) ~= true then
            SetUnitX(a, x)
            SetUnitY(a, y)
        end
        if GetOwningPlayer(b) == Player(bj_PLAYER_NEUTRAL_EXTRA) or GetUnitTypeId(b) == FourCC('h01D') or udg_Player_IsMasquerading[GetConvertedPlayerId(c)] or GetUnitAbilityLevel(b, FourCC('A08D')) >= 1 then
            --The alien is in alien form or the mutant is a stalker. Cloaking will be applied.
            UnitAddAbility(a, FourCC('Agho'))
        else
            UnitRemoveAbility(a, FourCC('Agho'))
        end
    end

    function RoboButler()
        local a = udg_TempUnit ---@type unit
        local b = GetOwningPlayer(udg_TempUnit2) ---@type player
        local k = CreateTimer() ---@type timer
        SaveUnitHandle(LS(), GetHandleId(k), StringHash("u"), a)
        SavePlayerHandle(LS(), GetHandleId(k), StringHash("u2"), b)
        TimerStart(k, 0.04, true, RoboButler_Move)
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    ---@param a player
    function Masquerade_MutantEnd(a)
        --Automatically ends the masquerader's impersonation of the mutant or android after 30 seconds.
        PolledWait(30.0)
        ForceUICancelBJ(a)
    end

    ---@param a player
    function Masquerade_ShipEnd(a)
        --Automatically ends the masquerader's impersonation of a ship after 10 seconds.
        PolledWait(10.0)
        ForceUICancelBJ(a)
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    ---@param a player
    ---@param radius real
    ---@param damage real
    ---@param x real
    ---@param y real
    function DamageAreaForPlayer(a, radius, damage, x, y)
        --Damage will be of the standard universal Metastasis damage type.
        local bo = Location(x, y) ---@type location
        local g  = GetUnitsInRangeOfLocAll(radius, bo) ---@type group
        local q ---@type unit
        while not (FirstOfGroup(g) == nil) do
            q = FirstOfGroup(g)
            GroupRemoveUnit(g, q)
            if a ~= GetOwningPlayer(q) then
                UnitDamageTarget(GetPlayerhero(a), q, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL,
                    WEAPON_TYPE_WHOKNOWS)
            end
        end
        DestroyGroup(g)
        RemoveLocation(bo)
    end

    ---@param a player
    ---@param radius real
    ---@param damage real
    ---@param x real
    ---@param y real
    function DamageAreaForPlayerTK(a, radius, damage, x, y)
        --Damage will be of the standard universal Metastasis damage type. Same as above function but will damage the player it damages for.
        local bo = Location(x, y) ---@type location
        local g  = GetUnitsInRangeOfLocAll(radius, bo) ---@type group
        local q ---@type unit
        while not (FirstOfGroup(g) == nil) do
            q = FirstOfGroup(g)
            GroupRemoveUnit(g, q)
            UnitDamageTarget(GetPlayerhero(a), q, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL,
                WEAPON_TYPE_WHOKNOWS)
        end
        DestroyGroup(g)
        RemoveLocation(bo)
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    ---@param r group
    ---@param abil integer
    ---@param orderId string
    function CastAbilityOnGroup(r, abil, orderId)
        local q ---@type unit
        local o ---@type unit
        while not (FirstOfGroup(r) == nil) do
            q = FirstOfGroup(r)
            GroupRemoveUnit(r, q)
            if GetOwningPlayer(q) ~= Player(PLAYER_NEUTRAL_AGGRESSIVE) then
                o = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE), FourCC('e01Q'), GetUnitX(q), GetUnitY(q), 0.0)
            else
                o = CreateUnit(Player(1), FourCC('e01Q'), GetUnitX(q), GetUnitY(q), 0.0)
            end
            UnitAddAbility(o, abil)
            IssueTargetOrder(o, orderId, q)
        end
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    ---@param effectPath string
    ---@param scale real
    ---@param duration real
    ---@param x real
    ---@param y real
    ---@return unit
    function CreateScaledEffect(effectPath, scale, duration, x, y)
        --That effect is a UNIT!
        local p = CreateUnit(Player(14), FourCC('e01Q'), x, y, GetRandomDirectionDeg()) ---@type unit
        SetUnitScale(p, scale, scale, scale)
        AddSpecialEffectTarget(effectPath, p, "origin")
        UnitApplyTimedLife(p, FourCC('B000'), duration)
        return p
    end

    ---@param effectPath string
    ---@param scale real
    ---@param duration real
    ---@param x real
    ---@param y real
    ---@return unit
    function CreateScaledEffect2(effectPath, scale, duration, x, y)
        --That effect is a UNIT! sans flying
        local p = CreateUnit(Player(14), FourCC('e03A'), x, y, GetRandomDirectionDeg()) ---@type unit
        SetUnitScale(p, scale, scale, scale)
        AddSpecialEffectTarget(effectPath, p, "origin")
        UnitApplyTimedLife(p, FourCC('B000'), duration)
        return p
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    --The below functions are useful in tracking pings: I.E. you are standing right outside a ship, use a tracking
    --device, and see players inside the ship as well.

    local_GetUnitsInRectAndShips_Group = nil ---@type group

    function GetUnitsInRectAndShips_Child()
        local g ---@type group
        if udg_SpaceObject_Rect[GetUnitUserData(GetEnumUnit())] ~= nil then
            g = GetUnitsInRectAll(udg_SpaceObject_Rect[GetUnitUserData(GetEnumUnit())])
            GroupAddGroup(g, local_GetUnitsInRectAndShips_Group)
            DestroyGroup(g)
        end
    end

    ---@param r rect
    ---@return group
    function GetUnitsInRectAndShips(r)
        local g                            = GetUnitsInRectAll(r) ---@type group
        local_GetUnitsInRectAndShips_Group = g
        ForGroup(g, GetUnitsInRectAndShips_Child)
        return g
    end

    ---@param m location
    ---@param radius real
    ---@return group
    function GetUnitsInRangeAndShips(m, radius)
        local g                            = GetUnitsInRangeOfLocAll(radius, m) ---@type group
        local_GetUnitsInRectAndShips_Group = g
        ForGroup(g, GetUnitsInRectAndShips_Child)
        return g
    end

    SHU_Bool = nil ---@type boolean

    function SHU_Test()
        if GetPlayerheroU(GetEnumUnit()) == GetEnumUnit() then
            SHU_Bool = true
        end
    end

    ---@param ship unit
    ---@return boolean
    function ShipHasUnits(ship)
        local r  = GetUnitsInRectAll(udg_SpaceObject_Rect[GetUnitUserData(ship)]) ---@type group
        SHU_Bool = false
        ForGroup(r, SHU_Test)
        return SHU_Bool
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    --Actually I think this code I stole from somewhere.
    ---@param text string
    ---@param x real
    ---@param y real
    ---@param red integer
    ---@param green integer
    ---@param blue integer
    ---@param alpha integer
    function AddFadingTextTag(text, x, y, red, green, blue, alpha)
        local t = CreateTextTag() ---@type texttag
        SetTextTagText(t, text, 0.025)
        SetTextTagPos(t, x, y, 0.00)
        SetTextTagColor(t, red, green, blue, alpha)
        SetTextTagVelocity(t, 0, 0.03)
        SetTextTagVisibility(t, true)
        SetTextTagFadepoint(t, 2)
        SetTextTagLifespan(t, 3)
        SetTextTagPermanent(t, false)
        t = nil
    end

    ---@param text string
    ---@param where location
    ---@param red integer
    ---@param green integer
    ---@param blue integer
    ---@param alpha integer
    function AddFadingTextTagLoc(text, where, red, green, blue, alpha)
        AddFadingTextTag(text, GetLocationX(where), GetLocationY(where), red, green, blue, alpha)
    end

    --//



    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    function PacificationBotSort()
        local b = GetEnumUnit() ---@type unit
        if gg_unit_h04A_0144 ~= b and (IsUnitType(b, UNIT_TYPE_MECHANICAL) or IsUnitSuit(b)) and GetConvertedPlayerId(GetOwningPlayer(b)) <= 12 and GetUnitAbilityLevel(b, FourCC('Avul')) == 0 and IsUnitAliveBJ(b) and GetUnitTypeId(b) ~= FourCC('n00A') then
            udg_TempUnit = b
        end
    end

    function PacificationBotDisable()
        local k = LoadTimerHandle(LS(), GetHandleId(gg_unit_h04A_0144), StringHash("director")) ---@type timer
        PauseTimer(k)
        DestroyTimer(k)
        SetUnitTimeScale(gg_unit_h04A_0144, 0)
        PauseUnit(gg_unit_h04A_0144, true)
    end

    function PacificationBotDirect()
        local b = GetUnitLoc(gg_unit_h04A_0144) ---@type location
        local g = GetUnitsInRangeOfLocAll(600.0, b) ---@type group
        local m ---@type integer

        if IsUnitDeadBJ(gg_unit_h04A_0144) then
            PacificationBotDisable()
            return
        end

        --If pacification bot is player-controlled, gtfo
        if GetOwningPlayer(gg_unit_h04A_0144) ~= Player(PLAYER_NEUTRAL_PASSIVE) then
            return
        end

        udg_TempUnit = nil
        ForGroup(g, PacificationBotSort)
        DestroyGroup(g)
        if udg_TempUnit ~= nil then
            if GetRandomInt(0, 4) == 0 then
                AddFadingTextTag(udg_PacificationBotLines[m], GetUnitX(gg_unit_h04A_0144), GetUnitY(gg_unit_h04A_0144),
                    255, 0, 0, 255)
            end
            IssueTargetOrder(gg_unit_h04A_0144, "attack", udg_TempUnit)
        else
            if GetUnitCurrentOrder(gg_unit_h04A_0144) ~= String2OrderIdBJ("move") then
                udg_TempPoint = GetRandomLocInRect(gg_rct_ST4S2)
                IssuePointOrderLoc(gg_unit_h04A_0144, "move", udg_TempPoint)
                RemoveLocation(udg_TempPoint)
            end
        end
    end

    function PacificationBotEnable()
        local k = CreateTimer() ---@type timer
        if IsUnitAliveBJ(gg_unit_h04A_0144) then
            SaveTimerHandle(LS(), GetHandleId(gg_unit_h04A_0144), StringHash("director"), k)
            SetUnitTimeScale(gg_unit_h04A_0144, 1.0)
            PauseUnit(gg_unit_h04A_0144, false)
            TimerStart(k, 2, true, PacificationBotDirect)
        else
            DestroyTimer(k)
        end
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    --The effect that the Kyo has when it has a charged ATM
    ---@param m timer
    function DestroyLightningRing(m)
        PauseTimer(m)
        RemoveUnit(LoadUnitHandle(LS(), GetHandleId(m), StringHash("ring")))
        FlushChildHashtable(LS(), GetHandleId(m))
        DestroyTimer(m)
    end

    function LightningRingReverse()
        local m    = GetExpiredTimer() ---@type timer
        local ring = LoadUnitHandle(LS(), GetHandleId(m), StringHash("ring")) ---@type unit
        if GetUnitFlyHeight(ring) > 300 then
            SetUnitFlyHeight(ring, 0, 1400)
        else
            SetUnitFlyHeight(ring, 700, 1400)
        end
        SetUnitFacing(ring, GetUnitFacing(ring) + 179.0)
    end

    ---@param a unit
    ---@return timer
    function LightningRing(a)
        local ring = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), FourCC('e01Y'), GetUnitX(a), GetUnitY(a),
            GetRandomDirectionDeg()) ---@type unit
        local m    = CreateTimer() ---@type timer
        SaveUnitHandle(LS(), GetHandleId(m), StringHash("ring"), ring)
        SetUnitFlyHeight(ring, 700, 1400)
        TimerStart(m, 0.5, true, LightningRingReverse)
        return m
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    --The zappy ATM effect.
    function DestroyLightningPeriod()
        local k = bj_lastCreatedLightning ---@type lightning
        PolledWait(1.0)
        DestroyLightning(k)
    end

    ---@param codename string
    ---@param x1 real
    ---@param y1 real
    ---@param z1 real
    ---@param x2 real
    ---@param y2 real
    ---@param z2 real
    ---@param number integer
    ---@param variation real
    function AddLightningStormEx(codename, x1, y1, z1, x2, y2, z2, number, variation)
        local i = 1 ---@type integer
        while i <= number do
            bj_lastCreatedLightning = AddLightningEx(codename, false, x1 + GetRandomReal(-variation, variation),
                y1 + GetRandomReal(-variation, variation), z1 + GetRandomReal(-variation, variation),
                x2 + GetRandomReal(-variation, variation), y2 + GetRandomReal(-variation, variation),
                z2 + GetRandomReal(-variation, variation))
            ExecuteFunc("DestroyLightningPeriod")
            i = i + 1
        end
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    --Checks to see that there are no elevated cliff level sbetween locations a and b, and no SPEHSS
    ---@param a location
    ---@param b location
    ---@param resolution integer
    ---@return boolean
    function TerrainLineCheck(a, b, resolution)
        local dist          = DistanceBetweenPoints(a, b) ---@type real
        local angle         = AngleBetweenPoints(a, b) ---@type real
        local interval      = dist / I2R(resolution) ---@type real
        local i             = 1 ---@type integer
        local clear         = true ---@type boolean
        local c             = Location(GetLocationX(a), GetLocationY(a)) ---@type location
        local d ---@type location
        local defaultHeight = GetTerrainCliffLevel(GetLocationX(a), GetLocationY(a)) ---@type integer
        while not ((i > resolution) or not (clear)) do
            d = PolarProjectionBJ(c, interval, angle)
            if GetTerrainCliffLevel(GetLocationX(d), GetLocationY(d)) > defaultHeight or GetTerrainType(GetLocationX(d), GetLocationY(d)) == FourCC('Vcbp') then
                clear = false
            end
            RemoveLocation(c)
            c = d
            i = i + 1
        end
        RemoveLocation(d)
        return clear
    end

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    function AsteroidHit()
        local asteroid = LoadUnitHandle(LS(), GetHandleId(GetTriggeringTrigger()), StringHash("asteroid")) ---@type unit
        if IsUnitStation(GetTriggerUnit()) then
            UnitDamageTarget(asteroid, GetTriggerUnit(), GetUnitState(asteroid, UNIT_STATE_LIFE) * 4, false, false,
                ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
            KillUnit(asteroid)
        end
        if IsUnitExplorer(GetTriggerUnit()) then
            UnitDamageTarget(asteroid, GetTriggerUnit(), 3000, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL,
                WEAPON_TYPE_WHOKNOWS)
            Push(GetTriggerUnit(), 500.0, 150.0, AngleBetweenUnits(asteroid, GetTriggerUnit()))
        end
    end

    function AsteroidDeath()
        local d        = GetTriggeringTrigger() ---@type trigger
        local asteroid = LoadUnitHandle(LS(), GetHandleId(d), StringHash("asteroid")) ---@type unit
        local t        = LoadTriggerHandle(LS(), GetHandleId(d), StringHash("t")) ---@type trigger
        FlushChildHashtable(LS(), GetHandleId(t))
        DestroyTrigger(t)
        DestroyTrigger(d)
        CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), FourCC('e01E'), GetUnitX(asteroid), GetUnitY(asteroid),
            GetRandomDirectionDeg())
    end

    function Asteroid_LeaveCheck()
        local asteroid = LoadUnitHandle(LS(), GetHandleId(GetExpiredTimer()), StringHash("asteroid")) ---@type unit
        local x        = GetUnitX(asteroid) ---@type real
        local y        = GetUnitY(asteroid) ---@type real
        if x < 6756 or x > 16129 or y > -6749 or y < -16203 then
            SetUnitPosition(asteroid, 144, 1444)
            KillUnit(asteroid)
        end
        if IsUnitDeadBJ(asteroid) then
            PauseTimer(GetExpiredTimer())
            FlushChildHashtable(LS(), GetHandleId(GetExpiredTimer()))
            DestroyTimer(GetExpiredTimer())
        end
    end

    ---@param asteroid unit
    ---@param target real
    function GiantAsteroid(asteroid, target)
        local t = CreateTrigger() ---@type trigger
        local d = CreateTrigger() ---@type trigger
        local m = CreateTimer() ---@type timer
        local r = target ---@type real
        Push(asteroid, 50.0 + GetRandomReal(-30.0, 40.0), 0, r)
        SaveUnitHandle(LS(), GetHandleId(m), StringHash("asteroid"), asteroid)
        TriggerRegisterUnitInRangeSimple(t, 90.0, asteroid)
        TriggerAddAction(t, AsteroidHit)
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("asteroid"), asteroid)
        TriggerRegisterUnitEvent(d, asteroid, EVENT_UNIT_DEATH)
        TriggerAddAction(d, AsteroidDeath)
        SaveUnitHandle(LS(), GetHandleId(d), StringHash("asteroid"), asteroid)
        SaveTriggerHandle(LS(), GetHandleId(d), StringHash("t"), t)
        SaveUnitHandle(LS(), GetHandleId(m), StringHash("asteroid"), asteroid)
        TimerStart(m, 1, true, Asteroid_LeaveCheck)
    end

    --////////////////////////////////////////////////////////////////
    ---@param a location
    ---@param max real
    ---@param angle real
    ---@return location
    function IntelligentRubble(a, max, angle)
        local suppose ---@type location
        local prev = Location(GetLocationX(a), GetLocationY(a)) ---@type location
        local ID   = GetSector(a) ---@type integer
        local i    = 0 ---@type real
        if max > 40 then
            while i <= max do
                suppose = PolarProjectionBJ(a, i, angle)
                if GetTerrainCliffLevelBJ(suppose) > GetTerrainCliffLevelBJ(a) or not (LocInSector(suppose, ID)) or GetTerrainType(GetLocationX(suppose), GetLocationY(suppose)) == FourCC('Vcbp') then
                    RemoveLocation(suppose)
                    return prev
                end
                RemoveLocation(prev)
                prev = suppose
                i = i + 20
            end
            return suppose
        else
            return Location(GetLocationX(a), GetLocationY(a))
        end
    end

    --//////////////
    --Basically creates a chain of lightnings near a loc! WOOOOO
    --Ensures that stuff doesn't stretch.
    --Returns a hashtable that contains all of the lightnings, which can be used with
    --the second function to destroy the lightning chain
    ---@param acode string
    ---@param a location
    ---@param b location
    ---@param refresh real
    ---@param savehash hashtable
    function LightningizeLocs(acode, a, b, refresh, savehash)
        local h   = DistanceBetweenPoints(a, b) ---@type real
        local ang = AngleBetweenPoints(a, b) ---@type real
        local i   = 0 ---@type integer
        local m   = 0 ---@type real
        local q   = Location(GetLocationX(a), GetLocationY(a)) ---@type location
        local q2 ---@type location
        while m <= h do
            i = i + 1
            if h - m < refresh then
                q2 = PolarProjectionBJ(q, h - m, ang)
            else
                q2 = PolarProjectionBJ(q, refresh, ang)
            end
            SaveLightningHandle(savehash, 1, i, AddLightningLoc(acode, q, q2))
            RemoveLocation(q)
            q = q2
            m = m + refresh
        end
        SaveInteger(savehash, 2, 1, i)
    end

    ---@param h hashtable
    function Delightningize(h)
        local i = LoadInteger(h, 2, 1) ---@type integer
        local k = 1 ---@type integer
        while k <= i do
            DestroyLightning(LoadLightningHandle(h, 1, k))
            k = k + 1
        end
    end

    --/////////////////////
    --/////////////////////
    --//////////////////////
    ---@return boolean
    function Trig_CrabTeleport_Conditions()
        if (not (OrderId2StringBJ(GetIssuedOrderIdBJ()) == "smart")) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_CrabTeleport_Func006C()
        if (not (DistanceBetweenPoints(udg_TempPoint2, udg_TempPoint3) >= udg_TempReal)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_CrabTeleport_Func007C()
        if (not (DistanceBetweenPoints(udg_TempPoint2, udg_TempPoint3) <= 100.00)) then
            return false
        end
        return true
    end

    function Trig_CrabTeleport_Actions()
        udg_TempReal = (GetUnitStateSwap(UNIT_STATE_MANA, GetOrderedUnit()) * 20.00)
        udg_TempPoint2 = GetUnitLoc(GetOrderedUnit())
        udg_TempPoint3 = GetOrderPointLoc()
        udg_TempReal2 = AngleBetweenPoints(udg_TempPoint2, udg_TempPoint3)
        if (Trig_CrabTeleport_Func006C()) then
            RemoveLocation(udg_TempPoint3)
            udg_TempPoint3 = PolarProjectionBJ(udg_TempPoint2, udg_TempReal, udg_TempReal2)
        else
        end
        if (Trig_CrabTeleport_Func007C()) then
            udg_TempPoint = udg_TempPoint3
        else
            udg_TempPoint = IntelligentRubble(udg_TempPoint2, DistanceBetweenPoints(udg_TempPoint2, udg_TempPoint3),
                AngleBetweenPoints(udg_TempPoint2, udg_TempPoint3))
        end
        SetUnitManaBJ(GetOrderedUnit(),
            (GetUnitStateSwap(UNIT_STATE_MANA, GetOrderedUnit()) - (DistanceBetweenPoints(udg_TempPoint, udg_TempPoint2) / 20.00)))
        SetUnitPositionLoc(GetOrderedUnit(), udg_TempPoint)
        AddSpecialEffectLocBJ(udg_TempPoint, "Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl")
        SFXThreadClean()
        AddSpecialEffectLocBJ(udg_TempPoint2, "Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl")
        SFXThreadClean()
        RemoveLocation(udg_TempPoint)
        RemoveLocation(udg_TempPoint2)
        RemoveLocation(udg_TempPoint3)
    end

    --===========================================================================

    ---@param q unit
    function CrabTeleport(q)
        local a = CreateTrigger() ---@type trigger
        TriggerRegisterUnitEvent(a, q, EVENT_UNIT_ISSUED_POINT_ORDER)
        TriggerAddCondition(a, Condition(Trig_CrabTeleport_Conditions))
        TriggerAddAction(a, Trig_CrabTeleport_Actions)
    end

    --/////////////////
    --////////////


    function SVOP_Callback()
        local k     = GetExpiredTimer() ---@type timer
        local r     = LoadSoundHandle(LS(), GetHandleId(k), StringHash("r")) ---@type sound
        local start = LoadReal(LS(), GetHandleId(k), StringHash("start")) ---@type real
        local end_  = LoadReal(LS(), GetHandleId(k), StringHash("end")) ---@type real
        local lerp  = LoadReal(LS(), GetHandleId(k), StringHash("lerp")) ---@type real
        start       = start + lerp
        SetSoundVolume(r, R2I(start))
        if start > end_ then
            PauseTimer(k)
            FlushChildHashtable(LS(), GetHandleId(k))
            DestroyTimer(k)
        else
            SaveReal(LS(), GetHandleId(k), StringHash("start"), start)
        end
    end

    ---@param r sound
    ---@param start real
    ---@param end_ real
    ---@param time real
    function SoundVolumeOverPeriod(r, start, end_, time)
        local k = CreateTimer() ---@type timer
        SaveSoundHandle(LS(), GetHandleId(k), StringHash("r"), r)
        SaveReal(LS(), GetHandleId(k), StringHash("start"), start)
        SaveReal(LS(), GetHandleId(k), StringHash("end"), end_)
        SaveReal(LS(), GetHandleId(k), StringHash("lerp"), (end_ - start) / time * 0.05)
        TimerStart(k, 0.05, true, SVOP_Callback)
    end

    function MKU_CallBack()
        local t = GetExpiredTimer() ---@type timer
        KillUnit(LoadUnitHandle(udg_hash, GetHandleId(t), StringHash("r")))
        FlushChildHashtable(udg_hash, GetHandleId(t))
        DestroyTimer(t)
    end

    ---@param Victim unit
    ---@param Killer unit
    function MoogleKillUnit(Victim, Killer)
        --Fel should definitely make his own function
        local t = CreateTimer() ---@type timer
        UnitRemoveBuffs(Victim, true, true)
        ShowUnit(Victim, true)
        SetUnitInvulnerable(Victim, false)
        SetUnitState(Victim, UNIT_STATE_LIFE, 1)
        UnitDamageTarget(Killer, Victim, 421337, true, false, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
        SaveUnitHandle(udg_hash, GetHandleId(t), StringHash("r"), Victim)
        TimerStart(t, 0.01, false, MKU_CallBack)
    end

    function DropItem_FollowThrough()
        local t        = GetTriggeringTrigger() ---@type trigger
        local a        = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) ---@type unit
        local itemType = LoadInteger(LS(), GetHandleId(t), StringHash("itemType")) ---@type integer
        CreateItem(itemType, GetUnitX(a), GetUnitY(a))
        FlushChildHashtable(LS(), GetHandleId(t))
        DestroyTrigger(t)
    end

    ---@param a unit
    ---@param itemType integer
    function DropItemFromUnitOnDeath(a, itemType)
        local t = CreateTrigger() ---@type trigger
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), a)
        SaveInteger(LS(), GetHandleId(t), StringHash("itemType"), itemType)
        TriggerAddAction(t, DropItem_FollowThrough)
        TriggerRegisterUnitEvent(t, a, EVENT_UNIT_DEATH)
    end

    function VendorDamagedCheck()
        local t = GetExpiredTimer() ---@type timer
        local u = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) ---@type unit
        local d = LoadEffectHandle(LS(), GetHandleId(t), StringHash("effect")) ---@type effect
        if not (IsUnitPaused(u)) or u == nil then
            PauseTimer(t)
            FlushChildHashtable(LS(), GetHandleId(t))
            DestroyTimer(t)
            DestroyEffect(d)
        end
    end

    ---@param a unit
    function VendorIsDamaged(a)
        local b = not (IsUnitPaused(a)) ---@type boolean
        local c = a ---@type unit
        local d ---@type effect
        local t ---@type timer
        if GetEventDamage() < 0.5 then
            return
        end
        PauseUnitForPeriod(a, 10.0)
        if b then
            d = AddSpecialEffect("Abilities\\Spells\\Orc\\Purge\\PurgeBuffTarget.mdl", GetUnitX(c), GetUnitY(c))
            t = CreateTimer()
            SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), c)
            SaveEffectHandle(LS(), GetHandleId(t), StringHash("effect"), d)
            TimerStart(t, 0.2, true, VendorDamagedCheck)
        end
    end

    function Vendor_Damaged()
        local b = not (IsUnitPaused(GetTriggerUnit())) ---@type boolean
        local c = GetTriggerUnit() ---@type unit
        local d ---@type effect
        PauseUnitForPeriod(GetTriggerUnit(), 10.0)
        if b then
            d = AddSpecialEffect("Abilities\\Spells\\Orc\\Purge\\PurgeBuffTarget.mdl", GetUnitX(c), GetUnitY(c))
            while not (not (IsUnitPaused(c)) or c == nil) do
                PolledWait(0.2)
            end
            DestroyEffect(d)
        end
    end

    ---@param vendor unit
    function RegisterVendor(vendor)
        --Sets up the "vendor disabled for X seconds on damage"
        local t = udg_VendorTrigger ---@type trigger
        TriggerRegisterUnitEvent(t, vendor, EVENT_UNIT_DAMAGED)
    end

    function dinit()
        if GetUnitAbilityLevel(GetEnumUnit(), FourCC('A07Q')) > 0 then
            RegisterVendor(GetEnumUnit())
        end
    end

    function vendorDamage_init()
        local g           = GetUnitsInRectAll(GetPlayableMapRect()) ---@type group
        udg_VendorTrigger = CreateTrigger()
        TriggerAddAction(udg_VendorTrigger, Vendor_Damaged)
        ForGroup(g, dinit)
    end

    ---@param a location
    ---@param max real
    ---@param angle real
    ---@param danger location
    ---@return location
    function BasicAI_FindEvasionLoc(a, max, angle, danger)
        local suppose = a ---@type location
        local prev    = Location(GetLocationX(a), GetLocationY(a)) ---@type location
        local ID      = GetSector(a) ---@type integer
        local i       = 0 ---@type real
        if max > 40 then
            while not (DistanceBetweenPoints(suppose, danger) > max) do
                suppose = PolarProjectionBJ(a, i, angle)
                if GetTerrainCliffLevelBJ(suppose) > GetTerrainCliffLevelBJ(a) or not (LocInSector(suppose, ID)) or GetTerrainType(GetLocationX(suppose), GetLocationY(suppose)) == FourCC('Vcbp') then
                    RemoveLocation(suppose)
                    return prev
                end
                RemoveLocation(prev)
                prev = suppose
                i = i + 40
            end
            return suppose
        else
            return Location(GetLocationX(a), GetLocationY(a))
        end
    end

    ---@param q unit
    ---@param danger location
    ---@param clearradius real
    ---@param passtime real
    function BasicAI_EvadeDanger(q, danger, clearradius, passtime)
        local a      = GetUnitLoc(q) ---@type location
        local r      = clearradius - DistanceBetweenPoints(a, danger) ---@type real
        local score  = -9999 ---@type real
        local tscore = 0 ---@type real
        local test ---@type location
        local winner = nil ---@type location
        local i      = 0 ---@type integer
        local b      = LoadStr(LS(), GetHandleId(q), StringHash("AI_ORDER")) == "ATTACK" ---@type boolean
        local targ ---@type unit
        local targloc ---@type location
        local range  = LoadReal(LS(), GetHandleId(q), StringHash("AI_ATTACKRANGE")) ---@type real
        if b then
            targ = LoadUnitHandle(LS(), GetHandleId(q), StringHash("AI_TARGET"))
            targloc = GetUnitLoc(targ)
        end
        if r > 0 then
            SaveStr(LS(), GetHandleId(q), StringHash("AI_ORDER"), "EVADE")
            SaveReal(LS(), GetHandleId(q), StringHash("AI_EVADE_PASSTIME"), TimerGetElapsed(udg_GameTimer) + passtime)
            while i <= 40 do
                test = BasicAI_FindEvasionLoc(a, clearradius * GetRandomReal(1, 2), GetRandomDirectionDeg(), danger)
                tscore = 0
                if DistanceBetweenPoints(danger, test) > clearradius then
                    tscore = tscore + clearradius
                end
                if b and DistanceBetweenPoints(targloc, test) <= range then
                    tscore = tscore + 5
                end
                if tscore > score then
                    RemoveLocation(winner)
                    winner = test
                    score = tscore
                else
                    RemoveLocation(test)
                end
                i = i + 1
            end
            IssuePointOrderLoc(q, "move", winner)
            RemoveLocation(winner)
            RemoveLocation(a)
        end
        if b then
            RemoveLocation(targloc)
        end
    end

    function BasicAI_IssueDangerArea_Z()
        local k           = GetExpiredTimer() ---@type timer
        local danger      = LoadLocationHandle(LS(), GetHandleId(k), StringHash("danger")) ---@type location
        local clearradius = LoadReal(LS(), GetHandleId(k), StringHash("clearradius")) ---@type real
        local passtime    = LoadReal(LS(), GetHandleId(k), StringHash("passtime")) ---@type real
        local g           = GetUnitsInRangeOfLocAll(clearradius, danger) ---@type group
        local test ---@type unit
        FlushChildHashtable(LS(), GetHandleId(k))
        DestroyTimer(k)
        while not (FirstOfGroup(g) == nil) do
            test = FirstOfGroup(g)
            if HaveSavedString(LS(), GetHandleId(test), StringHash("AI_TEAM")) then
                BasicAI_EvadeDanger(test, danger, clearradius, passtime)
            end
            GroupRemoveUnit(g, test)
        end
        DestroyGroup(g)
    end

    ---@param danger location
    ---@param clearradius real
    ---@param passtime real
    function BasicAI_IssueDangerArea(danger, clearradius, passtime)
        local k = CreateTimer() ---@type timer
        SaveLocationHandle(LS(), GetHandleId(k), StringHash("danger"), danger)
        SaveReal(LS(), GetHandleId(k), StringHash("clearradius"), clearradius)
        SaveReal(LS(), GetHandleId(k), StringHash("passtime"), passtime)
        TimerStart(k, 0.0, false, BasicAI_IssueDangerArea_Z)
    end

    ---@param q unit
    ---@return location
    function BasicAI_FindFleePlace(q)
        local sector   = udg_SectorId[GetUnitSector(q)] ---@type rect
        local consider = 0 ---@type integer
        local score    = 0 ---@type real
        local a        = GetUnitLoc(q) ---@type location
        local b ---@type location
        local c        = a ---@type location
        while consider <= 100 do
            b = GetRandomLocInRect(sector)
            if GetTerrainTypeBJ(b) == FourCC('Vcbp') then
                RemoveLocation(b)
            else
                if DistanceBetweenPoints(a, b) > score then
                    RemoveLocation(c)
                    c = b
                    score = DistanceBetweenPoints(a, b)
                else
                    RemoveLocation(b)
                end
            end
            consider = consider + 1
        end
        return c
    end

    ---@param a boolean
    ---@return integer
    function B2I(a)
        if a then
            return 1
        else
            return 0
        end
    end

    ---@param q unit
    ---@param consider unit
    ---@return real
    function BasicAI_ScoreUnit(q, consider)
        local retz = 0.0 ---@type real
        retz       = retz - DistanceBetweenUnits(consider, q) / 600.0
        retz       = retz - 4 * GetUnitLifePercent(consider) / 100
        retz       = retz - 5 * B2I(GetOwningPlayer(consider) == Player(PLAYER_NEUTRAL_PASSIVE))
        retz       = retz - 5 * B2I(IsUnitType(consider, UNIT_TYPE_STRUCTURE))
        if UnitHasItemOfTypeBJ(consider, FourCC('I029')) then
            retz = retz - 100
        end
        return retz
    end

    ---@param q unit
    ---@param acquirerange real
    ---@return unit
    function BasicAI_ConsiderTargets(q, acquirerange)
        --Considers all groups within a range of acquirerange and returns the best target, will return null if none
        local g ---@type group
        local m ---@type group
        local target = nil ---@type unit
        local consider ---@type unit
        local score ---@type real
        local a ---@type location
        local team   = LoadStr(LS(), GetHandleId(q), StringHash("AI_TEAM")) ---@type string
        a            = GetUnitLoc(q)
        g            = GetUnitsInRangeOfLocAll(acquirerange, a)
        RemoveLocation(a)
        m = CreateGroup()
        while not (FirstOfGroup(g) == nil) do
            consider = FirstOfGroup(g)
            if GetUnitAbilityLevel(consider, FourCC('Avul')) == 0 and IsUnitAliveBJ(consider) and (not (HaveSavedString(LS(), GetHandleId(consider), StringHash("AI_TEAM"))) or LoadStr(LS(), GetHandleId(consider), StringHash("AI_TEAM")) ~= team) and GetUnitTypeId(consider) ~= FourCC('n00A') then
                GroupAddUnit(m, consider)
            end
            GroupRemoveUnit(g, consider)
        end
        DestroyGroup(g)
        if CountUnitsInGroup(m) > 0 then
            if CountUnitsInGroup(m) > 1 then
                score = -999
                while not (FirstOfGroup(m) == nil) do
                    consider = FirstOfGroup(m)
                    if score <= BasicAI_ScoreUnit(q, consider) then
                        target = consider
                        score = BasicAI_ScoreUnit(q, consider)
                    end
                    GroupRemoveUnit(m, consider)
                end
            else
                target = FirstOfGroup(m)
            end
        end
        DestroyGroup(m)
        return target
    end

    function BasicAI_Update()
        local t            = GetExpiredTimer() ---@type timer
        local q            = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) ---@type unit
        local order        = LoadStr(LS(), GetHandleId(q), StringHash("AI_ORDER")) ---@type string
        local team         = LoadStr(LS(), GetHandleId(q), StringHash("AI_TEAM")) ---@type string
        local a ---@type location
        local b ---@type location
        local target       = LoadUnitHandle(LS(), GetHandleId(q), StringHash("AI_TARGET")) ---@type unit
        local consider ---@type unit
        local passtime ---@type real
        local attackrange  = LoadReal(LS(), GetHandleId(q), StringHash("AI_ATTACKRANGE")) ---@type real
        local acquirerange = LoadReal(LS(), GetHandleId(q), StringHash("AI_ACQUIRERANGE")) ---@type real
        if IsUnitHidden(q) then
            return
        end
        if IsUnitDeadBJ(q) then
            FlushChildHashtable(LS(), GetHandleId(t))
            DestroyTimer(t)
            return
        end
        if order == "ROAM" then
            target = BasicAI_ConsiderTargets(q, acquirerange)
            if target ~= nil then
                SaveStr(LS(), GetHandleId(q), StringHash("AI_ORDER"), "ATTACK")
                SaveUnitHandle(LS(), GetHandleId(q), StringHash("AI_TARGET"), target)
                order = "ATTACK"
            else
                a = GetUnitLoc(q)
                if GetRandomInt(0, 3) == 0 then
                    b = PolarProjectionBJ(a, GetRandomReal(0, 600.0), GetRandomDirectionDeg())
                    IssuePointOrderLoc(q, "move", b)
                end
                RemoveLocation(b)
                RemoveLocation(a)
            end
        end
        if order == "ATTACK" then
            consider = BasicAI_ConsiderTargets(q, acquirerange)
            if consider ~= target then
                if consider == nil then
                    SaveStr(LS(), GetHandleId(q), StringHash("AI_ORDER"), "ROAM")
                else
                    SaveUnitHandle(LS(), GetHandleId(q), StringHash("AI_TARGET"), consider)
                    IssueTargetOrder(q, "attack", consider)
                end
            else
                if not (OrderId2String(GetUnitCurrentOrder(q)) == "attack") then
                    IssueTargetOrder(q, "attack", target)
                end
            end
        end

        if order == "FLEE" then
            if GetUnitLifePercent(q) > 50.0 then
                SaveStr(LS(), GetHandleId(q), StringHash("AI_ORDER"), "ROAM")
                SetUnitMoveSpeed(q, GetUnitMoveSpeed(q) - 50.0)
            else
                consider = BasicAI_ConsiderTargets(q, acquirerange)
                if consider ~= nil and GetUnitCurrentOrder(q) ~= String2OrderIdBJ("move") then
                    a = BasicAI_FindFleePlace(q)
                    IssuePointOrderLoc(q, "move", a)
                    RemoveLocation(a)
                end
            end
        end
        if order == "EVADE" then
            passtime = LoadReal(LS(), GetHandleId(q), StringHash("AI_EVADE_PASSTIME"))
            if TimerGetElapsed(udg_GameTimer) > passtime then
                SaveStr(LS(), GetHandleId(q), StringHash("AI_ORDER"), "ROAM")
            else
                if GetUnitCurrentOrder(q) ~= String2OrderIdBJ("move") then
                    consider = BasicAI_ConsiderTargets(q, attackrange)
                    if consider ~= nil then
                        IssueTargetOrder(q, "attack", consider)
                    end
                end
            end
        else
            if GetUnitLifePercent(q) < 34.0 then
                SaveStr(LS(), GetHandleId(q), StringHash("AI_ORDER"), "FLEE")
                SetUnitMoveSpeed(q, GetUnitMoveSpeed(q) + 50.0)
            end
        end
        --
    end

    ---@param q unit
    ---@param range real
    ---@param acquirerange real
    function BasicAI(q, range, acquirerange)
        local refresh = CreateTimer() ---@type timer
        SaveUnitHandle(LS(), GetHandleId(refresh), StringHash("unit"), q)
        TimerStart(refresh, 0.5, true, BasicAI_Update)
        SaveUnitHandle(LS(), GetHandleId(q), StringHash("AI_" .. "TARGET"), nil)
        SaveStr(LS(), GetHandleId(q), StringHash("AI_TEAM"), "AI")
        SaveStr(LS(), GetHandleId(q), StringHash("AI_ORDER"), "ROAM")
        SaveReal(LS(), GetHandleId(q), StringHash("AI_ATTACKRANGE"), range)
        SaveReal(LS(), GetHandleId(q), StringHash("AI_ACQUIRERANGE"), acquirerange)
    end

    --/



    --
    function BasicAI_Update_Murmusk()
        local t            = GetExpiredTimer() ---@type timer
        local q            = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) ---@type unit
        local order        = LoadStr(LS(), GetHandleId(q), StringHash("AI_ORDER")) ---@type string
        local team         = LoadStr(LS(), GetHandleId(q), StringHash("AI_TEAM")) ---@type string
        local a ---@type location
        local b ---@type location
        local target       = LoadUnitHandle(LS(), GetHandleId(q), StringHash("AI_TARGET")) ---@type unit
        local consider ---@type unit
        local passtime ---@type real
        local attackrange  = LoadReal(LS(), GetHandleId(q), StringHash("AI_ATTACKRANGE")) ---@type real
        local acquirerange = LoadReal(LS(), GetHandleId(q), StringHash("AI_ACQUIRERANGE")) ---@type real
        --
        if IsUnitHidden(q) then
            return
        end
        if IsUnitDeadBJ(q) then
            FlushChildHashtable(LS(), GetHandleId(t))
            DestroyTimer(t)
            return
        end
        if order == "ROAM" then
            target = BasicAI_ConsiderTargets(q, acquirerange)
            if target ~= nil then
                SaveStr(LS(), GetHandleId(q), StringHash("AI_ORDER"), "ATTACK")
                SaveUnitHandle(LS(), GetHandleId(q), StringHash("AI_TARGET"), target)
                order = "ATTACK"
            else
                a = GetUnitLoc(q)
                if GetRandomInt(0, 3) == 0 then
                    b = PolarProjectionBJ(a, GetRandomReal(0, 600.0), GetRandomDirectionDeg())
                    IssuePointOrderLoc(q, "move", b)
                end
                RemoveLocation(b)
                RemoveLocation(a)
            end
        end
        if order == "ATTACK" then
            consider = BasicAI_ConsiderTargets(q, acquirerange)
            if consider ~= target then
                if consider == nil then
                    SaveStr(LS(), GetHandleId(q), StringHash("AI_ORDER"), "ROAM")
                else
                    SaveUnitHandle(LS(), GetHandleId(q), StringHash("AI_TARGET"), consider)
                    IssueTargetOrder(q, "attack", consider)
                end
            else
                if not (OrderId2String(GetUnitCurrentOrder(q)) == "attack") then
                    IssueTargetOrder(q, "attack", target)
                end
            end
        end


        if order == "EVADE" then
            passtime = LoadReal(LS(), GetHandleId(q), StringHash("AI_EVADE_PASSTIME"))
            if TimerGetElapsed(udg_GameTimer) > passtime then
                SaveStr(LS(), GetHandleId(q), StringHash("AI_ORDER"), "ROAM")
            else
                if GetUnitCurrentOrder(q) ~= String2OrderIdBJ("move") then
                    consider = BasicAI_ConsiderTargets(q, attackrange)
                    if consider ~= nil then
                        IssueTargetOrder(q, "attack", consider)
                    end
                end
            end
        end
        --
    end

    --
    ---@param q unit
    ---@param range real
    ---@param acquirerange real
    function BasicAI_Murmusk(q, range, acquirerange)
        local refresh = CreateTimer() ---@type timer
        SaveUnitHandle(LS(), GetHandleId(refresh), StringHash("unit"), q)
        TimerStart(refresh, 0.5, true, BasicAI_Update_Murmusk)
        SaveUnitHandle(LS(), GetHandleId(q), StringHash("AI_" .. "TARGET"), nil)
        SaveStr(LS(), GetHandleId(q), StringHash("AI_TEAM"), "MURMUSK")
        SaveStr(LS(), GetHandleId(q), StringHash("AI_ORDER"), "ROAM")
        SaveReal(LS(), GetHandleId(q), StringHash("AI_ATTACKRANGE"), range)
        SaveReal(LS(), GetHandleId(q), StringHash("AI_ACQUIRERANGE"), acquirerange)
    end

    --////
    --///
    -- function FloatingTextVisibilityCheck takes nothing returns nothing
    -- if IsLocationVisibleToPlayer(udg_TempPoint, GetEnumPlayer()) then
    -- if GetLocalPlayer() == GetEnumPlayer() then
    -- call SetTextTagVisibility(udg_TempTexttag, true)
    -- endif
    -- else
    -- if GetLocalPlayer() == GetEnumPlayer() then
    -- call SetTextTagVisibility(udg_TempTexttag, false)
    -- endif
    -- endif
    -- endfunction

    -- function FloatingTextVisibilityUpdate takes nothing returns nothing
    -- local timer t=GetExpiredTimer()
    -- local texttag a=LoadTextTagHandle(LS(),GetHandleId(t),StringHash("tt"))
    -- local location b=LoadLocationHandle(LS(),GetHandleId(t),StringHash("loc"))
    -- if a == null then
    -- call FlushChildHashtable(LS(),GetHandleId(t))
    -- call PauseTimer(t)
    -- call DestroyTimer(t)
    -- endif
    -- set udg_TempPoint=b
    -- set udg_TempTexttag=a
    -- call ForForce(GetPlayersAll(),function FloatingTextVisibilityCheck)
    -- endfunction

    -- function MakeFloatingTextVisibilityDependent takes texttag a, location b returns nothing
    -- local timer t=CreateTimer()
    -- call SaveLocationHandle(LS(),GetHandleId(t),StringHash("loc"),Location(GetLocationX(b),GetLocationY(b)))
    -- call SaveTextTagHandle(LS(),GetHandleId(t),StringHash("tt"),a)
    -- call TimerStart(t,0.25,true,function FloatingTextVisibilityUpdate)
    -- endfunction

    --//////////////////////////////////////////////////////////////////////////////////////////////////////
    function SuitRoleAbilityReAdd_Child()
        local k = GetExpiredTimer() ---@type timer
        local q = LoadReal(LS(), GetHandleId(k), StringHash("q")) ---@type real
        local a = LoadUnitHandle(LS(), GetHandleId(k), StringHash("a")) ---@type unit

        FlushChildHashtable(LS(), GetHandleId(k))
        DestroyTimer(k)
        SetUnitLifePercentBJ(a, q)

        --If the role ability of the player is that of a doctor, then add the proper PhD ability.
        if udg_RoleAbility[udg_PlayerRole[GetConvertedPlayerId(GetOwningPlayer(a))]] ~= FourCC('A00X') then
            --Role abilities. Works in any suit form!
            UnitAddAbilityBJ(udg_RoleAbility[udg_PlayerRole[GetConvertedPlayerId(GetOwningPlayer(a))]], a)
        else
            --Dr. microRole abilities!
            UnitAddAbilityBJ(udg_Dr_RoleAbility[udg_Researcher_PhD[GetConvertedPlayerId(GetOwningPlayer(a))]], a)
        end


        --Do not mix up Human Form and Human Form (Spawn), or Alien Form and Alien Form (Spawn)
        if (GetOwningPlayer(a) == udg_Parasite) then
            --If peasant -> alien form ability
            if GetUnitTypeId(a) == FourCC('h00H') then
                UnitAddAbilityBJ(FourCC('A02O'), a)

                --Else if manipulation tree -> alien form ability anyway
            elseif udg_ParasiteUpgradingTo == FourCC('h02V') or udg_ParasiteUpgradingTo == FourCC('h033') then
                UnitAddAbilityBJ(FourCC('A02O'), a)
            end
        end

        --Alien spawn form.
        if udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(a))] and udg_HiddenAndroid ~= GetOwningPlayer(a) then
            if GetUnitTypeId(a) == FourCC('h00H') then
                UnitAddAbilityBJ(FourCC('A02W'), a)
            elseif udg_ParasiteUpgradingTo == FourCC('h02V') or udg_ParasiteUpgradingTo == FourCC('h033') then
                UnitAddAbilityBJ(FourCC('A02W'), a)
            end
        end

        --Devour, for mutants in unsuited form.
        if (GetOwningPlayer(a) == udg_Mutant) and GetUnitTypeId(a) == FourCC('h00H') then
            UnitAddAbilityBJ(FourCC('A05M'), a)
        end

        if udg_HiddenAndroid == GetOwningPlayer(a) then
            --Android tooltip. Unsuited form not necessary here.
            UnitAddAbilityBJ(FourCC('A05Z'), a)
        end
    end

    function SuitRoleAbilityReAdd()
        --This JASS function is called at the end of the trigger to put on a suit. What it does basically is adds all the abilities and such
        --that go with an unsuited unit back to the unit taking off their suit. It does so with a timer and a period of about 0.1, which seems
        --near the minimum amount of time that the Chaos ability needs to be able to have abilities added to the transformed unit.
        --Actual unit transformation is done with the chaos ability by the way.
        local a = udg_TempUnit ---@type unit
        local q = udg_TempReal ---@type real
        local k = CreateTimer() ---@type timer
        PauseUnitForPeriod(a, 0.1)
        UnitAddAbilityForPeriod(a, FourCC('Avul'), 0.1)
        --Readds 'role abilities' after a suit is dropped or put on.
        --Also re-adds transformation ability for aliens.
        SaveReal(LS(), GetHandleId(k), StringHash("q"), q)
        SaveUnitHandle(LS(), GetHandleId(k), StringHash("a"), a)
        TimerStart(k, 0.2, false, SuitRoleAbilityReAdd_Child)
    end

    ---@param soundName string
    ---@param x real
    ---@param y real
    function PlaySound3D(soundName, x, y)
        local soundHandle = CreateSound(soundName, false, true, true, 12700, 12700, "") ---@type sound
        SetSoundPosition(soundHandle, x, y, 0)
        StartSound(soundHandle)
        KillSoundWhenDone(soundHandle)
    end

    function SmashCancelSmash()
        local t = GetTriggeringTrigger() ---@type trigger
        local a = LoadUnitHandle(LS(), GetHandleId(t), StringHash("unit")) ---@type unit
        local d = LoadUnitHandle(LS(), GetHandleId(t), StringHash("tsfx")) ---@type unit
        RemoveUnit(d)
        SetUnitState(a, UNIT_STATE_MANA, GetUnitState(a, UNIT_STATE_MANA) + 35.0)
        SaveBoolean(LS(), GetHandleId(a), StringHash("Smash_Casting"), false)
        FlushChildHashtable(LS(), GetHandleId(t))
        DestroyTrigger(t)
    end

    ---@param a unit
    ---@return boolean
    function SmashCheckEnsure(a)
        local c = GetUnitLoc(a) ---@type location
        local b = DistanceBetweenPoints(c, LoadLocationHandle(LS(), GetHandleId(a), StringHash("Smash_Location"))) <
            125.0 and LoadBoolean(LS(), GetHandleId(a), StringHash("Smash_Casting")) ---@type boolean
        RemoveLocation(c)
        return b
    end

    ---@param a unit
    function SmashCheckCleanup(a)
        local t = LoadTriggerHandle(LS(), GetHandleId(a), StringHash("Smash_Trigger")) ---@type trigger
        local d = LoadUnitHandle(LS(), GetHandleId(t), StringHash("tsfx")) ---@type unit
        RemoveUnit(d)
        FlushChildHashtable(LS(), GetHandleId(t))
        DestroyTrigger(t)
        RemoveLocation(LoadLocationHandle(LS(), GetHandleId(a), StringHash("Smash_Location")))
    end

    ---@param a unit
    function SmashEnsureNoOrders(a)
        local t = CreateTrigger() ---@type trigger
        local b = GetUnitLoc(a) ---@type location
        local c = GetSpellTargetLoc() ---@type location
        local d = CreateScaledEffect2("Abilities\\Spells\\NightElf\\TrueshotAura\\TrueshotAura.mdl", 1.6, 4.0,
            GetLocationX(c), GetLocationY(c)) ---@type unit
        RemoveLocation(c)
        SaveLocationHandle(LS(), GetHandleId(a), StringHash("Smash_Location"), b)
        SaveBoolean(LS(), GetHandleId(a), StringHash("Smash_Casting"), true)
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("unit"), a)
        SaveTriggerHandle(LS(), GetHandleId(a), StringHash("Smash_Trigger"), t)
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("tsfx"), d)
        TriggerRegisterUnitEvent(t, a, EVENT_UNIT_ISSUED_TARGET_ORDER)
        TriggerRegisterUnitEvent(t, a, EVENT_UNIT_ISSUED_POINT_ORDER)
        TriggerRegisterUnitEvent(t, a, EVENT_UNIT_ISSUED_ORDER)
        TriggerRegisterUnitEvent(t, a, EVENT_UNIT_USE_ITEM)
        TriggerAddAction(t, SmashCancelSmash)
    end

    function CheckMaintainConsoleControl_Child()
        if GetOwningPlayer(GetEnumUnit()) == GetOwningPlayer(udg_TempUnit) and SubStringBJ(I2S(GetUnitPointValue(GetEnumUnit())), 1, 1) == "2" and IsUnitIllusion(GetEnumUnit()) == false then
            udg_TempBool = true
        end
    end

    function CheckMaintainConsoleControl()
        local t      = GetExpiredTimer() ---@type timer
        local p1     = LoadUnitHandle(LS(), GetHandleId(t), StringHash("p1")) ---@type unit
        local p2     = LoadUnitHandle(LS(), GetHandleId(t), StringHash("p2")) ---@type unit
        local r      = LoadRectHandle(LS(), GetHandleId(t), StringHash("rect")) ---@type rect
        local g      = GetUnitsInRectAll(r) ---@type group
        udg_TempBool = false
        udg_TempUnit = p1
        ForGroup(g, CheckMaintainConsoleControl_Child)
        DestroyGroup(g)

        if udg_TempBool == false then
            FlushChildHashtable(LS(), GetHandleId(t))
            PauseTimer(t)
            DestroyTimer(t)
            SetUnitOwner(p1, Player(PLAYER_NEUTRAL_PASSIVE), false)
            SetUnitOwner(p2, Player(PLAYER_NEUTRAL_PASSIVE), false)
        end
    end

    ---@param p1 unit
    ---@param p2 unit
    ---@param r rect
    function CheckConsoleControl(p1, p2, r)
        local t = CreateTimer() ---@type timer
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("p1"), p1)
        SaveUnitHandle(LS(), GetHandleId(t), StringHash("p2"), p2)
        SaveRectHandle(LS(), GetHandleId(t), StringHash("rect"), r)
        TimerStart(t, 1.0, true, CheckMaintainConsoleControl)
    end

    function BloodTestingWipe()
        --Searches to every inventory and deletes blood tests(and for shops) + GIT resolver.
        --Gets triggered at GITResolve trigger, when an resolver is used near GIT.(after it passes the range check)
        local i ---@type integer
        local itemslot ---@type integer
        i = 1

        --call DisplayTextToForce( GetPlayersAll(), "Wiping bloodtests on every unit!")// Debug msg

        --Playerhero loop
        repeat
            itemslot = 0
            repeat -- Inventory loop
                --If GIT Resolver or Genetic Testing Device
                if ((GetItemTypeId(UnitItemInSlot(udg_Playerhero[i], itemslot)) == FourCC('I019')) or (GetItemTypeId(UnitItemInSlot(udg_Playerhero[i], itemslot)) == FourCC('I00M'))) then
                    RemoveItem(UnitItemInSlot(udg_Playerhero[i], itemslot))
                end
                itemslot = itemslot + 1
            until itemslot == 7
            i = i + 1
            --call DisplayTextToForce( GetPlayersAll(), "i is:" + I2S(i))// Debug msg
        until i == 13

        --call DisplayTextToForce( GetPlayersAll(), "Got out!")// Debug msg

        --Vendor/Shops removal
        RemoveItemFromAllStock(FourCC('I00M'))
    end

    ---@return integer
    function GetMasqueradeShopCount()
        local i ---@type integer
        i = 0

        while true do
            if (udg_MasqueradedShop[i] ~= nil) then
                i = i + 1
            end

            if i == 5 then break end --[4] is max
        end

        return i
    end

    ---@param shop unit
    function SetMasqueradeShop(shop)
        local i ---@type integer
        i = 0

        while true do
            if (udg_MasqueradedShop[i] == nil) then
                udg_MasqueradedShop[i] = shop
                return
            end

            i = i + 1
            if i == 5 then break end --[4] is max
        end
    end

    --Normally, should compare by unit-type, but whatever.
    ---@return unit
    function ReturnMasqueradeShop()
        local i ---@type integer
        local returnedShop ---@type unit
        i = 0

        while true do
            if (udg_MasqueradedShop[i] ~= nil) then
                returnedShop = udg_MasqueradedShop[i]
                udg_MasqueradedShop[i] = nil
                return returnedShop
            end

            i = i + 1
            if i == 5 then break end --[4] is max
        end

        --Should never reach here, since it gets in here only when a structure is masqueraded.
        return nil
    end

    --Credits to Tal0n for RunCinematicUnstuck functions
    ---@param p player
    ---@param enable boolean
    function RunCinematicUnstuck(p, enable)
        if (GetLocalPlayer() == p) then    -- the player who typed -unstuck
            ClearTextMessages()            -- this can probably be disabled but it clears messages sent from triggers usually
            ShowInterface(enable, 1.5)     -- disables/enables player interface
            EnableUserControl(enable)      -- disables/enables player cursor and control
            EnableOcclusion(enable)
            EnableWorldFogBoundary(enable) -- likely fixes filter bugs
        end
    end

    ---@return boolean
    function CinematicUnstuckConditionsKappa()
        local p = GetTriggerPlayer() ---@type player
        RunCinematicUnstuck(p, false) -- calls for a set of interface toggles offward
        RunCinematicUnstuck(p, true)  -- calls for a set of interface toggles onward

        return true
    end

    function CinematicUnstuckInit()
        local t = CreateTrigger() ---@type trigger
        local i = 0 ---@type integer

        while i ~= 13 do                                                       -- this stops at brown ( player 12 )
            TriggerRegisterPlayerChatEvent(t, Player(i), "-unstuck", true)     -- add the command for each player
            TriggerAddCondition(t, Condition(CinematicUnstuckConditionsKappa)) -- the code for the command to work
            i = i + 1                                                          -- go from red/player to next player
        end
    end

    --Can't believe this didn't exist already.
    ---@param chosenUnit unit
    ---@return boolean
    function IsUnitPlayerHero(chosenUnit)
        local i = 0 ---@type integer

        while i ~= 12 do
            if chosenUnit == udg_Playerhero[i] then
                return true
            end
        end

        return false
    end

    --Utility function for not looping manually each time through the inventory
    ---@param inventoryUnit unit
    ---@param itemId integer
    ---@return boolean
    function RemoveItemTypeFromUnit(inventoryUnit, itemId)
        local i = 0 ---@type integer

        while i <= 5 do
            --If item slot has the item, remove it
            if (GetItemTypeId(UnitItemInSlot(inventoryUnit, i)) == itemId) then
                --call DisplayTextToForce(GetPlayersAll(), "i is: " .. I2S(i))
                UnitRemoveItemFromSlot(inventoryUnit, i)
                return true
            end

            i = i + 1
        end
        return false
    end

    --Utility function for removing an item from a unit, without even checking if it has it (since it does it inside the function)
    ---@param inventoryUnit unit
    ---@param itemId integer
    ---@return boolean
    function DetermineRemoveItemTypeFromUnit(inventoryUnit, itemId)
        if UnitHasItemOfTypeBJ(inventoryUnit, itemId) then
            RemoveItemTypeFromUnit(inventoryUnit, itemId)
            return true
        end

        return false
    end
end)
if Debug then Debug.endFile() end
