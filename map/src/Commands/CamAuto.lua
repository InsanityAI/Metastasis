if Debug then Debug.beginFile "Commands/CamAuto" end
OnInit.trig("CamAuto", function(require)
    function CamAuto_Actions()
        local i = 0 ---@type integer

        while i <= 11 do
            if (GetLocalPlayer() == Player(i)) then
                if udg_CameraDistanceAuto[i] ~= 1650 then
                    SetCameraField(CAMERA_FIELD_TARGET_DISTANCE, I2R(udg_CameraDistanceAuto[i]), 0.00)
                end
            end

            i = i + 1
        end
    end

    gg_trg_CamAuto = CreateTrigger()
    DisableTrigger(gg_trg_CamAuto)

    TriggerRegisterTimerEvent(gg_trg_CamAuto, 1.00, true)
    TriggerAddAction(gg_trg_CamAuto, CamAuto_Actions)
end)
if Debug then Debug.endFile() end
