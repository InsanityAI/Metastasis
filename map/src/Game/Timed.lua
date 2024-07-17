if Debug then Debug.beginFile "Game/Timed" end
OnInit.trig("Timed", function(require)
    LIBRARY_Timed = true
    local SCOPE_PREFIX = "Timed_" ---@type string

    local function Ability_Remove()
        local t          = GetExpiredTimer() ---@type timer
        local ht         = GetHandleId(t) ---@type integer
        local u          = LoadUnitHandle(udg_hash, ht, StringHash("Timed_Caster")) ---@type unit
        local theability = LoadInteger(udg_hash, ht, StringHash("Timed_Ability")) ---@type integer

        UnitRemoveAbility(u, theability)
        --cleanup
        FlushChildHashtable(udg_hash, ht)
        SaveTimerHandle(udg_hash, GetHandleId(u), StringHash("Timed_AbilityTimer_" .. I2S(theability)), nil)
        DestroyTimer(t)
        u = nil
        t = nil
    end

    --This function will add an ability to u unit for u period so that if this function is called again while the unit has the ability
    --And adds it for another duration then only the later duration will remove the ability.
    --For example, if you wanted to code u grace period of invulnerability for 3 seconds but then had an ability that also made the caster
    --invulnerable and both were triggered, you should use this function so that as the grace period for invulnerability ends it does not
    --short circuit the invulnerable ability.
    ---@param u unit
    ---@param theability integer
    ---@param duration real
    local function UnitGiveAbility(u, theability, duration)
        local t  = nil ---@type timer
        local ht ---@type integer
        local hu = GetHandleId(u) ---@type integer
        local ta = I2S(theability) ---@type string

        if HaveSavedHandle(udg_hash, hu, StringHash("Timed_AbilityTimer_" .. ta)) then
            t = LoadTimerHandle(udg_hash, hu, StringHash("Timed_AbilityTimer_" .. ta))
        end

        if t ~= nil then
            if TimerGetRemaining(t) < duration then
                --If the ability is scheduled for removal at u later date than this addition will imply, we do nothing.
                --If not then we proceed regularly.
                TimerStart(t, duration, false, Ability_Remove)
            end
        else
            if GetUnitAbilityLevel(u, theability) >= 1 then
                return
            else
                t  = CreateTimer()
                ht = GetHandleId(t)

                SaveInteger(udg_hash, ht, StringHash("Timed_Ability"), theability)
                SaveUnitHandle(udg_hash, ht, StringHash("Timed_Caster"), u)
                SaveTimerHandle(udg_hash, hu, StringHash("Timed_AbilityTimer_" .. ta), t)
                TimerStart(t, duration, false, Ability_Remove)
                UnitAddAbility(u, theability)
            end
        end
        u = nil
        t = nil
    end
    _G[SCOPE_PREFIX .. 'UnitGiveAbility'] = UnitGiveAbility
    --[[
    public function CinematicFilter takes player whichPlayer, real duration, blendmode bmode, string tex, real red0, real green0, real blue0, real trans0, real red1, real green1, real blue1, real trans1 returns nothing
    --A cinematic filter that can be used locally.
    local timer t
        if not(HaveSavedHandle(udg_hash,GetHandleId(whichPlayer),StringHash("Timed_CFilterTimer"))) then
            set t                       = CreateTimer()
            call SaveTimerHandle(udg_hash,GetHandleId(whichPlayer),StringHash("Timed_CFilter_Timer"),t)
            call SavePlayerHandle(udg_hash,GetHandleId(t),StringHash("Timed_CFilter_Player"),whichPlayer)
            if ( GetLocalPlayer() == whichPlayer ) then

                call SetCineFilterTexture(tex)
                call SetCineFilterBlendMode(bmode)
                call SetCineFilterTexMapFlags(TEXMAP_FLAG_NONE)
                call SetCineFilterStartUV(0, 0, 1, 1)
                call SetCineFilterEndUV(0, 0, 1, 1)
                call SetCineFilterStartColor(PercentTo255(red0), PercentTo255(green0), PercentTo255(blue0), PercentTo255(100-trans0))
                call SetCineFilterEndColor(PercentTo255(red1), PercentTo255(green1), PercentTo255(blue1), PercentTo255(100-trans1))
                call SetCineFilterDuration(duration)
                call DisplayCineFilter(true)
            endif
            TimerStart(t,duration)
        endif
    endfunction
    ]]

    --==================================================================================================

    local function Pause_Remove()
        local t  = GetExpiredTimer() ---@type timer
        local ht = GetHandleId(t) ---@type integer
        local u  = LoadUnitHandle(udg_hash, ht, StringHash("Timed_PauseUnit")) ---@type unit

        PauseUnit(u, false)
        --cleanup
        FlushChildHashtable(udg_hash, ht)
        SaveTimerHandle(udg_hash, GetHandleId(u), StringHash("Timed_PauseTimer"), nil)
        DestroyTimer(t)
        u = nil
        t = nil
    end

    ---@param u unit
    ---@param duration real
    local function UnitPause(u, duration)
        --This ability is like UnitAddAbilityForPeriod, but instead of adding an ability it pauses the unit.
        local t  = nil ---@type timer
        local hu = GetHandleId(u) ---@type integer

        if HaveSavedHandle(udg_hash, hu, StringHash("Timed_PauseTimer")) then
            t = LoadTimerHandle(udg_hash, hu, StringHash("Timed_PauseTimer"))
        end

        if t ~= nil then
            if TimerGetRemaining(t) < duration then
                --If the ability is scheduled for removal at u later date than this addition will imply, we do nothing.
                --If not then we proceed regularly.
                TimerStart(t, duration, false, Pause_Remove)
            end
        else
            t = CreateTimer()
            SaveUnitHandle(udg_hash, GetHandleId(t), StringHash("Timed_PauseUnit"), u)
            SaveTimerHandle(udg_hash, hu, StringHash("Timed_PauseTimer"), t)
            TimerStart(t, duration, false, Pause_Remove)
            PauseUnit(u, true)
        end

        u = nil
        t = nil
    end
    _G[SCOPE_PREFIX .. 'UnitPause'] = UnitPause

    --==================================================================================================

    local function Unit_Remove()
        local t      = GetExpiredTimer() ---@type timer
        local ht     = GetHandleId(t) ---@type integer
        local target = LoadUnitHandle(udg_hash, ht, StringHash("Timed_RemoveUnit")) ---@type unit

        FlushChildHashtable(udg_hash, GetHandleId(target))
        RemoveUnit(target)
        FlushChildHashtable(udg_hash, ht)
        DestroyTimer(t)
        t      = nil
        target = nil
    end

    ---@param u unit
    ---@param duration real
    local function UnitRemove(u, duration)
        local t  = CreateTimer() ---@type timer
        local ht = GetHandleId(t) ---@type integer

        SaveUnitHandle(udg_hash, ht, StringHash("Timed_RemoveUnit"), u)
        TimerStart(t, duration, false, Unit_Remove)

        u = nil
        t = nil
    end
    _G[SCOPE_PREFIX .. 'UnitRemove'] = UnitRemove

    local function Effect_Remove()
        local t  = GetExpiredTimer() ---@type timer
        local ht = GetHandleId(t) ---@type integer
        DestroyEffect(LoadEffectHandle(udg_hash, ht, StringHash("Timed_RemoveEffect")))
        FlushChildHashtable(udg_hash, ht)
        DestroyTimer(t)

        t = nil
    end

    ---@param e effect
    ---@param duration real
    function EffectRemove(e, duration)
        local t  = CreateTimer() ---@type timer
        local ht = GetHandleId(t) ---@type integer

        SaveEffectHandle(udg_hash, ht, StringHash("Timed_RemoveEffect"), e)
        TimerStart(t, duration, false, Effect_Remove)

        t = nil
        e = nil
    end

    _G[SCOPE_PREFIX .. 'EffectRemove'] = EffectRemove

    local function Lightning_Remove()
        local t  = GetExpiredTimer() ---@type timer
        local ht = GetHandleId(t) ---@type integer

        DestroyLightning(LoadLightningHandle(udg_hash, ht, StringHash("Timed_RemoveLightning")))
        FlushChildHashtable(udg_hash, ht)
        DestroyTimer(t)

        t = nil
    end

    ---@param l lightning
    ---@param duration real
    local function LightningRemove(l, duration)
        local t  = CreateTimer() ---@type timer
        local ht = GetHandleId(t) ---@type integer

        SaveLightningHandle(udg_hash, ht, StringHash("Timed_RemoveLightning"), l)
        TimerStart(t, duration, false, Lightning_Remove)

        t = nil
        l = nil
    end
    _G[SCOPE_PREFIX .. 'LightningRemove'] = LightningRemove
end)
if Debug then Debug.endFile() end
