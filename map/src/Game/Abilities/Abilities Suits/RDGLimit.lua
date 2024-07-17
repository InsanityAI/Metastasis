if Debug then Debug.beginFile "Game/Abilities/Suits/RDGLimit" end
OnInit.map("RDGLimit", function(require)


---@return boolean
function Trig_RDGLimit_Conditions()
   if ( not ( GetSpellAbilityId() == FourCC('A056') ) ) then
        return false
    end
    return true
end

---@return boolean
function Trig_RDGLimit_Func001002002001()
    return ( IsUnitAliveBJ(GetFilterUnit()) == true )
end

---@return boolean
function Trig_RDGLimit_Func001002002002()
    return ( GetUnitTypeId(GetFilterUnit()) == FourCC('e018') )
end

---@return boolean
function Trig_RDGLimit_Func001002002()
    return GetBooleanAnd( Trig_RDGLimit_Func001002002001(), Trig_RDGLimit_Func001002002002() )
end

---@return boolean
function Trig_RDGLimit_Func002C()
    if ( not ( CountUnitsInGroup(udg_TempUnitGroup) >= 4 ) ) then
        return false
    end
    return true
end

function Trig_RDGLimit_Actions()
local be         =Condition(Trig_RDGLimit_Func001002002) ---@type boolexpr 
    udg_TempUnitGroup = GetUnitsOfPlayerMatching(GetOwningPlayer(GetTriggerUnit()), be)
    if ( Trig_RDGLimit_Func002C() ) then
        IssueImmediateOrder(GetSpellAbilityUnit(), "stop")
    else
    end
    DestroyGroup( udg_TempUnitGroup )
    DestroyBoolExpr(be)
    be=nil
end

--===========================================================================
    gg_trg_RDGLimit = CreateTrigger(  )
    TriggerRegisterAnyUnitEventBJ( gg_trg_RDGLimit, EVENT_PLAYER_UNIT_SPELL_CAST )
    TriggerAddCondition( gg_trg_RDGLimit, Condition( Trig_RDGLimit_Conditions ) )
    TriggerAddAction( gg_trg_RDGLimit, Trig_RDGLimit_Actions )
end)
if Debug then Debug.endFile() end
