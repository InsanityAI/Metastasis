library FixMinimap initializer init requires Timeout
    private function fixMinimap takes nothing returns nothing
        call BlzChangeMinimapTerrainTex("war3mapMinimap.blp")
    endfunction

    private function init takes nothing returns nothing
        call Timeout.start(0.00, false, function fixMinimap)
    endfunction
endlibrary