if Debug then Debug.beginFile "Commands/CamCommand" end
OnInit.map("CamCommand", function(require)
    function CamCommand_Actions()
        local i                = 0 ---@type integer

        --What is the default wc3 camera distance?
        udg_CameraDistanceTemp = 1650

        ---cam X (e.g. -cam 4)
        if StringLength(GetEventPlayerChatString()) >= 6 then
            udg_CameraDistanceTemp = S2I(SubString(GetEventPlayerChatString(), 5,
                StringLength(GetEventPlayerChatString())))
            if udg_CameraDistanceTemp <= 4 and udg_CameraDistanceTemp >= 1 then
                udg_CameraDistanceTemp = (1650 + ((udg_CameraDistanceTemp - 1) * 200))
            else
                udg_CameraDistanceTemp = 1650
            end
        end

        ---cam YYYY (e.g. -cam 1821)
        if StringLength(GetEventPlayerChatString()) >= 8 then
            udg_CameraDistanceTemp = S2I(SubString(GetEventPlayerChatString(), 5,
                StringLength(GetEventPlayerChatString())))
        end

        if (GetLocalPlayer() == GetTriggerPlayer()) then
            SetCameraField(CAMERA_FIELD_TARGET_DISTANCE, I2R(udg_CameraDistanceTemp), 0.20)
        end

        while i <= 11 do
            if GetTriggerPlayer() == Player(i) then
                udg_CameraDistanceAuto[i] = udg_CameraDistanceTemp
            end

            i = i + 1
        end
    end

    local i           = 0 ---@type integer
    gg_trg_CamCommand = CreateTrigger()

    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_CamCommand, Player(i), "-cam", false)
        i = i + 1
    end

    TriggerAddAction(gg_trg_CamCommand, CamCommand_Actions)
end)
if Debug then Debug.endFile() end
