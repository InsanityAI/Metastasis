library UserNotifications
    function UserError takes player thisPlayer, string reason returns nothing
        call DisplayTextToPlayer(thisPlayer, 0, 0, reason)
    endfunction

    function UserNotif takes player thisPlayer, string notification returns nothing
        call DisplayTextToPlayer(thisPlayer, 0, 0, notification)
    endfunction
endlibrary