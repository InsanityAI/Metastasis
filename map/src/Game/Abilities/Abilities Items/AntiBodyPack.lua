if Debug then Debug.beginFile "Game/Abilities/Items/AntiBodyPack" end
OnInit.map("AntiBodyPack", function(require)
    ---@return boolean
    function Trig_AntiBodyPack_Conditions()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I004'))) then
            return false
        end
        return true
    end

    function Trig_AntiBodyPack_Actions()
        local i = 0 ---@type integer
        local a = GetManipulatingUnit() ---@type unit

        --Ima assume that this is related to "Carrier" ability, and instead of diving deep into it, just don't touch it.
        --Like, if I had to guess, using antibody, vector that is currently targeting you, dies.
        DestroyTrigger(udg_Unit_CarrierTrigger[GetUnitAN(a)])

        --If "Prion Infection" (buff/debuff)
        if UnitHasBuffBJ(a, FourCC('B009')) then
            --Remove "Prion Infection" (buff/debuff)
            UnitRemoveBuffBJ(FourCC('B009'), a)

            --and give "Contained Prion Infection" (buff/debuff)
            bj_lastCreatedUnit = CreateUnit(Player(12), FourCC('e032'), GetUnitX(a), GetUnitY(a), 270.0)
            IssueTargetOrder(bj_lastCreatedUnit, "parasite", a)
        end

        --If "Parasite" (buff/debuff)
        if UnitHasBuffBJ(a, FourCC('B00H')) then
            --Remove "Parasite" (buff/debuff)
            UnitRemoveBuffBJ(FourCC('B00H'), a)

            --and give "Contained Parasite" (buff/debuff)
            bj_lastCreatedUnit = CreateUnit(Player(12), FourCC('e033'), GetUnitX(a), GetUnitY(a), 270.0)
            IssueTargetOrder(bj_lastCreatedUnit, "parasite", a)
        end

        --THICC spagghetti below in comments.
        --loop
        --exitwhen i > 45
        --call UnitRemoveBuffBJ( FourCC('B009'), a )//"Prion Infection" (buff/debuff)
        --call UnitRemoveBuffBJ( FourCC('B00H'), a )//"Parasite" (buff/debuff)
        --set i=i+1
        --call PolledWait(1.0)
        --endloop
        --45 seconds have passed inside the loop btw.

        --If "Contained Parasite" (buff/debuff)
        --if UnitHasBuffBJ(a,FourCC('B01G')) then
        --call UnitRemoveBuffBJ(FourCC('B01G'),a)
        --endif

        --If "Contained Prion Infection" (buff/debuff)
        --if UnitHasBuffBJ(a,FourCC('B01F')) then
        --call UnitRemoveBuffBJ(FourCC('B01F'),a)
        --endif
    end

    --===========================================================================
    gg_trg_AntiBodyPack = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_AntiBodyPack, EVENT_PLAYER_UNIT_USE_ITEM)
    TriggerAddCondition(gg_trg_AntiBodyPack, Condition(Trig_AntiBodyPack_Conditions))
    TriggerAddAction(gg_trg_AntiBodyPack, Trig_AntiBodyPack_Actions)
end)
if Debug then Debug.endFile() end
