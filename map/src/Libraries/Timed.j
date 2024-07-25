library Timed 

    private function Ability_Remove takes nothing returns nothing 
        local timer t = GetExpiredTimer() 
        local integer ht = GetHandleId(t) 
        local unit u = LoadUnitHandle(udg_hash, ht, StringHash("Timed_Caster")) 
        local integer theability = LoadInteger(udg_hash, ht, StringHash("Timed_Ability")) 
        
        call UnitRemoveAbility(u, theability) 
        //cleanup 
        call FlushChildHashtable(udg_hash, ht) 
        call SaveTimerHandle(udg_hash, GetHandleId(u), StringHash("Timed_AbilityTimer_" + I2S(theability)), null) 
        call DestroyTimer(t) 
        set u = null 
        set t = null 
    endfunction 
    
    //This function will add an ability to u unit for u period so that if this function is called again while the unit has the ability 
    //And adds it for another duration then only the later duration will remove the ability. 
    //For example, if you wanted to code u grace period of invulnerability for 3 seconds but then had an ability that also made the caster 
    //invulnerable and both were triggered, you should use this function so that as the grace period for invulnerability ends it does not 
    //short circuit the invulnerable ability.     
    public function UnitGiveAbility takes unit u, integer theability, real duration returns nothing 
        local timer t = null 
        local integer ht 
        local integer hu = GetHandleId(u) 
        local string ta = I2S(theability) 
        
        if HaveSavedHandle(udg_hash, hu, StringHash("Timed_AbilityTimer_" + ta)) then 
            set t = LoadTimerHandle(udg_hash, hu, StringHash("Timed_AbilityTimer_" + ta)) 
        endif 
        
        if t != null then 
            if TimerGetRemaining(t) < duration then 
                //If the ability is scheduled for removal at u later date than this addition will imply, we do nothing. 
                //If not then we proceed regularly. 
                call TimerStart(t, duration, false, function Ability_Remove) 
            endif 
        else 
        
            if GetUnitAbilityLevel(u, theability) >= 1 then 
                return 
            else 
                set t = CreateTimer() 
                set ht = GetHandleId(t) 
                
                call SaveInteger(udg_hash, ht, StringHash("Timed_Ability"), theability) 
                call SaveUnitHandle(udg_hash, ht, StringHash("Timed_Caster"), u) 
                call SaveTimerHandle(udg_hash, hu, StringHash("Timed_AbilityTimer_" + ta), t) 
                call TimerStart(t, duration, false, function Ability_Remove) 
                call UnitAddAbility(u, theability) 
                
            endif 
        endif 
        set u = null 
        set t = null 
    endfunction 
    /*
    public function CinematicFilter takes player whichPlayer, real duration, blendmode bmode, string tex, real red0, real green0, real blue0, real trans0, real red1, real green1, real blue1, real trans1 returns nothing
        //A cinematic filter that can be used locally.
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
    */
    
    //================================================================================================== 

    private function Pause_Remove takes nothing returns nothing 
        local timer t = GetExpiredTimer() 
        local integer ht = GetHandleId(t) 
        local unit u = LoadUnitHandle(udg_hash, ht, StringHash("Timed_PauseUnit")) 
        
        call PauseUnit(u, false) 
        //cleanup 
        call FlushChildHashtable(udg_hash, ht) 
        call SaveTimerHandle(udg_hash, GetHandleId(u), StringHash("Timed_PauseTimer"), null) 
        call DestroyTimer(t) 
        set u = null 
        set t = null 
    endfunction 
    
    public function UnitPause takes unit u, real duration returns nothing 
        //This ability is like UnitAddAbilityForPeriod, but instead of adding an ability it pauses the unit. 
        local timer t = null 
        local integer hu = GetHandleId(u) 
        
        if HaveSavedHandle(udg_hash, hu, StringHash("Timed_PauseTimer")) then 
            set t = LoadTimerHandle(udg_hash, hu, StringHash("Timed_PauseTimer")) 
        endif 
        
        if t != null then 
            if TimerGetRemaining(t) < duration then 
                //If the ability is scheduled for removal at u later date than this addition will imply, we do nothing. 
                //If not then we proceed regularly. 
                call TimerStart(t, duration, false, function Pause_Remove) 
            endif 
        else 
            set t = CreateTimer() 
            call SaveUnitHandle(udg_hash, GetHandleId(t), StringHash("Timed_PauseUnit"), u) 
            call SaveTimerHandle(udg_hash, hu, StringHash("Timed_PauseTimer"), t) 
            call TimerStart(t, duration, false, function Pause_Remove) 
            call PauseUnit(u, true) 
        endif 
        
        set u = null 
        set t = null 
    endfunction 
    
    //==================================================================================================     
    
    private function Unit_Remove takes nothing returns nothing 
        local timer t = GetExpiredTimer() 
        local integer ht = GetHandleId(t) 
        local unit target = LoadUnitHandle(udg_hash, ht, StringHash("Timed_RemoveUnit")) 
        
        call FlushChildHashtable(udg_hash, GetHandleId(target)) 
        call RemoveUnit(target) 
        call FlushChildHashtable(udg_hash, ht) 
        call DestroyTimer(t) 
        set t = null 
        set target = null 
    endfunction 
    
    public function UnitRemove takes unit u, real duration returns nothing 
        local timer t = CreateTimer() 
        local integer ht = GetHandleId(t) 

        call SaveUnitHandle(udg_hash, ht, StringHash("Timed_RemoveUnit"), u) 
        call TimerStart(t, duration, false, function Unit_Remove) 
        
        set u = null 
        set t = null 
    endfunction 
    
    private function Effect_Remove takes nothing returns nothing 
        local timer t = GetExpiredTimer() 
        local integer ht = GetHandleId(t) 
        call DestroyEffect(LoadEffectHandle(udg_hash, ht, StringHash("Timed_RemoveEffect"))) 
        call FlushChildHashtable(udg_hash, ht) 
        call DestroyTimer(t) 
        
        set t = null 
    endfunction 
    
    public function EffectRemove takes effect e, real duration returns nothing 
        local timer t = CreateTimer() 
        local integer ht = GetHandleId(t) 

        call SaveEffectHandle(udg_hash, ht, StringHash("Timed_RemoveEffect"), e) 
        call TimerStart(t, duration, false, function Effect_Remove) 
        
        set t = null 
        set e = null 
    endfunction 
    
    private function Lightning_Remove takes nothing returns nothing 
        local timer t = GetExpiredTimer() 
        local integer ht = GetHandleId(t) 
        
        call DestroyLightning(LoadLightningHandle(udg_hash, ht, StringHash("Timed_RemoveLightning"))) 
        call FlushChildHashtable(udg_hash, ht) 
        call DestroyTimer(t) 
        
        set t = null 
    endfunction 
    
    public function LightningRemove takes lightning l, real duration returns nothing 
        local timer t = CreateTimer() 
        local integer ht = GetHandleId(t) 
        
        call SaveLightningHandle(udg_hash, ht, StringHash("Timed_RemoveLightning"), l) 
        call TimerStart(t, duration, false, function Lightning_Remove) 
        
        set t = null 
        set l = null 
    endfunction 
endlibrary