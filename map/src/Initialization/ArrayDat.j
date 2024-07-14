//TESH.scrollpos=60
//TESH.alwaysfold=0

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
call SetUnitUserData(h,udg_Array_On)
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
local group x=GetUnitsInRectAll(GetPlayableMapRect())
local trigger v=CreateTrigger()
    call TriggerRegisterEnterRectSimple( v, GetPlayableMapRect() )
    call TriggerAddAction( v, function Redirect_RegisterUnit)
call ForGroup(x,function PrePlacedUnits)
call DestroyGroup(x)
set x=null
//HEY LOOK RANDOM INITIALIZATION
        set udg_ColorCodesRed[0] = 255
        set udg_ColorCodesGreen[0] = 2
        set udg_ColorCodesBlue[0] = 2
        set udg_ColorCodesRed[1] = 0
        set udg_ColorCodesGreen[1] = 65
        set udg_ColorCodesBlue[1] = 255
        set udg_ColorCodesRed[2] = 27
        set udg_ColorCodesGreen[2] = 230
        set udg_ColorCodesBlue[2] = 184
        set udg_ColorCodesRed[3] = 83
        set udg_ColorCodesGreen[3] = 0
        set udg_ColorCodesBlue[3] = 128
        set udg_ColorCodesRed[4] = 255
        set udg_ColorCodesGreen[4] = 252
        set udg_ColorCodesBlue[4] = 0
        set udg_ColorCodesRed[5] = 254
        set udg_ColorCodesGreen[5] = 137
        set udg_ColorCodesBlue[5] =13
        set udg_ColorCodesRed[6] = 31
        set udg_ColorCodesGreen[6] = 191
        set udg_ColorCodesBlue[6] = 0
        set udg_ColorCodesRed[7] = 229
        set udg_ColorCodesGreen[7] = 90
        set udg_ColorCodesBlue[7] = 175
        set udg_ColorCodesRed[8] = 148
        set udg_ColorCodesGreen[8] = 149
        set udg_ColorCodesBlue[8] = 150
        set udg_ColorCodesRed[9] = 125
        set udg_ColorCodesGreen[9] = 190
        set udg_ColorCodesBlue[9] = 241
        set udg_ColorCodesRed[10] = 15
        set udg_ColorCodesGreen[10] = 97
        set udg_ColorCodesBlue[10] = 69
        set udg_ColorCodesRed[11] = 77
        set udg_ColorCodesGreen[11] = 41
        set udg_ColorCodesBlue[11] = 3
endfunction
//===========================================================================
function InitTrig_ArrayDat takes nothing returns nothing
    call Init_ForGlobal()
endfunction

