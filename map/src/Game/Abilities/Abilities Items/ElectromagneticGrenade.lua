if Debug then Debug.beginFile "Game/Abilities/Items/ElectromagneticGrenade" end
OnInit.trig("ElectromagneticGrenade", function(require)
  ---@return boolean
  function Trig_ElectromagneticGrenade_Conditions()
    if (not (GetUnitTypeId(GetSummonedUnit()) == FourCC('e00X'))) then
      return false
    end
    return true
  end

  function EMP_Grenade_Disable_Vendor()
    local a = udg_TempUnit ---@type unit
    if GetUnitAbilityLevel(GetEnumUnit(), FourCC('A079')) > 0 then
      ConsoleDisable(GetEnumUnit())
    end
    PauseUnitForPeriod(GetEnumUnit(), 120.0)
    SetUnitVertexColor(a, 50, 50, 50, 256)
    PolledWait(120.00)
    SetUnitVertexColor(a, 255, 255, 255, 256)
    if GetUnitAbilityLevel(a, FourCC('A079')) > 0 then
      ConsoleEnable(a)
    end
  end

  function Trig_ElectromagneticGrenade_Func005A()
    udg_TempPoint2 = GetUnitLoc(GetEnumUnit())
    SetUnitManaBJ(GetEnumUnit(),
      (GetUnitStateSwap(UNIT_STATE_MANA, GetEnumUnit()) - ((250.00 - DistanceBetweenPoints(udg_TempPoint, udg_TempPoint2)) / 1.60)))
    if GetUnitAbilityLevel(GetEnumUnit(), FourCC('A07Q')) >= 1 or GetUnitAbilityLevel(GetEnumUnit(), FourCC('A079')) >= 1 then
      udg_TempUnit = GetEnumUnit()
      ExecuteFunc("EMP_Grenade_Disable_Vendor")
    end
    if IsUnitExplorer(GetEnumUnit()) then
      DestroyUnitBarStop(GetEnumUnit())
      SaveBoolean(LS(), GetHandleId(GetEnumUnit()), StringHash("LaunchCleared"), false)
      AddSpecialEffectLoc("Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", udg_TempPoint2)
      SFXThreadClean()
    end
    RemoveLocation(udg_TempPoint2)
  end

  function Trig_ElectromagneticGrenade_Actions()
    local a           = GetUnitLoc(GetSummonedUnit()) ---@type location
    udg_TempUnitGroup = GetUnitsInRangeOfLocAll(250.00, a)
    CreateNUnitsAtLoc(1, FourCC('e00Y'), Player(PLAYER_NEUTRAL_AGGRESSIVE), a, bj_UNIT_FACING)
    --Silence?
    IssuePointOrderLocBJ(GetLastCreatedUnit(), "silence", a)
    udg_TempPoint = a
    ForGroupBJ(udg_TempUnitGroup, Trig_ElectromagneticGrenade_Func005A)
    DestroyGroup(udg_TempUnitGroup)
    RemoveLocation(a)
  end

  --===========================================================================
  gg_trg_ElectromagneticGrenade = CreateTrigger()
  TriggerRegisterAnyUnitEventBJ(gg_trg_ElectromagneticGrenade, EVENT_PLAYER_UNIT_SUMMON)
  TriggerAddCondition(gg_trg_ElectromagneticGrenade, Condition(Trig_ElectromagneticGrenade_Conditions))
  TriggerAddAction(gg_trg_ElectromagneticGrenade, Trig_ElectromagneticGrenade_Actions)
end)
if Debug then Debug.endFile() end
