library ThorlarSpaceships 
    function GetSpaceshipIndexFromRect takes rect spaceshipInteriorRect returns integer 
        local integer i = 0 
    
        loop 
            exitwhen i > 12 
            if(spaceshipInteriorRect == udg_SpaceshipRect[i]) then 
                return i 
            endif 
            set i = i + 1 
        endloop 
    
        set i = -1 
        return i 

    endfunction 

    function GetSpaceshipIndexFromSpaceshipUnit takes unit spaceshipUnit returns integer 

        local integer i = 0 
    
        loop 
            exitwhen i > 12 
            if(spaceshipUnit == udg_SpaceshipGround[i] or spaceshipUnit == udg_SpaceshipSpace[i]) then 
                return i 
            endif 
            set i = i + 1 
        endloop 
    
        set i = -1 
        return i 

    endfunction 

    function GetSpaceshipIndexFromCoords takes real spaceshipInteriorX, real spaceshipInteriorY returns integer 

        local integer i = 0 
    
        loop 
            exitwhen i > 12 
            if(RectContainsCoords(udg_SpaceshipRect[i], spaceshipInteriorX, spaceshipInteriorY)) then 
                return i 
            endif 
            set i = i + 1 
        endloop 
    
        set i = -1 
        return i 

    endfunction 

    function GetSpaceshipIndexFromPosition takes location spaceshipInterior returns integer 
        return GetSpaceshipIndexFromCoords(GetLocationX(spaceshipInterior), GetLocationY(spaceshipInterior)) 
    endfunction 

endlibrary