library ProgressBar uses TTBARS, ARGB, TimerUtils

    private struct Data
        TTBar bar 
        unit u
        real x
        real y
        timer t
        real time
        real timeout
        force playerForce
        boolean reverse
        boolean remove
    endstruct
    
    private function Timed_BarUpdate takes nothing returns nothing
        local integer i             = 0
        local timer t               = GetExpiredTimer()
        local Data d                = GetTimerData(t)
        local location loc          = Location(d.x,d.y)
        set d.time                  = d.time - 0.04
        
        if d.reverse then
            set d.bar.Value         = (d.time/d.timeout)*100
        else
            set d.bar.Value         = ((d.timeout-d.time)/d.timeout)*100
        endif
        
        loop
            exitwhen(i==bj_MAX_PLAYERS)
            if ( IsLocationVisibleToPlayer(loc, Player(i))) then
                call ForceAddPlayer(d.playerForce,Player(i))
            else 
                call ForceRemovePlayer(d.playerForce,Player(i))
            endif
            set i = i+1
        endloop
        call d.bar.ChangeVisibility(d.playerForce)
        if ((d.time <= 0) or (d.remove)) then
            call ReleaseTimer(d.t)
            call d.bar.FadeOut(0.02, false, 0,0)
            call DestroyForce(d.playerForce)
            call d.destroy()
        endif
    endfunction
    
    public function TimedAdd takes real x, real y, real time, string color, boolean reverse returns integer
        local integer i             = 0
        local Data d                = Data.create()
        set d.playerForce           = CreateForce()
        set d.t                     = NewTimerEx(d)
        set d.remove                = false
        set d.x                     = GetLocationX(loc)
        set d.y                     = GetLocationY(loc)
        set d.bar                   = TTBar.create("'",40,20,d.x-100,d.y,150)
        set d.time                  = time
        set d.timeout               = time
        set d.reverse               = reverse
        
        if reverse then
            set d.bar.Value =   100
        else
            set d.bar.Value =   0
        endif
        
        loop
            exitwhen(i==bj_MAX_PLAYERS)
            if ( IsLocationVisibleToPlayer(loc, Player(i))) then
                call ForceAddPlayer(d.playerForce,Player(i))
            else
                call ForceRemovePlayer(d.playerForce,Player(i))
            endif
            set i = i+1
        endloop
        
        call d.bar.ChangeVisibility(d.playerForce)
        call d.bar.SetBackground(0xFF799CA3)                //0xAARRGGBB
        call d.bar.SetForegroundString(color)               //"|cAARRGGBB"
        call TimerStart(d.t, 0.04, true, function Timed_BarUpdate)
        
        //cleanup
        set loc = null
        return d
        
    endfunction
    //==============================================================================================
    private function TimedUnit_Update takes nothing returns nothing
        local integer i             = 0
        local timer t               = GetExpiredTimer()
        local Data d                = GetTimerData(t)
        set d.time                  = d.time - 0.04
        
        if d.reverse then
            set d.bar.Value         = (d.time/d.timeout)*100
        else
            set d.bar.Value         = ((d.timeout-d.time)/d.timeout)*100
        endif
        
        loop
            exitwhen(i==bj_MAX_PLAYERS)
            if ( IsUnitVisible(d.u, Player(i))) then
                call ForceAddPlayer(d.playerForce,Player(i))
            else 
                call ForceRemovePlayer(d.playerForce,Player(i))
            endif
            set i = i+1
        endloop
        call d.bar.ChangeVisibility(d.playerForce)
        if ((d.time <= 0) or (d.remove)) then
            call ReleaseTimer(d.t)
            call d.bar.FadeOut(0.02, false, 0,0)
            call DestroyForce(d.playerForce)
            call d.destroy()
        endif
    endfunction
    
    public function TimedAttach2Unit takes unit u,real time, string color ,boolean reverse returns integer
        local integer i             = 0
        local Data d                = Data.create()
        set d.playerForce           = CreateForce()
        set d.t                     = NewTimerEx(d)
        set d.remove                = false
        set d.u                     = u
        set d.bar                   = TTBar.create("'",40,20,0,0,150)
        set d.time                  = time
        set d.timeout               = time
        set d.reverse               = reverse
        
        call d.bar.LockToUnit(u,-200,0, 50)
        if reverse then
            set d.bar.Value =   100
        else
            set d.bar.Value =   0
        endif
        
        loop
            exitwhen(i==bj_MAX_PLAYERS)
            if (IsUnitVisible(u, Player(i))) then
                call ForceAddPlayer(d.playerForce,Player(i))
            else
                call ForceRemovePlayer(d.playerForce,Player(i))
            endif
            set i = i+1
        endloop
        
        call d.bar.ChangeVisibility(d.playerForce)
        call d.bar.SetBackground(0xFF799CA3)                //0xAARRGGBB
        call d.bar.SetForegroundString(color)               //"|cAARRGGBB"
        call TimerStart(d.t, 0.04, true, function TimedUnit_Update)
        
        //cleanup
        return d
    endfunction
    
    public function RemoveBar takes Data d returns nothing
        call PauseTimer(d.t)
        call ReleaseTimer(d.t)
        call d.bar.FadeOut(0.00, false, 0,0)
        call DestroyForce(d.playerForce)
        call d.destroy()
    endfunction
    
    function Timed_DeleteBar takes nothing returns nothing
        local timer t               = GetExpiredTimer()
        local Data d                = GetTimerData(t)
        call ReleaseTimer(d.t)
        
        call DestroyForce(d.playerForce)
        call d.destroy()
    endfunction
    
    public function CreateBar takes real x, real y, real duration, string color,real percent returns integer
        local integer i             = 0
        local Data d                = Data.create()
        local location l            = Location(x,y)
        set d.playerForce           = CreateForce()
        set d.t                     = NewTimerEx(d)
        set d.x                     = x
        set d.y                     = y
        set d.bar                   = TTBar.create("I",30,10,d.x-100,d.y,150)
        set d.time                  = duration
        
        set d.bar.Value             = percent
        
        loop
            exitwhen(i==bj_MAX_PLAYERS)
            if ( IsLocationVisibleToPlayer(l, Player(i))) then
                call ForceAddPlayer(d.playerForce,Player(i))
            else
                call ForceRemovePlayer(d.playerForce,Player(i))
            endif
            set i = i+1
        endloop
        
        call d.bar.ChangeVisibility(d.playerForce)
        call d.bar.SetBackground(0xFF799CA3)                //0xAARRGGBB
        call d.bar.SetForegroundString(color)               //"|cAARRGGBB"
        call d.bar.FadeOut(0.5,true,0,0)
        call TimerStart(d.t, duration, true, function Timed_DeleteBar)
        
        //cleanup
        call RemoveLocation(l)
        set l = null
        return d
    endfunction
    
endlibrary
