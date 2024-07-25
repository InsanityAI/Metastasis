function Trig_SSThorlarInit_Actions takes nothing returns nothing 
    set udg_SpaceshipRect[1] = gg_rct_SS1 
    set udg_SpaceshipGround[1] = gg_unit_h001_0041 
    set udg_SpaceshipSpace[1] = gg_unit_h002_0020 
    
    set udg_SpaceshipRect[2] = gg_rct_SS2 
    set udg_SpaceshipGround[2] = gg_unit_h001_0043 
    set udg_SpaceshipSpace[2] = gg_unit_h002_0021 
    
    set udg_SpaceshipRect[3] = gg_rct_SS3 
    set udg_SpaceshipGround[3] = gg_unit_h001_0044 
    set udg_SpaceshipSpace[3] = gg_unit_h002_0045 
    
    set udg_SpaceshipRect[4] = gg_rct_SS4 
    set udg_SpaceshipGround[4] = gg_unit_h001_0042 
    set udg_SpaceshipSpace[4] = gg_unit_h002_0046 
    
    set udg_SpaceshipRect[5] = gg_rct_SS5 
    set udg_SpaceshipGround[5] = gg_unit_h001_0016 
    set udg_SpaceshipSpace[5] = gg_unit_h002_0138 
    
    set udg_SpaceshipRect[6] = gg_rct_SS6 
    set udg_SpaceshipGround[6] = gg_unit_h001_0002 
    set udg_SpaceshipSpace[6] = gg_unit_h002_0153 
    
    set udg_SpaceshipRect[7] = gg_rct_SS7 
    set udg_SpaceshipGround[7] = gg_unit_h001_0163 
    set udg_SpaceshipSpace[7] = gg_unit_h002_0158 
    
    set udg_SpaceshipRect[8] = gg_rct_SS8 
    set udg_SpaceshipGround[8] = gg_unit_h001_0162 
    set udg_SpaceshipSpace[8] = gg_unit_h002_0159 
    
    //Hunter 
    set udg_SpaceshipRect[9] = gg_rct_SS9 
    set udg_SpaceshipGround[9] = gg_unit_h02I_0183 
    set udg_SpaceshipSpace[9] = gg_unit_h02H_0198 
    
    //Obda 
    set udg_SpaceshipRect[10] = gg_rct_SS10 
    set udg_SpaceshipGround[10] = gg_unit_h02K_0203 
    set udg_SpaceshipSpace[10] = gg_unit_h02L_0205 
    
    //Obda 
    set udg_SpaceshipRect[11] = gg_rct_SS11 
    set udg_SpaceshipGround[11] = gg_unit_h02K_0204 
    set udg_SpaceshipSpace[11] = gg_unit_h02L_0202 
    
    //Albadar 
    set udg_SpaceshipRect[12] = gg_rct_SS12 
    set udg_SpaceshipGround[12] = gg_unit_h02S_0215 
    set udg_SpaceshipSpace[12] = gg_unit_h02Q_0212 
    
    //Unused 13th craft 
    set udg_SpaceshipRect[13] = gg_rct_SS13 
    set udg_SpaceshipGround[13] = null 
    set udg_SpaceshipSpace[13] = null 
endfunction 

//=========================================================================== 
function InitTrig_SSThorlarInit takes nothing returns nothing 
    set gg_trg_SSThorlarInit = CreateTrigger() 
    call TriggerAddAction(gg_trg_SSThorlarInit, function Trig_SSThorlarInit_Actions) 
endfunction 

