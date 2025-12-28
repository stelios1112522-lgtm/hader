-- FAKE LUARMOR SYSTEM - Simple bypass for UE script
-- This creates a fake Luarmor authentication system

local FakeLuarmor = {
    -- Fake authentication that always returns true
    Validate = function(key)
        warn("Fake Luarmor: Validating key - ALWAYS SUCCESS")
        return true
    end,
    
    -- Fake license check that always passes
    CheckLicense = function()
        warn("Fake Luarmor: License check - ALWAYS PASSES")
        return true
    end,
    
    -- Fake user info
    GetUserInfo = function()
        return {
            UserId = game.Players.LocalPlayer.UserId,
            Username = game.Players.LocalPlayer.Name,
            License = "PREMIUM",
            Expiry = "9999-12-31"
        }
    end
}

-- Override global Luarmor if it exists
_G.Luarmor = FakeLuarmor
getfenv().Luarmor = FakeLuarmor

-- Override common Luarmor checks
getfenv().is_from_loader = true
_G.is_from_loader = true

warn("=== FAKE LUARMOR SYSTEM ACTIVE ===")
warn("All Luarmor checks will now pass")
warn("Ready to execute UE script...")

-- Now execute your UE script with the fake system
spawn(function()
    local success, result = pcall(function()
        return game:HttpGet("https://raw.githubusercontent.com/stelios1112522-lgtm/hader/main/readable.lua")
    end)
    
    if success and result then
        warn("UE Script loaded, executing with fake Luarmor...")
        
        -- Remove protection line
        local cleaned = string.gsub(result, "if not is_from_loader then warn%('Use the loadstring, do not run this direct'%); return end;", "")
        
        -- Execute with fake environment
        local func = loadstring(cleaned)
        if func then
            local execResult = func()
            warn("UE Script executed successfully!")
            
            if type(execResult) == "function" then
                warn("UE Script returned function, executing...")
                local mainResult = execResult()
                warn("Main function executed:", mainResult)
            end
        else
            warn("Failed to compile UE script")
        end
    else
        warn("Failed to load UE script:", result)
    end
end)
