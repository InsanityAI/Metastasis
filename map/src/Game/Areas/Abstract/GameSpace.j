library GameSpace
    interface GameSpace
        method initialize takes nothing returns nothing
        method contains takes unit thisUnit returns boolean
        method forEachUnit takes code callback returns nothing //use GetEnumUnit()
    endinterface
endlibrary