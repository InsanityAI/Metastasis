//------------------------
//----| String Width |----
//------------------------

//Copied from DebugUtils for Lua

/*
    offers functions to measure the width of a string (i.e. the space it takes on screen, not the number of chars). Wc3 font is not monospace, so the system below has protocolled every char width and simply sums up all chars in a string.
    output measures are:
    1. Multiboard-width (i.e. 1-based screen share used in Multiboards column functions)
    2. Line-width for screen prints
    every unknown char will be treated as having default width (see constants below)
*/

library StringWidth initializer Init
    //----------------------------
    //----| String Width API |----
    //----------------------------

    globals
        hashtable multiboardCharTable                        // saves the width in screen percent (on 1920 pixel width resolutions) that each char takes up, when displayed in a multiboard.
        real DEFAULT_MULTIBOARD_CHAR_WIDTH = 1. / 128.      // used for unknown chars (where we didn't define a width in the char table)
        real MULTIBOARD_TO_PRINT_FACTOR = 1. / 36.          // 36 is actually the lower border (longest width of a non-breaking string only consisting of the letter "i")
    endglobals

    //  Gives the width of a char in a multiboard, when inputting a char (string of length 1) and 0 otherwise.
    //  also returns 0 for non-recorded chars (like ` and ´ and ß and § and €)
    //      char string | integer integer bytecode representations of chars are also allowed, i.e. the results of string.byte().
    //      textlanguage? '"ger"'| '"eng"' (default: 'eng'), depending on the text language in the Warcraft 3 installation settings.
    //      number
    public function getCharMultiboardWidth takes string char, integer textlanguage returns real
        local real width = LoadReal(multiboardCharTable, textlanguage, StringHash(char))
        if width == 0.0 then
            return DEFAULT_MULTIBOARD_CHAR_WIDTH
        else
            return width
        endif
    endfunction

    //  gives the width of a string in a multiboard (i.e. output is in screen percent)
    //  unknown chars will be measured with default width (see constants above)
    //       multichar string
    //       textlanguage? '"ger"'| '"eng"' (default: 'eng'), depending on the text language in the Warcraft 3 installation settings.
    //       number
    public function getTextMultiboardWidth takes string multichar, integer textlanguage returns real
        local integer index = 0
        local integer stringSize = StringLength(multichar)
        local real totalWidth = 0.00
        loop
            exitwhen index >= stringSize
            
            set totalWidth = totalWidth + getCharMultiboardWidth(SubString(multichar, index, index), textlanguage)

            set index = index + 1
        endloop
        return totalWidth
    endfunction

    public function substringTextToMultiboardWidth takes string multichar, integer textlanguage, real width returns string
        local integer index = 0
        local integer stringSize = StringLength(multichar)
        local real charWidth = 0.00
        local real totalWidth = 0.00
        local boolean overflow = false
        loop
            exitwhen index >= stringSize
            set charWidth = getCharMultiboardWidth(SubString(multichar, index, index), textlanguage)
            set overflow = totalWidth >= width
            exitwhen overflow
            set index = index + 1
        endloop

        if overflow then
            set index = index - 1
        endif
        return SubString(multichar, 0, index)
    endfunction

    //  The function should match the following criteria: If the value returned by this function is smaller than 1.0, than the string fits into a single line on screen.
    //  The opposite is not necessarily true (but should be true in the majority of cases): If the function returns bigger than 1.0, the string doesn't necessarily break.
    //      @param char string | integer integer bytecode representations of chars are also allowed, i.e. the results of string.byte().
    //      @param textlanguage? '"ger"'| '"eng"' (default: 'eng'), depending on the text language in the Warcraft 3 installation settings.
    //      @return number
    public function getCharWidth takes string char, integer textlanguage returns real
        return getCharMultiboardWidth(char, textlanguage) * MULTIBOARD_TO_PRINT_FACTOR
    endfunction

    // The function should match the following criteria: If the value returned by this function is smaller than 1.0, than the string fits into a single line on screen.
    // The opposite is not necessarily true (but should be true in the majority of cases): If the function returns bigger than 1.0, the string doesn't necessarily break.
    //      @param multichar string
    //      @param textlanguage? '"ger"'| '"eng"' (default: 'eng'), depending on the text language in the Warcraft 3 installation settings.
    //      @return number
    public function getTextWidth takes string multichar, integer textlanguage returns real
        return getTextMultiboardWidth(multichar, textlanguage) * MULTIBOARD_TO_PRINT_FACTOR
    endfunction

    //----------------------------------
    //----| String Width Internals |----
    //----------------------------------

    //  charset '"ger"'| '"eng"' (default: 'eng'), depending on the text language in the Warcraft 3 installation settings.
    //  char string|integer either the char or its bytecode
    //  lengthInScreenWidth number
    private function setMultiboardCharWidth takes integer charset, string char, real lengthInScreenWidth returns nothing
        call SaveReal(multiboardCharTable, charset, StringHash(char), lengthInScreenWidth)
    endfunction

    // numberPlacements says how often the char can be placed in a multiboard column, before reaching into the right bound.
    //  charset '"ger"'| '"eng"' (default: 'eng'), depending on the text language in the Warcraft 3 installation settings.
    //  char string|integer either the char or its bytecode
    //  numberPlacements integer
    private function setMultiboardCharWidthBase80 takes integer charset, string char, integer numberPlacements returns nothing
        call setMultiboardCharWidth(charset, char, 0.8 / numberPlacements) //1-based measure. 80./numberPlacements would result in Screen Percent.
        //setMultiboardCharWidth(charset, char:byte(1,-1), 0.8 / numberPlacements) // not supported
    endfunction

    private function Init takes nothing returns nothing
        set multiboardCharTable = InitHashtable()
        // Set Char Width for all printable ascii chars in screen width (1920 pixels). Measured on a 80percent screen width multiboard column by counting the number of chars that fit into it.
        // Font size differs by text install language and patch (1.32- vs. 1.33+)
        /*if function BlzGetUnitOrderCount != null then //identifies patch 1.33+
            //German font size for patch 1.33+
            call setMultiboardCharWidthBase80(1, "a", 144)
            call setMultiboardCharWidthBase80(1, "b", 131)
            call setMultiboardCharWidthBase80(1, "c", 144)
            call setMultiboardCharWidthBase80(1, "d", 120)
            call setMultiboardCharWidthBase80(1, "e", 131)
            call setMultiboardCharWidthBase80(1, "f", 240)
            call setMultiboardCharWidthBase80(1, "g", 120)
            call setMultiboardCharWidthBase80(1, "h", 131)
            call setMultiboardCharWidthBase80(1, "i", 288)
            call setMultiboardCharWidthBase80(1, "j", 288)
            call setMultiboardCharWidthBase80(1, "k", 144)
            call setMultiboardCharWidthBase80(1, "l", 288)
            call setMultiboardCharWidthBase80(1, "m", 85)
            call setMultiboardCharWidthBase80(1, "n", 131)
            call setMultiboardCharWidthBase80(1, "o", 120)
            call setMultiboardCharWidthBase80(1, "p", 120)
            call setMultiboardCharWidthBase80(1, "q", 120)
            call setMultiboardCharWidthBase80(1, "r", 206)
            call setMultiboardCharWidthBase80(1, "s", 160)
            call setMultiboardCharWidthBase80(1, "t", 206)
            call setMultiboardCharWidthBase80(1, "u", 131)
            call setMultiboardCharWidthBase80(1, "v", 131)
            call setMultiboardCharWidthBase80(1, "w", 96)
            call setMultiboardCharWidthBase80(1, "x", 144)
            call setMultiboardCharWidthBase80(1, "y", 131)
            call setMultiboardCharWidthBase80(1, "z", 144)
            call setMultiboardCharWidthBase80(1, "A", 103)
            call setMultiboardCharWidthBase80(1, "B", 120)
            call setMultiboardCharWidthBase80(1, "C", 111)
            call setMultiboardCharWidthBase80(1, "D", 103)
            call setMultiboardCharWidthBase80(1, "E", 144)
            call setMultiboardCharWidthBase80(1, "F", 160)
            call setMultiboardCharWidthBase80(1, "G", 96)
            call setMultiboardCharWidthBase80(1, "H", 96)
            call setMultiboardCharWidthBase80(1, "I", 240)
            call setMultiboardCharWidthBase80(1, "J", 240)
            call setMultiboardCharWidthBase80(1, "K", 120)
            call setMultiboardCharWidthBase80(1, "L", 144)
            call setMultiboardCharWidthBase80(1, "M", 76)
            call setMultiboardCharWidthBase80(1, "N", 96)
            call setMultiboardCharWidthBase80(1, "O", 90)
            call setMultiboardCharWidthBase80(1, "P", 131)
            call setMultiboardCharWidthBase80(1, "Q", 90)
            call setMultiboardCharWidthBase80(1, "R", 120)
            call setMultiboardCharWidthBase80(1, "S", 131)
            call setMultiboardCharWidthBase80(1, "T", 144)
            call setMultiboardCharWidthBase80(1, "U", 103)
            call setMultiboardCharWidthBase80(1, "V", 120)
            call setMultiboardCharWidthBase80(1, "W", 76)
            call setMultiboardCharWidthBase80(1, "X", 111)
            call setMultiboardCharWidthBase80(1, "Y", 120)
            call setMultiboardCharWidthBase80(1, "Z", 120)
            call setMultiboardCharWidthBase80(1, "1", 144)
            call setMultiboardCharWidthBase80(1, "2", 120)
            call setMultiboardCharWidthBase80(1, "3", 120)
            call setMultiboardCharWidthBase80(1, "4", 120)
            call setMultiboardCharWidthBase80(1, "5", 120)
            call setMultiboardCharWidthBase80(1, "6", 120)
            call setMultiboardCharWidthBase80(1, "7", 131)
            call setMultiboardCharWidthBase80(1, "8", 120)
            call setMultiboardCharWidthBase80(1, "9", 120)
            call setMultiboardCharWidthBase80(1, "0", 120)
            call setMultiboardCharWidthBase80(1, ":", 288)
            call setMultiboardCharWidthBase80(1, ";", 288)
            call setMultiboardCharWidthBase80(1, ".", 288)
            call setMultiboardCharWidthBase80(1, "#", 120)
            call setMultiboardCharWidthBase80(1, ",", 288)
            call setMultiboardCharWidthBase80(1, " ", 286) //space
            call setMultiboardCharWidthBase80(1, "'", 180)
            call setMultiboardCharWidthBase80(1, "!", 180)
            call setMultiboardCharWidthBase80(1, "$", 131)
            call setMultiboardCharWidthBase80(1, "&", 90)
            call setMultiboardCharWidthBase80(1, "/", 180)
            call setMultiboardCharWidthBase80(1, "(", 240)
            call setMultiboardCharWidthBase80(1, ")", 240)
            call setMultiboardCharWidthBase80(1, "=", 120)
            call setMultiboardCharWidthBase80(1, "?", 144)
            call setMultiboardCharWidthBase80(1, "^", 144)
            call setMultiboardCharWidthBase80(1, "<", 144)
            call setMultiboardCharWidthBase80(1, ">", 144)
            call setMultiboardCharWidthBase80(1, "-", 180)
            call setMultiboardCharWidthBase80(1, "+", 120)
            call setMultiboardCharWidthBase80(1, "*", 180)
            call setMultiboardCharWidthBase80(1, "|", 287) //2 vertical bars in a row escape to one. So you could print 960 ones in a line, 480 would display. Maybe need to adapt to this before calculating string width.
            call setMultiboardCharWidthBase80(1, "~", 111)
            call setMultiboardCharWidthBase80(1, "{", 240)
            call setMultiboardCharWidthBase80(1, "}", 240)
            call setMultiboardCharWidthBase80(1, "[", 240)
            call setMultiboardCharWidthBase80(1, "]", 240)
            call setMultiboardCharWidthBase80(1, "_", 144)
            call setMultiboardCharWidthBase80(1, "\x25", 103) //percent
            call setMultiboardCharWidthBase80(1, "\x5C", 205) //backslash
            call setMultiboardCharWidthBase80(1, "\x22", 120) //double quotation mark
            call setMultiboardCharWidthBase80(1, "\x40", 90)  //at sign
            call setMultiboardCharWidthBase80(1, "\x60", 144) //Gravis (Accent)

            //English font size for patch 1.33+
            call setMultiboardCharWidthBase80(0, "a", 144)
            call setMultiboardCharWidthBase80(0, "b", 120)
            call setMultiboardCharWidthBase80(0, "c", 131)
            call setMultiboardCharWidthBase80(0, "d", 120)
            call setMultiboardCharWidthBase80(0, "e", 120)
            call setMultiboardCharWidthBase80(0, "f", 240)
            call setMultiboardCharWidthBase80(0, "g", 120)
            call setMultiboardCharWidthBase80(0, "h", 120)
            call setMultiboardCharWidthBase80(0, "i", 288)
            call setMultiboardCharWidthBase80(0, "j", 288)
            call setMultiboardCharWidthBase80(0, "k", 144)
            call setMultiboardCharWidthBase80(0, "l", 288)
            call setMultiboardCharWidthBase80(0, "m", 80)
            call setMultiboardCharWidthBase80(0, "n", 120)
            call setMultiboardCharWidthBase80(0, "o", 111)
            call setMultiboardCharWidthBase80(0, "p", 111)
            call setMultiboardCharWidthBase80(0, "q", 111)
            call setMultiboardCharWidthBase80(0, "r", 206)
            call setMultiboardCharWidthBase80(0, "s", 160)
            call setMultiboardCharWidthBase80(0, "t", 206)
            call setMultiboardCharWidthBase80(0, "u", 120)
            call setMultiboardCharWidthBase80(0, "v", 144)
            call setMultiboardCharWidthBase80(0, "w", 90)
            call setMultiboardCharWidthBase80(0, "x", 131)
            call setMultiboardCharWidthBase80(0, "y", 144)
            call setMultiboardCharWidthBase80(0, "z", 144)
            call setMultiboardCharWidthBase80(0, "A", 103)
            call setMultiboardCharWidthBase80(0, "B", 120)
            call setMultiboardCharWidthBase80(0, "C", 103)
            call setMultiboardCharWidthBase80(0, "D", 96)
            call setMultiboardCharWidthBase80(0, "E", 131)
            call setMultiboardCharWidthBase80(0, "F", 160)
            call setMultiboardCharWidthBase80(0, "G", 96)
            call setMultiboardCharWidthBase80(0, "H", 90)
            call setMultiboardCharWidthBase80(0, "I", 240)
            call setMultiboardCharWidthBase80(0, "J", 240)
            call setMultiboardCharWidthBase80(0, "K", 120)
            call setMultiboardCharWidthBase80(0, "L", 131)
            call setMultiboardCharWidthBase80(0, "M", 76)
            call setMultiboardCharWidthBase80(0, "N", 90)
            call setMultiboardCharWidthBase80(0, "O", 85)
            call setMultiboardCharWidthBase80(0, "P", 120)
            call setMultiboardCharWidthBase80(0, "Q", 85)
            call setMultiboardCharWidthBase80(0, "R", 120)
            call setMultiboardCharWidthBase80(0, "S", 131)
            call setMultiboardCharWidthBase80(0, "T", 144)
            call setMultiboardCharWidthBase80(0, "U", 96)
            call setMultiboardCharWidthBase80(0, "V", 120)
            call setMultiboardCharWidthBase80(0, "W", 76)
            call setMultiboardCharWidthBase80(0, "X", 111)
            call setMultiboardCharWidthBase80(0, "Y", 120)
            call setMultiboardCharWidthBase80(0, "Z", 111)
            call setMultiboardCharWidthBase80(0, "1", 103)
            call setMultiboardCharWidthBase80(0, "2", 111)
            call setMultiboardCharWidthBase80(0, "3", 111)
            call setMultiboardCharWidthBase80(0, "4", 111)
            call setMultiboardCharWidthBase80(0, "5", 111)
            call setMultiboardCharWidthBase80(0, "6", 111)
            call setMultiboardCharWidthBase80(0, "7", 111)
            call setMultiboardCharWidthBase80(0, "8", 111)
            call setMultiboardCharWidthBase80(0, "9", 111)
            call setMultiboardCharWidthBase80(0, "0", 111)
            call setMultiboardCharWidthBase80(0, ":", 288)
            call setMultiboardCharWidthBase80(0, ";", 288)
            call setMultiboardCharWidthBase80(0, ".", 288)
            call setMultiboardCharWidthBase80(0, "#", 103)
            call setMultiboardCharWidthBase80(0, ",", 288)
            call setMultiboardCharWidthBase80(0, " ", 286) //space
            call setMultiboardCharWidthBase80(0, "'", 360)
            call setMultiboardCharWidthBase80(0, "!", 288)
            call setMultiboardCharWidthBase80(0, "$", 131)
            call setMultiboardCharWidthBase80(0, "&", 120)
            call setMultiboardCharWidthBase80(0, "/", 180)
            call setMultiboardCharWidthBase80(0, "(", 206)
            call setMultiboardCharWidthBase80(0, ")", 206)
            call setMultiboardCharWidthBase80(0, "=", 111)
            call setMultiboardCharWidthBase80(0, "?", 180)
            call setMultiboardCharWidthBase80(0, "^", 144)
            call setMultiboardCharWidthBase80(0, "<", 111)
            call setMultiboardCharWidthBase80(0, ">", 111)
            call setMultiboardCharWidthBase80(0, "-", 160)
            call setMultiboardCharWidthBase80(0, "+", 111)
            call setMultiboardCharWidthBase80(0, "*", 144)
            call setMultiboardCharWidthBase80(0, "|", 479) //2 vertical bars in a row escape to one. So you could print 960 ones in a line, 480 would display. Maybe need to adapt to this before calculating string width.
            call setMultiboardCharWidthBase80(0, "~", 144)
            call setMultiboardCharWidthBase80(0, "{", 160)
            call setMultiboardCharWidthBase80(0, "}", 160)
            call setMultiboardCharWidthBase80(0, "[", 206)
            call setMultiboardCharWidthBase80(0, "]", 206)
            call setMultiboardCharWidthBase80(0, "_", 120)
            call setMultiboardCharWidthBase80(0, "\x25", 103) //percent
            call setMultiboardCharWidthBase80(0, "\x5C", 180) //backslash
            call setMultiboardCharWidthBase80(0, "\x22", 180) //double quotation mark
            call setMultiboardCharWidthBase80(0, "\x40", 85)  //at sign
            call setMultiboardCharWidthBase80(0, "\x60", 206) //Gravis (Accent)
        else*/
            //German font size up to patch 1.32
            call setMultiboardCharWidthBase80(1, "a", 144)
            call setMultiboardCharWidthBase80(1, "b", 144)
            call setMultiboardCharWidthBase80(1, "c", 144)
            call setMultiboardCharWidthBase80(1, "d", 131)
            call setMultiboardCharWidthBase80(1, "e", 144)
            call setMultiboardCharWidthBase80(1, "f", 240)
            call setMultiboardCharWidthBase80(1, "g", 120)
            call setMultiboardCharWidthBase80(1, "h", 144)
            call setMultiboardCharWidthBase80(1, "i", 360)
            call setMultiboardCharWidthBase80(1, "j", 288)
            call setMultiboardCharWidthBase80(1, "k", 144)
            call setMultiboardCharWidthBase80(1, "l", 360)
            call setMultiboardCharWidthBase80(1, "m", 90)
            call setMultiboardCharWidthBase80(1, "n", 144)
            call setMultiboardCharWidthBase80(1, "o", 131)
            call setMultiboardCharWidthBase80(1, "p", 131)
            call setMultiboardCharWidthBase80(1, "q", 131)
            call setMultiboardCharWidthBase80(1, "r", 206)
            call setMultiboardCharWidthBase80(1, "s", 180)
            call setMultiboardCharWidthBase80(1, "t", 206)
            call setMultiboardCharWidthBase80(1, "u", 144)
            call setMultiboardCharWidthBase80(1, "v", 131)
            call setMultiboardCharWidthBase80(1, "w", 96)
            call setMultiboardCharWidthBase80(1, "x", 144)
            call setMultiboardCharWidthBase80(1, "y", 131)
            call setMultiboardCharWidthBase80(1, "z", 144)
            call setMultiboardCharWidthBase80(1, "A", 103)
            call setMultiboardCharWidthBase80(1, "B", 131)
            call setMultiboardCharWidthBase80(1, "C", 120)
            call setMultiboardCharWidthBase80(1, "D", 111)
            call setMultiboardCharWidthBase80(1, "E", 144)
            call setMultiboardCharWidthBase80(1, "F", 180)
            call setMultiboardCharWidthBase80(1, "G", 103)
            call setMultiboardCharWidthBase80(1, "H", 103)
            call setMultiboardCharWidthBase80(1, "I", 288)
            call setMultiboardCharWidthBase80(1, "J", 240)
            call setMultiboardCharWidthBase80(1, "K", 120)
            call setMultiboardCharWidthBase80(1, "L", 144)
            call setMultiboardCharWidthBase80(1, "M", 80)
            call setMultiboardCharWidthBase80(1, "N", 103)
            call setMultiboardCharWidthBase80(1, "O", 96)
            call setMultiboardCharWidthBase80(1, "P", 144)
            call setMultiboardCharWidthBase80(1, "Q", 90)
            call setMultiboardCharWidthBase80(1, "R", 120)
            call setMultiboardCharWidthBase80(1, "S", 144)
            call setMultiboardCharWidthBase80(1, "T", 144)
            call setMultiboardCharWidthBase80(1, "U", 111)
            call setMultiboardCharWidthBase80(1, "V", 120)
            call setMultiboardCharWidthBase80(1, "W", 76)
            call setMultiboardCharWidthBase80(1, "X", 111)
            call setMultiboardCharWidthBase80(1, "Y", 120)
            call setMultiboardCharWidthBase80(1, "Z", 120)
            call setMultiboardCharWidthBase80(1, "1", 288)
            call setMultiboardCharWidthBase80(1, "2", 131)
            call setMultiboardCharWidthBase80(1, "3", 144)
            call setMultiboardCharWidthBase80(1, "4", 120)
            call setMultiboardCharWidthBase80(1, "5", 144)
            call setMultiboardCharWidthBase80(1, "6", 131)
            call setMultiboardCharWidthBase80(1, "7", 144)
            call setMultiboardCharWidthBase80(1, "8", 131)
            call setMultiboardCharWidthBase80(1, "9", 131)
            call setMultiboardCharWidthBase80(1, "0", 131)
            call setMultiboardCharWidthBase80(1, ":", 480)
            call setMultiboardCharWidthBase80(1, ";", 360)
            call setMultiboardCharWidthBase80(1, ".", 480)
            call setMultiboardCharWidthBase80(1, "#", 120)
            call setMultiboardCharWidthBase80(1, ",", 360)
            call setMultiboardCharWidthBase80(1, " ", 288) //space
            call setMultiboardCharWidthBase80(1, "'", 480)
            call setMultiboardCharWidthBase80(1, "!", 360)
            call setMultiboardCharWidthBase80(1, "$", 160)
            call setMultiboardCharWidthBase80(1, "&", 96)
            call setMultiboardCharWidthBase80(1, "/", 180)
            call setMultiboardCharWidthBase80(1, "(", 288)
            call setMultiboardCharWidthBase80(1, ")", 288)
            call setMultiboardCharWidthBase80(1, "=", 160)
            call setMultiboardCharWidthBase80(1, "?", 180)
            call setMultiboardCharWidthBase80(1, "^", 144)
            call setMultiboardCharWidthBase80(1, "<", 160)
            call setMultiboardCharWidthBase80(1, ">", 160)
            call setMultiboardCharWidthBase80(1, "-", 144)
            call setMultiboardCharWidthBase80(1, "+", 160)
            call setMultiboardCharWidthBase80(1, "*", 206)
            call setMultiboardCharWidthBase80(1, "|", 480) //2 vertical bars in a row escape to one. So you could print 960 ones in a line, 480 would display. Maybe need to adapt to this before calculating string width.
            call setMultiboardCharWidthBase80(1, "~", 144)
            call setMultiboardCharWidthBase80(1, "{", 240)
            call setMultiboardCharWidthBase80(1, "}", 240)
            call setMultiboardCharWidthBase80(1, "[", 240)
            call setMultiboardCharWidthBase80(1, "]", 288)
            call setMultiboardCharWidthBase80(1, "_", 144)
            // call setMultiboardCharWidthBase80(1, "\x25", 111) //percent
            // call setMultiboardCharWidthBase80(1, "\x5C", 206) //backslash
            // call setMultiboardCharWidthBase80(1, "\x22", 240) //double quotation mark
            // call setMultiboardCharWidthBase80(1, "\x40", 103) //at sign
            // call setMultiboardCharWidthBase80(1, "\x60", 240) //Gravis (Accent)

            //English Font size up to patch 1.32
            call setMultiboardCharWidthBase80(0, "a", 144)
            call setMultiboardCharWidthBase80(0, "b", 120)
            call setMultiboardCharWidthBase80(0, "c", 131)
            call setMultiboardCharWidthBase80(0, "d", 120)
            call setMultiboardCharWidthBase80(0, "e", 131)
            call setMultiboardCharWidthBase80(0, "f", 240)
            call setMultiboardCharWidthBase80(0, "g", 120)
            call setMultiboardCharWidthBase80(0, "h", 131)
            call setMultiboardCharWidthBase80(0, "i", 360)
            call setMultiboardCharWidthBase80(0, "j", 288)
            call setMultiboardCharWidthBase80(0, "k", 144)
            call setMultiboardCharWidthBase80(0, "l", 360)
            call setMultiboardCharWidthBase80(0, "m", 80)
            call setMultiboardCharWidthBase80(0, "n", 131)
            call setMultiboardCharWidthBase80(0, "o", 120)
            call setMultiboardCharWidthBase80(0, "p", 120)
            call setMultiboardCharWidthBase80(0, "q", 120)
            call setMultiboardCharWidthBase80(0, "r", 206)
            call setMultiboardCharWidthBase80(0, "s", 160)
            call setMultiboardCharWidthBase80(0, "t", 206)
            call setMultiboardCharWidthBase80(0, "u", 131)
            call setMultiboardCharWidthBase80(0, "v", 144)
            call setMultiboardCharWidthBase80(0, "w", 90)
            call setMultiboardCharWidthBase80(0, "x", 131)
            call setMultiboardCharWidthBase80(0, "y", 144)
            call setMultiboardCharWidthBase80(0, "z", 144)
            call setMultiboardCharWidthBase80(0, "A", 103)
            call setMultiboardCharWidthBase80(0, "B", 120)
            call setMultiboardCharWidthBase80(0, "C", 103)
            call setMultiboardCharWidthBase80(0, "D", 103)
            call setMultiboardCharWidthBase80(0, "E", 131)
            call setMultiboardCharWidthBase80(0, "F", 160)
            call setMultiboardCharWidthBase80(0, "G", 103)
            call setMultiboardCharWidthBase80(0, "H", 96)
            call setMultiboardCharWidthBase80(0, "I", 288)
            call setMultiboardCharWidthBase80(0, "J", 240)
            call setMultiboardCharWidthBase80(0, "K", 120)
            call setMultiboardCharWidthBase80(0, "L", 131)
            call setMultiboardCharWidthBase80(0, "M", 76)
            call setMultiboardCharWidthBase80(0, "N", 96)
            call setMultiboardCharWidthBase80(0, "O", 85)
            call setMultiboardCharWidthBase80(0, "P", 131)
            call setMultiboardCharWidthBase80(0, "Q", 85)
            call setMultiboardCharWidthBase80(0, "R", 120)
            call setMultiboardCharWidthBase80(0, "S", 131)
            call setMultiboardCharWidthBase80(0, "T", 144)
            call setMultiboardCharWidthBase80(0, "U", 103)
            call setMultiboardCharWidthBase80(0, "V", 120)
            call setMultiboardCharWidthBase80(0, "W", 76)
            call setMultiboardCharWidthBase80(0, "X", 111)
            call setMultiboardCharWidthBase80(0, "Y", 120)
            call setMultiboardCharWidthBase80(0, "Z", 111)
            call setMultiboardCharWidthBase80(0, "1", 206)
            call setMultiboardCharWidthBase80(0, "2", 131)
            call setMultiboardCharWidthBase80(0, "3", 131)
            call setMultiboardCharWidthBase80(0, "4", 111)
            call setMultiboardCharWidthBase80(0, "5", 131)
            call setMultiboardCharWidthBase80(0, "6", 120)
            call setMultiboardCharWidthBase80(0, "7", 131)
            call setMultiboardCharWidthBase80(0, "8", 111)
            call setMultiboardCharWidthBase80(0, "9", 120)
            call setMultiboardCharWidthBase80(0, "0", 111)
            call setMultiboardCharWidthBase80(0, ":", 360)
            call setMultiboardCharWidthBase80(0, ";", 360)
            call setMultiboardCharWidthBase80(0, ".", 360)
            call setMultiboardCharWidthBase80(0, "#", 103)
            call setMultiboardCharWidthBase80(0, ",", 360)
            call setMultiboardCharWidthBase80(0, " ", 288) //space
            call setMultiboardCharWidthBase80(0, "'", 480)
            call setMultiboardCharWidthBase80(0, "!", 360)
            call setMultiboardCharWidthBase80(0, "$", 131)
            call setMultiboardCharWidthBase80(0, "&", 120)
            call setMultiboardCharWidthBase80(0, "/", 180)
            call setMultiboardCharWidthBase80(0, "(", 240)
            call setMultiboardCharWidthBase80(0, ")", 240)
            call setMultiboardCharWidthBase80(0, "=", 111)
            call setMultiboardCharWidthBase80(0, "?", 180)
            call setMultiboardCharWidthBase80(0, "^", 144)
            call setMultiboardCharWidthBase80(0, "<", 131)
            call setMultiboardCharWidthBase80(0, ">", 131)
            call setMultiboardCharWidthBase80(0, "-", 180)
            call setMultiboardCharWidthBase80(0, "+", 111)
            call setMultiboardCharWidthBase80(0, "*", 180)
            call setMultiboardCharWidthBase80(0, "|", 480) //2 vertical bars in a row escape to one. So you could print 960 ones in a line, 480 would display. Maybe need to adapt to this before calculating string width.
            call setMultiboardCharWidthBase80(0, "~", 144)
            call setMultiboardCharWidthBase80(0, "{", 240)
            call setMultiboardCharWidthBase80(0, "}", 240)
            call setMultiboardCharWidthBase80(0, "[", 240)
            call setMultiboardCharWidthBase80(0, "]", 240)
            call setMultiboardCharWidthBase80(0, "_", 120)
            // call setMultiboardCharWidthBase80(0, "\x25", 103) //percent
            // call setMultiboardCharWidthBase80(0, "\x5C", 180) //backslash
            // call setMultiboardCharWidthBase80(0, "\x22", 206) //double quotation mark
            // call setMultiboardCharWidthBase80(0, "\x40", 96) //at sign
            // call setMultiboardCharWidthBase80(0, "\x60", 206) //Gravis (Accent)
        //endif
    endfunction
endlibrary