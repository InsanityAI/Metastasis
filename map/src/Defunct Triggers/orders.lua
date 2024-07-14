//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_orders_Actions takes nothing returns nothing
    local integer order = GetIssuedOrderId()
    call BJDebugMsg(GetUnitName(GetOrderedUnit()) + " has been ordered " + OrderId2String(order)+ " ("+I2S(order)+")")
endfunction

function InitTrig_orders takes nothing returns nothing
    local trigger t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER )
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER )
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ISSUED_ORDER )
    call TriggerAddAction(t, function Trig_orders_Actions)
endfunction