library UserError
    function UserError takes player thisPlayer, string reason returns nothing
        call DisplayTextToPlayer(thisPlayer, 0, 0, reason)
    endfunction
endlibrary