-- UE SCRIPT FORCED EXECUTOR - Maximum debugging
warn("=== FORCED UE EXECUTOR START ===")

-- Force all output to show
local originalWarn = warn
local function forceWarn(...)
    originalWarn(...)
    originalWarn("FORCED:", ...)
end

forceWarn("Setting up bypass environment")

-- Set bypass environment
local is_from_loader = true
getfenv().is_from_loader = true

forceWarn("Environment set, loading script...")

-- Load the script
local success, result = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/stelios1112522-lgtm/hader/main/readable.lua")
end)

forceWarn("HTTP Result:", success)
if success then
    forceWarn("Script length:", #result)
else
    forceWarn("HTTP Error:", result)
    return
end

forceWarn("Removing protection...")

-- Remove the protection line
local cleaned = string.gsub(result, "if not is_from_loader then warn%('Use the loadstring, do not run this directly'%); return end;", "-- Protection bypassed")

forceWarn("Protection removed, new length:", #cleaned)

forceWarn("Compiling script...")

-- Compile and execute
local func, err = loadstring(cleaned)
forceWarn("Compilation result:", func ~= nil)

if not func then
    forceWarn("COMPILATION ERROR:", err)
    return
end

forceWarn("Executing script...")

local execSuccess, execResult = pcall(func)
forceWarn("Execution success:", execSuccess)
forceWarn("Result type:", type(execResult))

if execResult ~= nil then
    forceWarn("Result value:", tostring(execResult))
end

if type(execResult) == "function" then
    forceWarn("Script returned function - calling it...")
    local mainSuccess, mainResult = pcall(execResult)
    forceWarn("Main function success:", mainSuccess)
    forceWarn("Main function result:", mainResult)
end

forceWarn("=== FORCED EXECUTOR COMPLETE ===")
forceWarn("If you see no effects, the script may be working silently")
forceWarn("Check for new UI, objects, or other changes in game")
