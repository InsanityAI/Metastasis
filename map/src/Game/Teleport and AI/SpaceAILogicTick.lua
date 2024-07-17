if Debug then Debug.beginFile "Game/TeleportAndAI/SpaceAllLogicTick" end
OnInit.trig("SpaceAllLogicTick", function(require)
    function RunSpaceFleetLogic()
        IssuePointOrder(GetEnumUnit(), "attack", udg_TempReal, udg_TempReal2)
    end

    ---@return boolean
    function FilterEnum()
        if GetOwningPlayer(GetFilterUnit()) ~= Player(PLAYER_NEUTRAL_AGGRESSIVE) and IsUnitAliveBJ(GetFilterUnit()) then
            return true
        end
        return false
    end

    function Trig_SpaceAILogicTick_Actions()
        --Get all non-player-hostile units who are alive
        udg_SpaceAI_FocusTargets = GetUnitsInRectMatching(gg_rct_Space, Condition(FilterEnum))

        --TempInt = The amount of units in space to be focused by AI
        udg_TempInt = CountUnitsInGroup(udg_SpaceAI_FocusTargets)


        --If Minertha is alive, start the sapper logic
        if IsUnitDeadBJ(gg_unit_h008_0196) == false then
            --If Minertha has sapper tag, and it's the only unit in space -> Remove the sapper tag
            if IsUnitType(gg_unit_h008_0196, UNIT_TYPE_SAPPER) and udg_TempInt == 1 then
                UnitRemoveTypeBJ(UNIT_TYPE_SAPPER, gg_unit_h008_0196)
            end

            --If minertha doesn't have sapper tag, check if there are more space units now, so as to add it to minertha
            if IsUnitType(gg_unit_h008_0196, UNIT_TYPE_SAPPER) == false and udg_TempInt > 1 then
                UnitAddTypeBJ(UNIT_TYPE_SAPPER, gg_unit_h008_0196)
            end

            --Unrelated to sapper, but removing Minertha completely from being focused if its not alone plz
            if udg_TempInt > 1 then
                GroupRemoveUnit(udg_SpaceAI_FocusTargets, gg_unit_h008_0196)
            end
        end

        --Get First unit to target ((unrelated with distance lmao))
        udg_TempReal = GetUnitX(FirstOfGroup(udg_SpaceAI_FocusTargets))
        udg_TempReal2 = GetUnitY(FirstOfGroup(udg_SpaceAI_FocusTargets))

        --Run USI Fleet Logic on each ship in the group
        ForGroup(udg_SpaceAI_USIFleet, RunSpaceFleetLogic)

        --Run Pirate Ship Logic
        if udg_SpaceAI_PirateCaptainAlive then
            IssuePointOrder(gg_unit_h02B_0116, "attack", udg_TempReal, udg_TempReal2)
        end

        DestroyGroup(udg_SpaceAI_FocusTargets)

        --Run Drones Logic
        --Ytrec's code copypasta has made them run by themselves, and its better that way since they don't focus one point but locally closest
        --Could use some cleaning for sure, as they are not optimized for sure and conflict with this (checking sapper minertha for each drone -_-)

        --Run Misc
        --No idea, but I was thinking of snoeglays or hostile raptors/ships in general - very rare.
    end

    --===========================================================================
    gg_trg_SpaceAILogicTick = CreateTrigger()
    TriggerRegisterTimerExpireEventBJ(gg_trg_SpaceAILogicTick, udg_SpaceAI_Timer)
    TriggerAddAction(gg_trg_SpaceAILogicTick, Trig_SpaceAILogicTick_Actions)
end)
if Debug then Debug.endFile() end
