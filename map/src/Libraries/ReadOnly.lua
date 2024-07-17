if Debug then Debug.beginFile "ReadOnly" end -- https://www.lua.org/pil/13.4.5.html
OnInit.module("ReadOnly", function()
    function ReadOnly(t)
        local proxy = {}
        local mt = {
            __index = t,
            __newindex = function(t, k, v)
                error("attempt to update a read-only table", 2)
            end
        }
        setmetatable(proxy, mt)
        return proxy
    end
end)
if Debug then Debug.endFile() end
