function CorrectFrame takes framehandle frame returns nothing
    local modelhandle frameModel = CeGetFrameModel(frame)
    call CeSetModelAlpha(frameModel, 255)
endfunction