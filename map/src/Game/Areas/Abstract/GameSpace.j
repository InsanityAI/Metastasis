library GameSpace
    interface GameSpace
        method initialize takes nothing returns nothing
        method contains takes unit thisUnit returns boolean
        method containsPoint takes real x, real y returns boolean
        method forEachUnit takes code callback returns nothing //use GetEnumUnit()
        method pickRandomPosition takes nothing returns nothing
        method getRandomX takes nothing returns real
        method getRandomY takes nothing returns real
    endinterface
endlibrary