if Debug then Debug.beginFile "Libraries/Moogle/PreventSave" end
--====================================
-- PreventSave (Converted to Lua by Insanity_AI)
--====================================
--
--   This library is simple enough. It allows you to enable or
--   disabled game saving. It works by showing a dialog instantly
--   before a game is saved. This closes the save screen therefor
--   the game is never actually saved.
--
--   Nothing visually happens to the game except for maybe a quick open
--   and close of the save dialog, though it's hardly noticeable.
--   This even works in single player surprisngly without pausing the game
--   which usually happens when a dialog is opened offline.
--
--   You can toggle allowing or disallowing saving by setting
--   ALLOW_SAVE to true, or false.
--
--   requires TimerQueue
--====================================
OnInit.final("Libraries/Moogle/PreventSave", function(require)
    require "TimerQueue"
    local ALLOW_SAVE = false

    local trigger = CreateTrigger()
    local dialog = DialogCreate()
    local player = GetLocalPlayer()
    TriggerRegisterGameEvent(trigger, EVENT_GAME_SAVE)
    TriggerAddAction(trigger, function()
        if not ALLOW_SAVE then
            DialogDisplay(player, dialog, true)
            TimerQueue:callDelayed(0.00, function()
                DialogDisplay(player, dialog, false)
            end)
        end
    end)
end)
if Debug then Debug.endFile() end
