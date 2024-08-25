library SFXLib requires Timeout
    public function StationExplode takes unit station, integer explosionCount, real radius returns nothing
        local real centerX = GetUnitX(station)
        local real centerY = GetUnitY(station)
        local real offset
        local real angle
        loop
            exitwhen explosionCount <= 0
            set offset = GetRandomReal(0, radius)
            set angle = GetRandomReal(0, 2*bj_PI)
            //I'll assume this thing has timed life.
            call CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'e01E', centerX + offset * Cos(angle), centerY + offset * Sin(angle), bj_UNIT_FACING)
            set explosionCount = explosionCount - 1
        endloop
    endfunction

    public function UnitExplode takes unit u returns nothing
        //I'll assume this thing has timed life.
        call SetUnitAnimation(CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'e001', GetUnitX(u), GetUnitY(u), bj_UNIT_FACING), "death")
    endfunction
endlibrary