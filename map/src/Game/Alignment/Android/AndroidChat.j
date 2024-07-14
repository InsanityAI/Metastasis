function Trig_AndroidChat_Conditions takes nothing returns boolean
    if ( not ( GetTriggerPlayer() == udg_HiddenAndroid ) ) then
        return false
    endif
    return true
endfunction

function Trig_AndroidChat_Func014Func002Func003Func001C takes nothing returns boolean
    if ( not ( UnitHasItem(GetEnumUnit(), udg_Android_MemoryCard) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_AndroidChat_Func014Func002Func003A takes nothing returns nothing
    if ( Trig_AndroidChat_Func014Func002Func003Func001C() ) then
        set udg_Android_MemoryCardOwner = GetEnumUnit()
    else
    endif
endfunction

function Trig_AndroidChat_Func014Func002C takes nothing returns boolean
    if ( not ( UnitHasItem(udg_Android_MemoryCardOwner, udg_Android_MemoryCard) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_AndroidChat_Func014C takes nothing returns boolean
    if ( not ( CheckItemStatus(udg_Android_MemoryCard, bj_ITEM_STATUS_OWNED) == true ) ) then
        return false
    endif
    return true
endfunction

function Trig_AndroidChat_Actions takes nothing returns nothing
    if ( Trig_AndroidChat_Func014C() ) then
        if ( Trig_AndroidChat_Func014Func002C() ) then
            set udg_TempPoint = GetUnitLoc(udg_Android_MemoryCardOwner)
        else
            set udg_TempUnitGroup = GetUnitsInRectAll(GetPlayableMapRect())
            call ForGroupBJ( udg_TempUnitGroup, function Trig_AndroidChat_Func014Func002Func003A )
            set udg_TempPoint = GetUnitLoc(udg_Android_MemoryCardOwner)
                call DestroyGroup( udg_TempUnitGroup )
        endif
    else
        set udg_TempPoint = GetItemLoc(udg_Android_MemoryCard)
    endif
    call CreateTextTagLocBJ( GetEventPlayerChatString(), udg_TempPoint, 0, 8.00, 100, 100, 100, 0 )
    call SetTextTagVelocityBJ( GetLastCreatedTextTag(), 32.00, 90 )
    call SetTextTagPermanentBJ( GetLastCreatedTextTag(), false )
    call SetTextTagLifespanBJ( GetLastCreatedTextTag(), 5 )
    call SetTextTagFadepointBJ( GetLastCreatedTextTag(), 4 )
    call ShowTextTagForceBJ( false, GetLastCreatedTextTag(), GetPlayersAll() )
    if IsLocationVisibleToPlayer(udg_TempPoint, GetLocalPlayer()) then
    call SetTextTagVisibility(bj_lastCreatedTextTag,true)
    endif
    call RemoveLocation(udg_TempPoint)
endfunction

//===========================================================================
function InitTrig_AndroidChat takes nothing returns nothing
    set gg_trg_AndroidChat = CreateTrigger(  )
    call DisableTrigger( gg_trg_AndroidChat )
    call TriggerRegisterPlayerChatEvent( gg_trg_AndroidChat, Player(0), "", false )
    call TriggerRegisterPlayerChatEvent( gg_trg_AndroidChat, Player(1), "", false )
    call TriggerRegisterPlayerChatEvent( gg_trg_AndroidChat, Player(2), "", false )
    call TriggerRegisterPlayerChatEvent( gg_trg_AndroidChat, Player(3), "", false )
    call TriggerRegisterPlayerChatEvent( gg_trg_AndroidChat, Player(4), "", false )
    call TriggerRegisterPlayerChatEvent( gg_trg_AndroidChat, Player(5), "", false )
    call TriggerRegisterPlayerChatEvent( gg_trg_AndroidChat, Player(6), "", false )
    call TriggerRegisterPlayerChatEvent( gg_trg_AndroidChat, Player(7), "", false )
    call TriggerRegisterPlayerChatEvent( gg_trg_AndroidChat, Player(8), "", false )
    call TriggerRegisterPlayerChatEvent( gg_trg_AndroidChat, Player(9), "", false )
    call TriggerRegisterPlayerChatEvent( gg_trg_AndroidChat, Player(10), "", false )
    call TriggerRegisterPlayerChatEvent( gg_trg_AndroidChat, Player(11), "", false )
    call TriggerAddCondition( gg_trg_AndroidChat, Condition( function Trig_AndroidChat_Conditions ) )
    call TriggerAddAction( gg_trg_AndroidChat, function Trig_AndroidChat_Actions )
endfunction

