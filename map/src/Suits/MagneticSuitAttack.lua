//TESH.scrollpos=2
//TESH.alwaysfold=0
function Trig_MagneticSuitAttack_Conditions takes nothing returns boolean
    if GetUnitTypeId(GetAttacker())=='h04K' then
        return true
    endif
    return false
endfunction



function SlivText takes real r, unit a returns nothing
local location b=GetUnitLoc(a)
local texttag w=CreateTextTagLocBJ( I2S(R2I(r)), b, 90.00, 6.00, 100, 0.00, 0.00, 0 )
call AddSpecialEffect("Abilities\\Spells\\Human\\FlakCannons\\FlakTarget.mdl",GetUnitX(GetAttacker())+70*Cos((GetUnitFacing(GetAttacker())-6) * bj_DEGTORAD),GetUnitY(GetAttacker())+70*Sin((GetUnitFacing(GetAttacker())-6)*bj_DEGTORAD))
    call PlaySoundAtPointBJ( gg_snd_AxeMissileLaunch1, 100, b, 0 )
    call SetTextTagVelocityBJ( w, 86.00, 90 )
    call SetTextTagPermanentBJ( w, false )
    call SetTextTagFadepoint(w,0.0)
    call SetTextTagLifespanBJ( w, 2.00 )
    call SetTextTagVisibility(w,false)
    if IsLocationVisibleToPlayer(b,GetLocalPlayer()) then
    call SetTextTagVisibility(w,true)
    endif
    call RemoveLocation(b)
endfunction

function Trig_MagneticSuitAttack_Actions takes nothing returns nothing
    local integer slivAttacks
    local group magneticSlivedGroup

    //If ally alien
    if (IsPlayerAlien(GetOwningPlayer(GetAttacker())) and IsPlayerAlien(GetOwningPlayer(GetTriggerUnit()))) and not(udg_AllowAlienTK) and not(IsPlayerMainInfected(GetOwningPlayer(GetAttacker()))) then
        return
    endif
    
    //If ally mutant
    if (IsPlayerMutant(GetOwningPlayer(GetAttacker())) and IsPlayerMutant(GetOwningPlayer(GetTriggerUnit()))) and not(udg_AllowMutantTK) and not(IsPlayerMainInfected(GetOwningPlayer(GetAttacker()))) then
        return
    endif
    
    //If already attacked before, use that handle, else create group and cache him
    if HaveSavedHandle(LS(),GetHandleId(GetAttacker()),StringHash("Suit_SlivGroup")) then
        set magneticSlivedGroup=LoadGroupHandle(LS(),GetHandleId(GetAttacker()),StringHash("Suit_SlivGroup"))
        if magneticSlivedGroup==null then
            set magneticSlivedGroup=CreateGroup()
            call SaveGroupHandle(LS(),GetHandleId(GetAttacker()),StringHash("Suit_SlivGroup"),magneticSlivedGroup)
        endif
    else
        set magneticSlivedGroup=CreateGroup()
        call SaveGroupHandle(LS(),GetHandleId(GetAttacker()),StringHash("Suit_SlivGroup"),magneticSlivedGroup)
    endif
        
    //If target already has slivs, use the cache to get how many hits he has already taken
    if HaveSavedInteger(LS(),GetHandleId(magneticSlivedGroup),GetHandleId(GetTriggerUnit())) then
        set slivAttacks=LoadInteger(LS(),GetHandleId(magneticSlivedGroup),GetHandleId(GetTriggerUnit()))
    else
        set slivAttacks=0
    endif
    
    //Weird check, this is a debug spagghetti, as it should never be checked, so whatever.
    if IsUnitInGroup(GetTriggerUnit(),magneticSlivedGroup) == false then
        set slivAttacks=0
        call GroupAddUnit(magneticSlivedGroup,GetTriggerUnit())
    endif
    
    ///DEBUG//TODO REMOVE!
    ///call DisplayTextToForce(GetPlayersAll(), "Before attacking - Slivs")
    ///call DisplayTextToForce(GetPlayersAll(), I2S(slivAttacks))
    
    //If max sliv attacks
    if slivAttacks > 11 then
        
        //Show sliv number text over the unit
        call SlivText((I2R(slivAttacks))*25.0,GetTriggerUnit())
        
        //Special Effect (to show unit has maxed out on slivs)
        call AddSpecialEffect("Abilities\\Spells\\Human\\FlakCannons\\FlakTarget.mdl",GetUnitX(GetTriggerUnit()),GetUnitY(GetTriggerUnit()))
        call SFXThreadClean()
    else
        //Show sliv number text over the unit
        call SlivText((I2R(slivAttacks)+1)*25.0,GetTriggerUnit())
    
        //Increment slivAttacks by one.
        call SaveInteger(LS(),GetHandleId(magneticSlivedGroup),GetHandleId(GetTriggerUnit()),slivAttacks+1)
    endif
    
    //If you want to debug the 300 dmg bug, you should:
    //1. put a PRINT(slivAttacks) so as to check if it exceeds 11
    //2. go to muh detonate trigger and check it out.
    //3. Last resort is checking how it goes by removing suit and re-putting it.
endfunction


//===========================================================================
function InitTrig_MagneticSuitAttack takes nothing returns nothing
    set gg_trg_MagneticSuitAttack = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_MagneticSuitAttack, EVENT_PLAYER_UNIT_ATTACKED )
    call TriggerAddCondition( gg_trg_MagneticSuitAttack, Condition( function Trig_MagneticSuitAttack_Conditions ) )
    call TriggerAddAction( gg_trg_MagneticSuitAttack, function Trig_MagneticSuitAttack_Actions )
endfunction

