function GetSector takes location l returns integer 
    local integer x = 0 
    if RectContainsLoc(gg_rct_ST1, udg_TempPoint) == true then 
        set x = 1 
    else 
        if RectContainsLoc(gg_rct_ST2, udg_TempPoint) == true then 
            set x = 2 
        else 
            if RectContainsLoc(gg_rct_ST3, udg_TempPoint) == true then 
                set x = 3 
            else 
                if RectContainsLoc(gg_rct_ST4S2, udg_TempPoint) == true then 
                    set x = 4 
                else 
                    if RectContainsLoc(gg_rct_ST5, udg_TempPoint) == true then 
                        set x = 5 
                    else 
                        if RectContainsLoc(gg_rct_LostStation, udg_TempPoint) == true then 
                            set x = 6 
                        else 
                            if RectContainsLoc(gg_rct_PirateShip, udg_TempPoint) == true then 
                                set x = 7 
                            else 
                                if RectContainsLoc(gg_rct_Planet, udg_TempPoint) == true then 
                                    set x = 8 
                                else 
                                    if RectContainsLoc(gg_rct_SS1, udg_TempPoint) == true then 
                                        set x = 9 
                                    else 
                                        if RectContainsLoc(gg_rct_SS2, udg_TempPoint) == true then 
                                            set x = 10 
                                        else 
                                            if RectContainsLoc(gg_rct_SS3, udg_TempPoint) == true then 
                                                set x = 11 
                                            else 
                                                if RectContainsLoc(gg_rct_SS4, udg_TempPoint) == true then 
                                                    set x = 12 
                                                else 
                                                    if RectContainsLoc(gg_rct_SS5, udg_TempPoint) == true then 
                                                        set x = 13 
                                                    else 
                                                        if RectContainsLoc(gg_rct_SS6, udg_TempPoint) == true then 
                                                            set x = 14 
                                                        else 
                                                            if RectContainsLoc(gg_rct_SS7, udg_TempPoint) == true then 
                                                                set x = 15 
                                                            else 
                                                                if RectContainsLoc(gg_rct_SS8, udg_TempPoint) == true then 
                                                                    set x = 16 
                                                                else 
                                                                    if RectContainsLoc(gg_rct_SS9, udg_TempPoint) == true then 
                                                                        set x = 17 
                                                                    else 
                                                                        if RectContainsLoc(gg_rct_SS10, udg_TempPoint) == true then 
                                                                            set x = 18 
                                                                        else 
                                                                            if RectContainsLoc(gg_rct_SS11, udg_TempPoint) == true then 
                                                                                set x = 19 
                                                                            else 
                                                                                if RectContainsLoc(gg_rct_SS12, udg_TempPoint) == true then 
                                                                                    set x = 20 
                                                                                else 
                                                                                    if RectContainsLoc(gg_rct_Space, udg_TempPoint) == true then 
                                                                                        set x = 21 
                                                                                    else 
                                                                                    endif 
                                                                                endif 
                                                                            endif 
                                                                        endif 
                                                                    endif 
                                                                endif 
                                                            endif 
                                                        endif 
                                                    endif 
                                                endif 
                                            endif 
                                        endif 
                                    endif 
                                endif 
                            endif 
                        endif 
                    endif 
                endif 
            endif 
        endif 
    endif 
endfunction 

//=========================================================================== 
function InitTrig_GetSector takes nothing returns nothing 
endfunction 

