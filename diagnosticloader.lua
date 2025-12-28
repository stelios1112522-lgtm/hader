-- DIAGNOSTIC LOADER - Find exactly what's failing
-- This will tell us where the problem is

local url = "https://raw.githubusercontent.com/stelios1112522-lgtm/hader/main/readable.lua"

print("=== DIAGNOSTIC START ===")

-- Step 1: Test HttpGet
print("Step 1: Testing HttpGet...")
local ok, result = pcall(function()
    return game:HttpGet(url)
end)

print("HttpGet ok:", ok)
print("Length:", result and #result or "nil")

if not ok then
    warn("HttpGet failed:", result)
    return
end

if not result or result == "" then
    warn("Empty result from HttpGet")
    return
end

-- Step 2: Test compilation
print("Step 2: Testing compilation...")
local fn, err = loadstring(result)
if not fn then
    warn("Compile error:", err)
    return
end

print("Script compiled successfully")

-- Step 3: Test execution with protection bypass
print("Step 3: Testing execution...")

-- Set up bypass environment
local is_from_loader = true
local Luarmor = {
    USER_ID = game.Players.LocalPlayer.UserId,
    GAME_ID = game.GameId,
    PLACE_ID = game.PlaceId,
    Validate = function() return true end,
    CheckLicense = function() return true end
}

-- Override detection
getfenv().is_from_loader = true
getfenv().Luarmor = Luarmor

-- Execute in bypassed environment
local success, execResult = pcall(function()
    local env = getfenv()
    env.is_from_loader = true
    env.Luarmor = Luarmor
    setfenv(fn, env)
    return fn()
end)

print("Execution success:", success)
if success then
    print("Execution result:", execResult)
else
    warn("Execution failed:", execResult)
end

print("=== DIAGNOSTIC END ===")
