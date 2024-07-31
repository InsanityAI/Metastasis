library Clock initializer init requires StateGrid 
    globals 
        private timer clockTimer 
        public integer seconds = 0 
        public integer minutes = 0 
        public integer hours = 0 
        public boolean showHours = false //automatically activated if minutes pass the 60 mark
        public string formattedTime = "00:00"
        public string formattedSeconds = "00"
        public string formattedMinutes = "00"
    endglobals 

    private function incrementTime takes nothing returns nothing 
        set seconds = seconds + 1 
        if seconds >= 60 then 
            set minutes = minutes + 1 
            set seconds = 0 
        endif 
        if minutes >= 60 then 
            set hours = hours + 1 
            set minutes = 0 
            set showHours = true 
        endif 

        if seconds < 10 then 
            set formattedSeconds = "0" + I2S(seconds) 
        else 
            set formattedSeconds = I2S(seconds) 
        endif 

        if minutes < 10 then 
            set formattedMinutes = "0" + I2S(minutes) 
        else 
            set formattedMinutes = I2S(minutes) 
        endif 
        if showHours then // we don't expect the game to run double-digit hours long 
            set formattedTime = "0" + I2S(hours) + ":" + formattedMinutes + ":" + formattedSeconds 
        else 
            set formattedTime = formattedMinutes + ":" + formattedSeconds 
        endif 

        call StateGrid_UpdateTime(formattedTime) 
    endfunction 

    private function init takes nothing returns nothing 
        set clockTimer = CreateTimer() 
        call TimerStart(clockTimer, 1, true, function incrementTime) 
    endfunction 

endlibrary