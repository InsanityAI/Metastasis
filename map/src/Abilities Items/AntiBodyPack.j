//TESH.scrollpos=17
//TESH.alwaysfold=0
function Trig_AntiBodyPack_Conditions takes nothing returns boolean
    if ( not ( GetItemTypeId(GetManipulatedItem()) == 'I004' ) ) then
        return false
    endif
    return true
endfunction

function Trig_AntiBodyPack_Actions takes nothing returns nothing
    local integer i=0
    local unit a=GetManipulatingUnit()
    
    //Ima assume that this is related to "Carrier" ability, and instead of diving deep into it, just don't touch it.
    //Like, if I had to guess, using antibody, vector that is currently targeting you, dies.
    call DestroyTrigger(udg_Unit_CarrierTrigger[GetUnitAN(a)])
    
    //If "Prion Infection" (buff/debuff)
    if UnitHasBuffBJ(a,'B009') then
        //Remove "Prion Infection" (buff/debuff)
        call UnitRemoveBuffBJ( 'B009', a )
    
        //and give "Contained Prion Infection" (buff/debuff)
        set bj_lastCreatedUnit = CreateUnit(Player(12),'e032',GetUnitX(a),GetUnitY(a),270.0)
        call IssueTargetOrder(bj_lastCreatedUnit,"parasite",a)
    endif
    
    //If "Parasite" (buff/debuff)
    if UnitHasBuffBJ(a,'B00H') then
        //Remove "Parasite" (buff/debuff)
        call UnitRemoveBuffBJ( 'B00H', a )
    
        //and give "Contained Parasite" (buff/debuff)
        set bj_lastCreatedUnit= CreateUnit(Player(12),'e033',GetUnitX(a),GetUnitY(a),270.0)
        call IssueTargetOrder(bj_lastCreatedUnit,"parasite",a)
    endif
    
    //THICC spagghetti below in comments.
            //loop
            //exitwhen i > 45
                //call UnitRemoveBuffBJ( 'B009', a )//"Prion Infection" (buff/debuff)
                //call UnitRemoveBuffBJ( 'B00H', a )//"Parasite" (buff/debuff)
                //set i=i+1
                //call PolledWait(1.0)
            //endloop
            //45 seconds have passed inside the loop btw.
        
            //If "Contained Parasite" (buff/debuff)
            //if UnitHasBuffBJ(a,'B01G') then
                //call UnitRemoveBuffBJ('B01G',a)
            //endif
            
            //If "Contained Prion Infection" (buff/debuff)
            //if UnitHasBuffBJ(a,'B01F') then
                //call UnitRemoveBuffBJ('B01F',a)
            //endif
endfunction

//===========================================================================
function InitTrig_AntiBodyPack takes nothing returns nothing
    set gg_trg_AntiBodyPack = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_AntiBodyPack, EVENT_PLAYER_UNIT_USE_ITEM )
    call TriggerAddCondition( gg_trg_AntiBodyPack, Condition( function Trig_AntiBodyPack_Conditions ) )
    call TriggerAddAction( gg_trg_AntiBodyPack, function Trig_AntiBodyPack_Actions )
endfunction

