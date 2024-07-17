if Debug then Debug.beginFile "Game/Stations/Moon/AssemblyPlant" end
OnInit.map("AssemblyPlant", function(require)
    ---@param l texttag
    ---@param production string
    ---@param startx real
    ---@param starty real
    ---@param m timer
    function AP_LoopVisibilityAndTime(l, production, startx, starty, m)
        local i ---@type integer
        local r = GetHandleId(l) ---@type integer
        local k = false ---@type boolean
        SaveBoolean(AP_Hash, r, StringHash("w"), true)
        while not (LoadBoolean(AP_Hash, r, StringHash("w")) ~= true or k) do
            i = 0
            while i <= 11 do
                if IsVisibleToPlayer(startx, starty, Player(i)) then
                    if GetLocalPlayer() == Player(i) then
                        SetTextTagVisibility(l, true)
                    end
                else
                    if GetLocalPlayer() == Player(i) then
                        SetTextTagVisibility(l, false)
                    end
                end
                i = i + 1
            end
            SetTextTagTextBJ(l, production + " (" + I2S(R2I(TimerGetRemaining(m))) + ")", 10.0)
            if TimerGetRemaining(m) == 0 then
                k = true
            else
                PolledWait(0.2)
            end
        end
        DestroyTextTag(l)
    end

    ---@param t texttag
    function DestroyLoopedTextTag(t)
        if t ~= nil then
            SaveBoolean(AP_Hash, GetHandleId(t), StringHash("w"), false)
        end
    end

    AssemblyPlant_ProductionNumber = 0 ---@type integer
    AP_HashStore                   = CreateTrigger() ---@type trigger
    AP_InfoTag                     = nil ---@type texttag
    AP_Hash                        = InitHashtable() ---@type hashtable


    function BLARGH()
    end

    ---@param text string
    ---@param duration real
    ---@param ExecuteWhenDone string
    function BeginProduction(text, duration, ExecuteWhenDone)
        local ProductionID ---@type integer
        local bm   = Location(11345.9, -1960) ---@type location
        local j    = CreateTextTagLocBJ(text, bm, 90.0, 10.0, 50, 100, 100, 0) ---@type texttag
        local m    = CreateTimer() ---@type timer
        AP_InfoTag = j
        SetTextTagVisibility(j, true)
        RemoveLocation(bm)
        bm = nil
        TimerStart(m, duration, false, BLARGH)
        AssemblyPlant_ProductionNumber = AssemblyPlant_ProductionNumber + 1
        ProductionID = AssemblyPlant_ProductionNumber
        SaveBoolean(AP_Hash, GetHandleId(AP_HashStore), ProductionID, true)
        AP_LoopVisibilityAndTime(j, text, 11345.9, -1960, m)
        DestroyTextTag(j)
        if LoadBoolean(AP_Hash, GetHandleId(AP_HashStore), ProductionID) == true and TimerGetRemaining(m) == 0 then
            ExecuteFunc(ExecuteWhenDone)
        end
        DestroyTimer(m)
    end

    function CancelProduction()
        SaveBoolean(AP_Hash, GetHandleId(AP_HashStore), AssemblyPlant_ProductionNumber, false)
        DestroyLoopedTextTag(AP_InfoTag)
    end

    function RollOutItem_Slide()
        local k = GetExpiredTimer() ---@type timer
        local j = LoadItemHandle(AP_Hash, GetHandleId(k), StringHash("j")) ---@type item
        SetItemPosition(j, 11074.8, GetItemY(j) - 2)
        if RectContainsItem(j, gg_rct_AssemblyDropoff) then
            PauseTimer(k)
            FlushChildHashtable(AP_Hash, GetHandleId(k))
            DestroyTimer(k)
        end
    end

    ---@param j item
    function RollOutItem(j)
        local k = CreateTimer() ---@type timer
        SetItemPosition(j, 11074.8, -1904)
        SaveItemHandle(AP_Hash, GetHandleId(k), StringHash("j"), j)
        TimerStart(k, 0.04, true, RollOutItem_Slide)
    end
end)
if Debug then Debug.endFile() end
