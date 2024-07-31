// Timeout version 1.0 by Bribe
// Hosted at: https://www.hiveworkshop.com/threads/timeout.351618/
// Requires Table version 6: https://www.hiveworkshop.com/threads/188084/
library Timeout requires Table
    globals
        private constant boolean TEST = true
    endglobals
    struct Timeout extends array // "extends" Table

        static if TEST then
            private static boolean disableUnknownError = false
        endif

        static method operator [] takes timer obj returns Table
            static if TEST then
                local Table data = Table(thistype.typeid).get(obj)
                if obj == null then
                    call BJDebugMsg("Timeout[null timer] Error!")
                elseif data == 0 then
                    if thistype.disableUnknownError then
                        set thistype.disableUnknownError = false
                    else
                        call BJDebugMsg("Timeout[unknown timer] Error!")
                    endif
                endif
                return data
            endif
            return Table(thistype.typeid).get(obj)
        endmethod

        static method getTimer takes Table data returns timer
            static if TEST then
                local timer obj = data.timer[-1]
                if obj == null then
                    call BJDebugMsg("Timeout.getTimer(Table(" + I2S(data) + ")) -> null Error!")
                endif
                return obj
            else
                return data.timer[-1]
            endif
        endmethod

        static method restart takes timer obj, real duration, boolean isInterval, code callbackFn returns Table
            local Table data = Timeout[obj]
            static if TEST then
                local string recommendation
            endif
            if obj == null then
                return 0
            elseif data == 0 then
                set data = Table(thistype.typeid).bind(obj)
            else
                static if TEST then
                    if not data.handle.has(-1) then
                        if data.boolean[-1] then
                            set recommendation = "Use Timeout.stop(Table, false) rather than Timeout.complete() when you don't want to destroy a repeating timer."
                        else
                            set recommendation = "Use Timeout[GetExpiredTimer()] rather than Timeout.getData() when you don't want to destroy a one-shot timer."
                        endif
                        call BJDebugMsg("Timer.restart(zombie timer) -> Table(" + I2S(data) + ") Warning: " + recommendation)
                    endif
                endif
            endif
            set data.timer[-1] = obj
            set data.boolean[-1] = isInterval
            call TimerStart(obj, duration, isInterval, callbackFn)
            return data
        endmethod

        static method start takes real duration, boolean isInterval, code callbackFn returns Table
            static if TEST then
                set thistype.disableUnknownError = true
            endif
            return Timeout.restart(CreateTimer(), duration, isInterval, callbackFn)
        endmethod

        private static method asyncSelfDestruct takes nothing returns nothing
            local timer obj = GetExpiredTimer()
            call Table(thistype.typeid).forget(obj)
            call DestroyTimer(obj)
            set obj = null
        endmethod

        static method stop takes Table data, boolean destroyTimer returns Table
            local timer obj = Timeout.getTimer(data)
            if obj == null then
                return 0
            endif
            call PauseTimer(obj)
            if destroyTimer then
                call data.handle.remove(-1)
                call TimerStart(obj, 0, false, function thistype.asyncSelfDestruct)
            endif
            set obj = null
            return data
        endmethod

        static method getData takes nothing returns Table
            local Table data = Timeout[GetExpiredTimer()]
            local boolean isInterval = data.boolean[-1]
            if not isInterval then
                call Timeout.stop(data, true)
            endif
            return data
        endmethod

        static method complete takes nothing returns Table
            return Timeout.stop(Timeout[GetExpiredTimer()], true)
        endmethod
    endstruct
endlibrary