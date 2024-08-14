// *************************************************************
// *                   TTBars -- Version 1.5.0
// *                        by Deaod
// *************************************************************
// *
// *    CREDITS:
// *        - Ammorth (found a bug)
// *        - Anitarf (suggestions)
// *        - Ddyq (helped testing)
// *        - Vexorian (JassHelper, ARGB)
// *        - PitzerMike (JassNewGenPack)
// *        - Pipedream (Grimoire)
// *
// *        - cohadar (used PUI for demonstration purposes)
// *        - zwiebelchen (used a modified version of a script he wrote (CastingBar) for demonstration puposes)
// *
// *    HOW TO USE:
// *        * declare a variable of type TTBar or TTGradBar
// *            - TTGradBar only has the additional feature of adding Gradients. TTBar and TTGradBar are identical in all other regards.
// *
// *        * use [TTBar or TTGradBar].create(string char, integer numochars, real size, real x, real y, real z)
// *            - char is the basic string the bar is made out of
// *            - numochars is the number of chars this bar consits of
// *            - size is the textsize of the bar
// *            - x is the x-coord of the point where this bar is created
// *            - y is the y-coord of the point where this bar is created
// *            - z is the height offset above the ground
// *
// *        * add a gradient by using YourBar.AddGradient(real threshold, ARGB color)
// *            !! This is a feature of TTGradBar. Will not work with TTBar !!
// *            - threshold is the value the bar must be equal to or lower than to apply the color specified in colorstring
// *            - example input would be "ARGB.create(SOME_ALPHA, SOME_RED, SOME_GREEN, SOME_BLUE)" or "0xAARRGGBB"
// *              Look at ARGB's manual for detailed reference
// *            - there exists an alternative version named AddGradientString(real, threshold, string color),
// *              where the color argument is formatted as follows: "|cAARRGGBB"
// *
// *        * you can change the value of the bar at any time by using "set YourBar.Value=newval"
// *            - value is a percentage
// *              --> use 100 to fill it completely, use 0 to display an empty bar
// *
// *        * you can lock this bar to a unit using YourBar.LockToUnit(unit u, real xOffset, real yOffset, real zOffset)
// *            - u is the unit this bar is locked to
// *            - xOffset is the offset in x from the position of the unit the bar is locked to
// *            - yOffset is the offset in y from the position of the unit the bar is locked to
// *            - zOffset is the height offset above ground level
// *
// *        * of course you can also unlock the bar via YourBar.Unlock()
// *
// *        * you can change the foreground color with YourBar.SetForeground(ARGB color)
// *            !! Gradients are preferred over this !!
// *            - example input would be "ARGB.create(SOME_ALPHA, SOME_RED, SOME_GREEN, SOME_BLUE)" or "0xAARRGGBB"
// *              Look at ARGB's manual for detailed reference
// *            - there exitsts an alternative version named SetForegroundString(string color),
// *              which takes a string formatted as follows: "|cAARRGGBB"
// *
// *        * you can change the background color with YouBar.SetBackground(ARGB color)
// *            - example input would be "ARGB.create(SOME_ALPHA, SOME_RED, SOME_GREEN, SOME_BLUE)" or "0xAARRGGBB"
// *              Look at ARGB's manual for detailed reference
// *
// *        * want to show the bar to more players? Use YourBar.ChangeVisibility(force disp)
// *            - disp should contain all players this bar should be displayed to; note that you have to destroy this parameter for yourself
// *              inserting null will show the bar to all players
// *
// *        * you can change the size of the bar any time by using "set YourBar.Size=newval"
// *
// *        * you can read and write a bar's X, Y and Z coordinate by using the X, and X= operators (Y and Z respectively as well).
// *          I added another method, YourBar.SetPosXY(real x, real y), which sets the bars X and Y coordinate, for speed reasons.
// *
// *        * you have access to XOffset and YOffset members (both are of type real). They are only important when locking a bar to a unit.
// *          You can probably guess by their names what i added them for.
// *
// *        * you can read/change a bars primitive char by reading/changing the member Char
// *
// *        * you can read/change a bars number of chars by reading/changing the member Width
// *
// *        * you can fade out bars when destroying them using YourBar.FadeOut(real overTime, boolean followThrough, real xVel, real yVel)
// *            - overTime is the time fading should take
// *            - followThrough changes whether the TTBar instance should be destroyed on the spot
// *              of if it should destroy it when the fading is finished
// *              "true" destroys the TTBar instance when the fading is finished
// *              "false" destroys the TTBar instance on the spot
// *            - xVel and yVel can only be used if the Bar is not locked to a unit
// *              and move the bar into x and y direction (respectively) by the amount specified
// *
// *************************************************************

library TTBARS uses ARGB, TimerUtils

    globals
        // TTBar
        private constant    integer         DEFAULT_BACKGROUND  = 0xFF000000 // 0xAARRGGBB // alpha channel is non-functional (blame blizzard for that)
        private constant    real            TICK                = 1./64 // in seconds // how often are bars moved to a units pos?
        
        // TTBar and TTGradBar
        private constant    integer         DEFAULT_FOREGROUND  = 0xFFFFFFFF // 0xAARRGGBB
        
        // TTGradBar
        private constant    integer         MAX_GRADIENTS       = 10 // Maximum number of gradients you can add
    endglobals
    
    // I dont recommend to change anything below this line
    
    globals
        private force tmp
        private TTBar array Bars
        private integer Count=0
        private timer T=CreateTimer()
    endglobals
    
    struct TTBar
        private texttag t
        // background color
        private ARGB bg_color
        // foreground color
        private string fg_color
        // Position
        private real x
        private real y
        private real z
        // Text
        private string txt
        private real textsize
        // locking to units
        private integer lockindex
        private boolean locked
        private unit u
        real XOffset
        real YOffset
        // misc
        private force disp
        private real Value2 // value
        private integer NUM_CHARS // number of chars this bar uses
        private string char // primitive char/string
        private string ptext // primitive text without colors
        
        private static method CopyForce takes nothing returns nothing
            call ForceAddPlayer(tmp, GetEnumPlayer())
        endmethod
        
        private static method LockCallback takes nothing returns nothing
        local integer i=Count-1
        local TTBar s
            loop
                exitwhen i<0
                set s=Bars[i]
                set s.x=GetUnitX(s.u)
                set s.y=GetUnitY(s.u)
                call SetTextTagPos(s.t, s.x+s.XOffset, s.y+s.YOffset, s.z)
                set i=i-1
            endloop
        endmethod
        
        method operator Size takes nothing returns real
            return .textsize/0.0023
        endmethod
        
        method operator Size= takes real size returns nothing
            set .textsize=TextTagSize2Height(size)
        endmethod
        
        method operator Value takes nothing returns real
            return .Value2*100.
        endmethod
        
        method operator Value= takes real newval returns nothing
        local integer chars
        local integer i=0
            // keep newval inside possible boundaries
            if newval>100. then
                set newval=100.
            elseif newval<0. then
                set newval=0.
            endif
            set .Value2=newval/100. // set the new value
            set .txt=.fg_color
            set chars=(R2I((.Value2*.NUM_CHARS*StringLength(.char))+0.5)/StringLength(.char))*StringLength(.char) // calculate the number of chars needed to display the new value
            set .txt=.txt+SubString(.ptext, 0, chars)
            set .txt=.txt+"|r"
            set .txt=.txt+SubString(.ptext, 0, StringLength(.ptext)-chars)
            if .t!=null then
                call SetTextTagText(.t, .txt, .textsize)
            endif
        endmethod
        
        method operator X takes nothing returns real
            return .x
        endmethod
        
        method operator X= takes real x returns nothing
            set .x=x
            if .t!=null and not .locked then
                call SetTextTagPos(.t, .x, .y, .z)
            endif
        endmethod
        
        method operator Y takes nothing returns real
            return .y
        endmethod
        
        method operator Y= takes real y returns nothing
            set .y=y
            if .t!=null and not .locked then
                call SetTextTagPos(.t, .x, .y, .z)
            endif
        endmethod
        
        method operator Z takes nothing returns real
            return .z
        endmethod
        
        method operator Z= takes real z returns nothing
            set .z=z
            if .t!=null then
                call SetTextTagPos(.t, .x, .y, .z)
            endif
        endmethod
        
        method operator Locked takes nothing returns boolean
            return .locked
        endmethod
        
        private method RebuildText takes nothing returns nothing
        local integer i=0
            set .ptext=""
            loop
                exitwhen i>=.NUM_CHARS
                set .ptext=.ptext+.char
                set i=i+1
            endloop
        endmethod
        
        method operator Char takes nothing returns string
            return .char
        endmethod
        
        method operator Char= takes string new returns nothing
            if new=="|" then
                set new="||"
            endif
            set .char=new
            call .RebuildText()
            set .Value=.Value
        endmethod
        
        method operator Width takes nothing returns integer
            return .NUM_CHARS
        endmethod
        
        method operator Width= takes integer new returns nothing
            set .NUM_CHARS=new
            call .RebuildText()
            set .Value=.Value
        endmethod
        
        method SetPosXY takes real x, real y returns nothing // added for speed reasons
            set .x=x
            set .y=y
            if .t!=null and not .locked then
                call SetTextTagPos(.t, .x, .y, .z)
            endif
        endmethod
        
        method SetBackground takes ARGB color returns nothing
            set .bg_color=color
            if .t!=null then
                call SetTextTagColor(.t, .bg_color.red, .bg_color.green, .bg_color.blue, .bg_color.alpha)
            endif
        endmethod
        
        method SetForeground takes ARGB color returns nothing
            set .fg_color=SubString(color.str(""), 0, 10)
            set .Value=.Value
        endmethod
        
        method SetForegroundString takes string color returns nothing
            set .fg_color=color
            set .Value=.Value
        endmethod
        
        method ChangeVisibility takes force disp returns nothing
            if disp!=null then
                if .disp==null then
                    set .disp=CreateForce()
                else
                    call ForceClear(.disp)
                endif
                set tmp=.disp
                call ForForce(disp, function TTBar.CopyForce)
                if IsPlayerInForce(GetLocalPlayer(), .disp) and .t==null then
                    set .t=CreateTextTag()
                    if .t!=null then
                        call SetTextTagColor(.t, .bg_color.red, .bg_color.green, .bg_color.blue, .bg_color.alpha)
                        call SetTextTagText(.t, .txt, .textsize)
                        call SetTextTagPos(.t, .x, .y, .z)
                    debug else
                    debug     call BJDebugMsg("TTBARS: TextTag limit reached!")
                    endif
                elseif .t!=null and not IsPlayerInForce(GetLocalPlayer(), .disp) then
                    call DestroyTextTag(.t)
                    set .t=null
                endif
            else
                if .t==null then
                    set .t=CreateTextTag()
                    if .t!=null then
                        call SetTextTagColor(.t, .bg_color.red, .bg_color.green, .bg_color.blue, .bg_color.alpha)
                        call SetTextTagText(.t, .txt, .textsize)
                        call SetTextTagPos(.t, .x, .y, .z)
                    debug else
                    debug     call BJDebugMsg("TTBARS: TextTag limit reached!")
                    endif
                endif
            endif
        endmethod
        
        method LockToUnit takes unit u, real xOffset, real yOffset, real zOffset returns nothing
            if not .locked then
                set Bars[Count]=this
                set .u=u
                set .locked=true
                set .lockindex=Count
                set .XOffset=xOffset
                set .YOffset=yOffset
                set .Z=zOffset
                if Count==0 then
                    call TimerStart(T, TICK, true, function thistype.LockCallback)
                endif
                set Count=Count+1
            endif
        endmethod
        
        method Unlock takes nothing returns nothing
        local integer i=0
            if not .locked then
                return
            endif
            set Count=Count-1
            if Count==0 then
                call PauseTimer(T)
            endif
            set Bars[.lockindex]=Bars[Count]
            set Bars[Count].lockindex=.lockindex
            set .locked=false
        endmethod
        
        static method create takes string char, integer numochars, real size, real x, real y, real z returns TTBar
        local TTBar s=TTBar.allocate()
            set s.t=CreateTextTag()
            debug if s.t==null then
            debug     call BJDebugMsg("TTBARS: TextTag limit reached!")
            debug endif
            set s.bg_color=ARGB(DEFAULT_BACKGROUND)
            set s.x=x
            set s.y=y
            set s.z=z
            set s.textsize=TextTagSize2Height(size)
            set s.fg_color=SubString(ARGB(DEFAULT_FOREGROUND).str(""), 0, 10)
            set s.NUM_CHARS=numochars
            if char=="|" then // ugly hack
                set s.char="||"
            else
                set s.char=char
            endif
            set s.locked=false
            set s.Value=0
            if s.t!=null then
                call SetTextTagPos(s.t, s.x, s.y, s.z)
                call SetTextTagColor(s.t, s.bg_color.red, s.bg_color.green, s.bg_color.blue, s.bg_color.alpha)
                call SetTextTagText(s.t, s.txt, s.textsize)
            endif
            call s.RebuildText()
            return s
        endmethod
        
        method onDestroy takes nothing returns nothing
            if .t!=null then
                call DestroyTextTag(.t)
                set .t=null
            endif
            if .locked then
                call .Unlock()
                set .u=null
            endif
        endmethod
        
        private static method FadeOutCallback takes nothing returns nothing
        local thistype s=thistype(GetTimerData(GetExpiredTimer()))
            set s.t=null
            call s.destroy()
            call ReleaseTimer(GetExpiredTimer())
        endmethod
        
        method FadeOut takes real overTime, boolean followThrough, real xVel, real yVel returns nothing
        local timer t
            if .t!=null then
                call SetTextTagLifespan(.t, overTime)
                call SetTextTagAge(.t, 0)
                call SetTextTagFadepoint(.t, 0)
                call SetTextTagPermanent(.t, false)
                if not .locked then
                    call SetTextTagVelocity(.t, TextTagSpeed2Velocity(xVel), TextTagSpeed2Velocity(yVel))
                endif
            endif
            if followThrough then
                set t=NewTimer()
                call SetTimerData(t, this)
                call TimerStart(t, overTime, false, function thistype.FadeOutCallback)
            else
                set .t=null
                call .destroy()
            endif
        endmethod
    endstruct
    
    struct TTGradBar
        private delegate TTBar Bar
        
        private string fg_color
        
        private string array GradientColor[MAX_GRADIENTS]
        private real array GradientValue[MAX_GRADIENTS]
        private integer GradCnt
        
        static method create takes string char, integer numochars, real size, real x, real y, real z returns TTGradBar
        local TTGradBar s=TTGradBar.allocate()
            set s.Bar=TTBar.create(char, numochars, size, x, y, z)
            set s.GradCnt=0
            set s.fg_color=SubString(ARGB(DEFAULT_FOREGROUND).str(""), 0, 10)
            return s
        endmethod
        
        method AddGradient takes real threshold, ARGB color returns nothing
            if .GradCnt>=MAX_GRADIENTS then
                debug call BJDebugMsg("TTGradBar: Cannot add any more Gradients to TTGradBar "+I2S(this)+"!")
                return
            endif
            if threshold>100 then
                set threshold=100
            elseif threshold<0 then
                set threshold=0
            endif
            set .GradientValue[.GradCnt]=threshold
            set .GradientColor[.GradCnt]=SubString(color.str(""), 0, 10)
            set .GradCnt=.GradCnt+1
        endmethod
        
        method AddGradientString takes real threshold, string color returns nothing
            if .GradCnt>=MAX_GRADIENTS then
                debug call BJDebugMsg("TTGradBar: Cannot add any more Gradients to TTGradBar "+I2S(this)+"!")
                return
            endif
            if threshold>100 then
                set threshold=100
            elseif threshold<0 then
                set threshold=0
            endif
            set .GradientValue[.GradCnt]=threshold
            set .GradientColor[.GradCnt]=color
            set .GradCnt=.GradCnt+1
        endmethod
        
        method operator Value= takes real newval returns nothing
        local integer i=0
        local real k
        local integer j
        local integer l=0
            // keep newval inside possible boundaries
            if newval>100 then
                set newval=100
            elseif newval<0 then
                set newval=0
            endif
            set k=110 // some value above 100 will work just as well
            // find appropriate gradient
            loop
                exitwhen i>=.GradCnt
                if newval<=.GradientValue[i] and ((.GradientValue[i]-newval)<k) then
                    set k=.GradientValue[i]-newval
                    set j=i
                    set l=l+1 // count how many gradients have been considered for use
                endif
                set i=i+1
            endloop
            // colorize the bar
            if l>0 then
                call .Bar.SetForegroundString(.GradientColor[j])
            else
                call .Bar.SetForegroundString(.fg_color)
            endif
            set .Bar.Value=newval
        endmethod
        
        method SetForeground takes ARGB color returns nothing
            set .fg_color=SubString(color.str(""), 0, 10)
            set .Value=.Value
        endmethod
        
        method SetForegroundString takes string color returns nothing
            set .fg_color=color
            set .Value=.Value
        endmethod
        
        method onDestroy takes nothing returns nothing
            call .Bar.destroy()
        endmethod
    endstruct
    
endlibrary