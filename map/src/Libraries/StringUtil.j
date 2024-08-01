library StringUtil 
    //From original Metastasis script, just wrapped up in a better handling scenario, also removed ClearParseArgs from having to be used
    globals 
        public integer argc 
        public string array argv 
    endglobals 

    //Parses the string by separating it with newline symbols    
    //Fetch individual strings via argv[index], and argc to determine how many arguments there were passed    
    //index for argv is 0-indexed  
    public function ParseStringArgs takes string consoleArgs returns nothing 
        local string r = consoleArgs
        local integer lasti = 0 
        local integer i = 0 
        local integer argumenton = 0 
        local integer k = StringLength(r) 
        local integer n 
        //Divides an entered string into spaces. "-liquidate lightblue" becomes argv[0]=-liquidate and argv[1]=lightblue    
        loop 
            exitwhen i > k 
            if SubString(r, i, i + 1) == " " then 
                set n = lasti - 1 
                if n < 0 then 
                    set n = 0 
                endif 
                set argv[argumenton] = SubString(r, lasti, i) 
                set argumenton = argumenton + 1 
                set lasti = i + 1 
            endif 
            set i = i + 1 
        endloop 
        set argv[argumenton] = SubString(r, lasti, 999) 
        set argc = argumenton + 1 
    endfunction 

    //Parses the string by separating it with newline symbols up to argc amount, when amount is reached, will pack the rest of the string as final argument    
    //Fetch individual strings via argv[index] 
    //index for argv is 0-indexed  
    //e.g: ParseStringWithArgc("-liquidate light blue", 2) becomes argv[0]="-liquidate" and argv[1]="light blue" 
    public function ParseStringWithArgc takes string consoleArgs, integer argc returns nothing 
        local string r = consoleArgs
        local integer lasti = 0 
        local integer i = 0 
        local integer argumenton = 0 
        local integer k = StringLength(r) 
        local integer n 
        loop 
            exitwhen i > k 
            exitwhen argumenton >= argc - 1 
            if SubString(r, i, i + 1) == " " then 
                set n = lasti - 1 
                if n < 0 then 
                    set n = 0 
                endif 
                set argv[argumenton] = SubString(r, lasti, i) 
                set argumenton = argumenton + 1 
                set lasti = i + 1 
            endif 
            set i = i + 1 
        endloop 
        set argv[argumenton] = SubString(r, lasti, 999) 
        set argc = argc 
    endfunction 
endlibrary 