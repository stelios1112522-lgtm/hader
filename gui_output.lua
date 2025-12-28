-- UE SCRIPT - Alternative output methods
-- Try different ways to show results

-- Method 1: Try writing to a text label
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UE_Output"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local outputLabel = Instance.new("TextLabel")
outputLabel.Name = "Output"
outputLabel.Size = UDim2.new(1, 0, 0.3, 0)
outputLabel.Position = UDim2.new(0, 0, 0, 0)
outputLabel.BackgroundTransparency = 0.5
outputLabel.BackgroundColor3 = Color3.new(0, 0, 0)
outputLabel.TextColor3 = Color3.new(1, 1, 1)
outputLabel.TextScaled = true
outputLabel.Font = Enum.Font.Code
outputLabel.Text = "Loading UE Script..."
outputLabel.Parent = screenGui

local function log(message)
    outputLabel.Text = outputLabel.Text .. "\n" .. message
    warn(message) -- Also try warn
end

log("=== UE SCRIPT START ===")

-- Load the script
local success, result = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/stelios1112522-lgtm/hader/main/readable.lua")
end)

log("HTTP Result: " .. tostring(success))

if success and result then
    log("Script loaded, length: " .. #result)
    
    -- Remove protection
    local cleaned = string.gsub(result, "if not is_from_loader then warn%('Use the loadstring, do not run this direct'%); return end;", "-- Bypassed")
    
    log("Protection removed")
    
    -- Execute
    local func, err = loadstring(cleaned)
    if func then
        log("Executing script...")
        
        -- Set bypass environment
        local is_from_loader = true
        getfenv().is_from_loader = true
        
        local execSuccess, execResult = pcall(func)
        log("Execution: " .. tostring(execSuccess))
        log("Result type: " .. type(execResult))
        
        if type(execResult) == "function" then
            log("Calling returned function...")
            local funcSuccess, funcResult = pcall(execResult)
            log("Function result: " .. tostring(funcSuccess))
        end
        
    else
        log("Error: " .. tostring(err))
    end
else
    log("HTTP Error: " .. tostring(result))
end

log("=== UE SCRIPT COMPLETE ===")

-- Keep GUI visible for 10 seconds
game:GetService("Debris"):AddItem(screenGui, 10)
