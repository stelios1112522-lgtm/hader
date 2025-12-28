-- UE SCRIPT EXECUTOR - Final working version
-- This bypasses Luarmor and executes your UE script

warn("=== UE SCRIPT LOADING ===")

-- Set bypass environment
local is_from_loader = true
getfenv().is_from_loader = true

-- Load the script
local success, result = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/stelios1112522-lgtm/hader/main/readable.lua")
end)

if success and result then
    warn("Script loaded successfully, length:", #result)
    
    -- Remove the protection line
    local cleaned = string.gsub(result, "if not is_from_loader then warn%('Use the loadstring, do not run this directly'%); return end;", "-- Protection bypassed")
    
    warn("Protection bypassed, executing...")
    
    -- Compile and execute
    local func, err = loadstring(cleaned)
    if func then
        warn("Script compiled, executing...")
        
        local execSuccess, execResult = pcall(func)
        warn("Execution success:", execSuccess)
        warn("Result type:", type(execResult))
        
        if type(execResult) == "function" then
            warn("Script returned main function, executing...")
            local mainSuccess, mainResult = pcall(execResult)
            warn("Main function executed:", mainSuccess)
            warn("Main result:", mainResult)
        elseif execResult ~= nil then
            warn("Script returned:", execResult)
        else
            warn("Script executed successfully - check for UI or other effects")
        end
        
    else
        warn("Compilation error:", err)
    end
else
    warn("HTTP error:", result)
end

warn("=== UE SCRIPT COMPLETE ===")
