-- LUARMOR LOADER BYPASS - Complete loader emulation
-- This bypasses Luarmor's authentication system entirely

-- Luarmor loader environment emulation
local is_from_loader = true  -- This is what Luarmor checks
local Luarmor = {
    -- Emulate Luarmor's environment variables
    USER_ID = game.Players.LocalPlayer.UserId,
    GAME_ID = game.GameId,
    PLACE_ID = game.PlaceId,
    
    -- Emulate Luarmor's authentication
    Validate = function()
        return true
    end,
    
    -- Emulate Luarmor's license check
    CheckLicense = function()
        return true
    end
}

-- Override Luarmor's detection
getfenv().is_from_loader = true
getfenv().Luarmor = Luarmor

-- Bypass function that loads protected scripts
local function bypassLuarmor(scriptCode)
    -- Create a sandboxed environment
    local env = getfenv()
    env.is_from_loader = true
    env.Luarmor = Luarmor
    
    -- Execute the script in the bypassed environment
    local func = loadstring(scriptCode)
    if func then
        setfenv(func, env)
        return func()
    end
end

-- Load and execute your original readable.lua
-- Execute immediately (don't return function)
local protectedScript = game:HttpGet("https://raw.githubusercontent.com/stelios1112522-lgtm/hader/main/readable.lua")

-- Bypass Luarmor and execute immediately
return bypassLuarmor(protectedScript)
