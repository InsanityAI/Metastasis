library AndroidChat 
    globals 
        public boolean isAndroidChat = false 
        public boolean Enabled = false 
    endglobals 

    private function FindCardOwner takes nothing returns nothing 
        if UnitHasItem(GetEnumUnit(), udg_Android_MemoryCard) then 
            set udg_Android_MemoryCardOwner = GetEnumUnit() 
        endif 
    endfunction 

    public function CheckChat takes player initiator, string message returns nothing 
        local real x 
        local real y 
        local group allUnitsGroup 
        local texttag tt 
        if initiator != udg_HiddenAndroid or not Enabled then 
            set isAndroidChat = false 
            return 
        endif 
        set isAndroidChat = true 

        if CheckItemStatus(udg_Android_MemoryCard, bj_ITEM_STATUS_OWNED) then 
            if not UnitHasItem(udg_Android_MemoryCardOwner, udg_Android_MemoryCard) then 
                set udg_TempUnitGroup = GetUnitsInRectAll(GetPlayableMapRect()) 
                call ForGroup(udg_TempUnitGroup, function FindCardOwner) 
                call DestroyGroup(udg_TempUnitGroup) 
            endif 
            set x = GetUnitX(udg_Android_MemoryCardOwner) 
            set y = GetUnitY(udg_Android_MemoryCardOwner) 
        else 
            set x = GetItemX(udg_Android_MemoryCard) 
            set y = GetItemY(udg_Android_MemoryCard) 
        endif 
        set tt = CreateTextTag() 
        call SetTextTagTextBJ(tt, GetEventPlayerChatString(), 8.00) 
        call SetTextTagPos(tt, x, y, 0) 
        call SetTextTagColorBJ(tt, 100, 100, 100, 0) 
        call SetTextTagVelocityBJ(tt, 32.00, 90) 
        call SetTextTagPermanentBJ(tt, false) 
        call SetTextTagLifespanBJ(tt, 5) 
        call SetTextTagFadepointBJ(tt, 4) 
        call ShowTextTagForceBJ(false, tt, GetPlayersAll()) 
        if IsVisibleToPlayer(x, y, GetLocalPlayer()) then 
            call SetTextTagVisibility(tt, true) 
        endif 

        set allUnitsGroup = null
        set tt = null
    endfunction 
endlibrary 


