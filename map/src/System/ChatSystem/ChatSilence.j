library ChatSilence
    globals
        public boolean enabled = false
        private integer array muted
    endglobals

    public function silencePlayer takes player thisPlayer, boolean silence returns nothing
        local integer pid = GetPlayerId(thisPlayer)
        if silence then
            set muted[pid] = muted[pid] + 1
        else
            set muted[pid] = muted[pid] - 1
            if muted[pid] < 0 then
                set muted[pid] = 0
            endif
        endif
    endfunction

    public function isPlayerSilenced takes player thisPlayer returns boolean
        return muted[GetPlayerId(thisPlayer)] > 0
    endfunction
endlibrary