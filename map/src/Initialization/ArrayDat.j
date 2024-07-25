function NewUnitRegister takes unit h returns nothing 
    if GetUnitUserData(h) == 0 then 
        //Should be 8192 and 1, but I'm not going to change it while it's working. 
        set udg_Array_On = udg_Array_On + 1 
        if udg_Array_On >= 8000 then 
            set udg_Array_On = 100 
        endif 
        if udg_UnitAssignation[udg_Array_On] != null then 
            loop 
                exitwhen udg_UnitAssignation[udg_Array_On] == null or udg_UnitAssignation[udg_Array_On] == udg_TheNullUnit 
                set udg_Array_On = udg_Array_On + 1 
            endloop 
        endif 
        set udg_UnitAssignation[udg_Array_On] = h 
        call SetUnitUserData(h, udg_Array_On) 
    endif 
endfunction 

//Faster to type than GetUnitUserData() and easier to remember. 
function GetUnitAN takes unit h returns integer 
    return GetUnitUserData(h) 
endfunction 

//When a unit enters the map, this will catch it and assign a number to it. 
//The bad part is, you shouldn't reference a unit immediately after creating it. 
//If you must, call NewUnitRegister(GetLastCreatedUnit()). A built in safety guard will prevent this function from overwriting. 
function Redirect_RegisterUnit takes nothing returns nothing 
    if GetUnitUserData(GetTriggerUnit()) != 0 then 
        return 
    endif 
    call NewUnitRegister(GetTriggerUnit()) 
endfunction 

//============================== 
//Give pre-placed units a number. 
//You should still call a new register before accessing if you immediately want it during map init. 
function PrePlacedUnits takes nothing returns nothing 
    call NewUnitRegister(GetEnumUnit()) 
endfunction 

function Init_ForGlobal takes nothing returns nothing 
    //Fun fun fun, make sure to call this somewhere. 
    local group x = GetUnitsInRectAll(GetPlayableMapRect()) 
    local trigger v = CreateTrigger() 
    call TriggerRegisterEnterRectSimple(v, GetPlayableMapRect()) 
    call TriggerAddAction(v, function Redirect_RegisterUnit) 
    call ForGroup(x, function PrePlacedUnits) 
    call DestroyGroup(x) 
    set x = null 
endfunction 
//=========================================================================== 
function InitTrig_ArrayDat takes nothing returns nothing 
    call Init_ForGlobal() 
endfunction 

