if Debug then Debug.beginFile "Game/Abilities/Alien/NightOfTheMasksESC" end
OnInit.map("NightOfTheMasksESC", function(require)
    ---@return boolean
    function Trig_NightOfTheMasksESC_Conditions()
        if (not (udg_Player_IsMasquerading[GetConvertedPlayerId(GetTriggerPlayer())] == true)) then
            return false
        end
        if (not (IsUnitAliveBJ(udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())]) == true)) then
            return false
        end
        if RectContainsUnit(gg_rct_Space, udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())]) == true then
            return false
        end
        if RectContainsUnit(gg_rct_Timeout, udg_Playerhero[GetConvertedPlayerId(GetTriggerPlayer())]) == true then
            return false
        end
        return true
    end

    function Trig_NightOfTheMasksESC_Actions()
        local i        = 1 ---@type integer
        local v ---@type item
        local a ---@type unit

        udg_TempPlayer = GetTriggerPlayer()
        udg_TempUnit   = udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)]
        udg_TempPoint  = GetUnitLoc(udg_TempUnit)
        a              = udg_TempUnit
        AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Items\\AIil\\AIilTarget.mdl")
        SFXThreadClean()

        --If became a structure/shop/vendor
        if (IsUnitType(a, UNIT_TYPE_STRUCTURE) == true) then
            ShowUnitShow(ReturnMasqueradeShop())
        end

        if udg_TempPlayer == udg_Parasite then
            CreateNUnitsAtLoc(1, udg_AlienCurrentForm, Player(bj_PLAYER_NEUTRAL_EXTRA), udg_TempPoint, bj_UNIT_FACING)
            udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)] = GetLastCreatedUnit()
            udg_Playerhero[GetConvertedPlayerId(Player(bj_PLAYER_NEUTRAL_EXTRA))] = GetLastCreatedUnit()
            udg_AlienForm_Alien = GetLastCreatedUnit()
            SetPlayerColorBJ(Player(bj_PLAYER_NEUTRAL_EXTRA), ConvertPlayerColor(bj_PLAYER_NEUTRAL_EXTRA), true)
            SetPlayerColorBJ(udg_TempPlayer, udg_Player_MasqueradeColor[GetConvertedPlayerId(udg_TempPlayer)], true)
        else
            CreateNUnitsAtLoc(1, udg_ParasiteChildInfectee, GetTriggerPlayer(), udg_TempPoint, bj_UNIT_FACING)
            udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)] = GetLastCreatedUnit()
            SetPlayerColorBJ(udg_TempPlayer, udg_Player_MasqueradeColor[GetConvertedPlayerId(udg_TempPlayer)], true)
        end

        SetUnitLifePercentBJ(GetLastCreatedUnit(),
            (udg_Player_Masquerade_Life[GetConvertedPlayerId(GetTriggerPlayer())] + GetUnitLifePercent(a)) / 2.0)

        --Move items
        while i <= 6 do
            v = LoadItemHandle(LS(), GetHandleId(GetTriggerPlayer()), StringHash("mitem_" + I2S(i)))
            UnitAddItem(GetLastCreatedUnit(), v)
            v = LoadItemHandle(LS(), GetHandleId(GetTriggerPlayer()), StringHash("kitem_" + I2S(i)))
            RemoveItem(v)
            SetItemPositionLoc(v, udg_HoldZone)
            i = i + 1
        end

        RemoveUnit(a)
        RemoveLocation(udg_TempPoint)
        SelectUnitForPlayerSingle(GetLastCreatedUnit(), udg_TempPlayer)
        SetPlayerName(udg_TempPlayer, udg_Player_NameBeforeDead[GetConvertedPlayerId(GetTriggerPlayer())])
        udg_Player_IsMasquerading[GetConvertedPlayerId(udg_TempPlayer)] = false
        if udg_TempPlayer == udg_Parasite then
            udg_Player_IsMasquerading[GetConvertedPlayerId(Player(14))] = false
        end
    end

    --===========================================================================
    local i                   = 0 ---@type integer
    gg_trg_NightOfTheMasksESC = CreateTrigger()
    while i <= 11 do
        TriggerRegisterPlayerEventEndCinematic(gg_trg_NightOfTheMasksESC, Player(i))
        i = i + 1
    end
    TriggerAddCondition(gg_trg_NightOfTheMasksESC, Condition(Trig_NightOfTheMasksESC_Conditions))
    TriggerAddAction(gg_trg_NightOfTheMasksESC, Trig_NightOfTheMasksESC_Actions)
end)
if Debug then Debug.endFile() end
