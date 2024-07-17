if Debug then Debug.beginFile "UI/HideAllies" end
OnInit.final("HideAllies", function(require)
    --internal
    local playerCount = GetBJMaxPlayers() ---@type integer

    ---@param frame framehandle
    local function HideFrame(frame)
        BlzFrameSetVisible(frame, false)
    end


    local index       = 0 ---@type integer
    local parentFrame = BlzGetFrameByName("AllianceDialog", 0) ---@type framehandle
    local frame ---@type framehandle
    DestroyTimer(GetExpiredTimer())
    HideFrame(BlzGetFrameByName("AllianceTitle", 0))
    HideFrame(BlzGetFrameByName("ResourceTradingTitle", 0))
    HideFrame(BlzGetFrameByName("PlayersHeader", 0))
    HideFrame(BlzGetFrameByName("AllyHeader", 0))
    HideFrame(BlzGetFrameByName("VisionHeader", 0))
    HideFrame(BlzGetFrameByName("UnitsHeader", 0))
    HideFrame(BlzGetFrameByName("GoldHeader", 0))
    HideFrame(BlzGetFrameByName("LumberHeader", 0))
    while index < playerCount do
        HideFrame(BlzGetFrameByName("AllianceSlot", index))
        HideFrame(BlzGetFrameByName("ColorBackdrop", index))
        HideFrame(BlzGetFrameByName("ColorBorder", index))
        HideFrame(BlzGetFrameByName("PlayerNameLabel", index))
        HideFrame(BlzGetFrameByName("AllyCheckBox", index))
        HideFrame(BlzGetFrameByName("VisionCheckBox", index))
        HideFrame(BlzGetFrameByName("UnitsCheckBox", index))
        HideFrame(BlzGetFrameByName("GoldBackdrop", index))
        HideFrame(BlzGetFrameByName("LumberBackdrop", index))
        HideFrame(BlzGetFrameByName("GoldText", index))
        HideFrame(BlzGetFrameByName("LumberText", index))
        index = index + 1
    end
    HideFrame(BlzGetFrameByName("AlliedVictoryCheckBox", 0))
    HideFrame(BlzGetFrameByName("AlliedVictoryLabel", 0))
    HideFrame(BlzGetFrameByName("AllianceAcceptButton", 0))

    frame = BlzGetFrameByName("AllianceCancelButton", 0)
    BlzFrameClearAllPoints(frame)
    BlzFrameSetPoint(frame, FRAMEPOINT_BOTTOM, parentFrame, FRAMEPOINT_BOTTOM, 0.00, 0.03)
    BlzFrameSetText(frame, "Close")

    frame = BlzCreateFrameByType("TEXT", "", parentFrame, "", 0)
    BlzFrameSetPoint(frame, FRAMEPOINT_CENTER, parentFrame, FRAMEPOINT_CENTER, 0.00, 0.00)
    BlzFrameSetText(frame, "You tried")
    BlzFrameSetTextAlignment(frame, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_CENTER)
    BlzFrameSetSize(frame, 0.10, 0.05)
    BlzFrameSetScale(frame, 4)
end)
if Debug then Debug.endFile() end
