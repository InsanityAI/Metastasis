library SFXThreadClean 
    function SFXThreadClean_Child takes nothing returns nothing 
        local timer t = GetExpiredTimer() 
        call DestroyEffect(LoadEffectHandle(LS(), GetHandleId(t), StringHash("a"))) 
        call FlushChildHashtable(LS(), GetHandleId(t)) 
        call DestroyTimer(t) 
    endfunction 
    
    function SFXThreadClean takes nothing returns nothing 
        //Uses a timer for thread safety.  
        local effect a = GetLastCreatedEffectBJ() 
        local timer t = CreateTimer() 
        call TimerStart(t, 10.0, false, function SFXThreadClean_Child) 
        call SaveEffectHandle(LS(), GetHandleId(t), StringHash("a"), a) 
    endfunction 
    function SFXThreadCleanTimed takes nothing returns nothing 
        //Uses a timer for thread safety.  
        local effect a = GetLastCreatedEffectBJ() 
        local timer t = CreateTimer() 
        call TimerStart(t, udg_TempReal, false, function SFXThreadClean_Child) 
        call SaveEffectHandle(LS(), GetHandleId(t), StringHash("a"), a) 
    endfunction 
endlibrary