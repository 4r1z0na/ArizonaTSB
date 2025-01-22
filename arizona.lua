local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Consistt/Ui/main/UnLeaked"))()

local localplayer = game.Players.LocalPlayer
local humanoid = game.StarterPlayer.StarterCharacter.Humanoid
local Wm = library:Watermark("Arizona | v0.1 | " .. library:GetUsername())
local FpsWm = Wm:AddWatermark("fps: " .. library.fps)
coroutine.wrap(function()
    while wait(.75) do
        FpsWm:Text("fps: " .. library.fps)
end
end)()

local Notif = library:InitNotifications()

for i = 0,0,-1 do 
    task.wait(0.05)
    local LoadingXSX = Notif:Notify("Loading Arizona, please be patient.", 3, "information") -- notification, alert, error, success, information
end 

library.title = "Arizona"

library:Introduction()
wait(1)
local Init = library:Init()
-- MAIN TAB
local MainTab = Init:NewTab("Main")
-- PLAYER
local PlayerSection = MainTab:NewSection("Player")

local NoStunToggle = MainTab:NewToggle("No Stun", false, function(nostun)
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    
    local localPlayer = Players.LocalPlayer
    local liveFolder = workspace:WaitForChild("Live")
    
    if nostun then
        getgenv().NoStunActive = true
        RunService.Heartbeat:Connect(function()
            if not getgenv().NoStunActive then return end
            local playerFolder = liveFolder:FindFirstChild(localPlayer.Name)
            if playerFolder then
                for _, item in pairs(playerFolder:GetChildren()) do
                    if item.Name == "Freeze" then
                        item:Destroy()
                    end
                end
            end
        end)
    else
        getgenv().NoStunActive = false
    end
end)

local RSPToggle = MainTab:NewToggle("Respawn at the same place (REJOIN TO TURN OFF)", false, function(rsp)
    local RunService = game:GetService("RunService")
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer

    local DeathPosition
    local rspActive = rsp

    local function onStepped()
        if rspActive and Player.Character and Player.Character:FindFirstChild("Humanoid") then
            local Humanoid = Player.Character.Humanoid
            if Humanoid.Health == 0 and not DeathPosition then
                DeathPosition = Player.Character.PrimaryPart.CFrame
            elseif Humanoid.Health > 0 and DeathPosition then
                Player.Character:PivotTo(DeathPosition)
                DeathPosition = nil
            end
        end
    end

    local connection
    if rsp then
        connection = RunService.Stepped:Connect(onStepped)
    else
        if connection then
            connection:Disconnect()
        end
    end
end)
-- END OF MAIN TAB

-- VISUAL TAB
local VisualTab = Init:NewTab("Visual")
-- ENVIRONMENT
local EnvSection = VisualTab:NewSection("Environment")
local timeValue = game.Workspace.Terrain.Time
local enforcedValue = 12

timeValue.Value = enforcedValue

timeValue:GetPropertyChangedSignal("Value"):Connect(function()
    if timeValue.Value ~= enforcedValue then
        timeValue.Value = enforcedValue
    end
end)

local TimeSlider = VisualTab:NewSlider("Time", "", true, "/", {min = 0, max = 23, default = 12}, function(val)
    enforcedValue = val
    timeValue.Value = val
end)
-- END OF VISUAL TAB

-- PLAYER TAB
local PlayerTab = Init:NewTab("Player")

local YourselfSection = PlayerTab:NewSection("Yourself")

-- Walkspeed Slider
local WalkspeedSlider = PlayerTab:NewSlider("Walkspeed", "", true, "/", {min = 1, max = 300, default = 16}, function(value)
    spawn(function()
        getgenv().WalkSpeedLooping = false
        task.wait(.01)
        getgenv().WalkSpeedLooping = true
        if localplayer.Character then
            while getgenv().WalkSpeedLooping do
                task.wait()
                localplayer.Character.Humanoid.WalkSpeed = value
            end
        end
    end)
end)

-- Jump Power Slider
local JumpPowerSlider = PlayerTab:NewSlider("Jump Power", "", true, "/", {min = 1, max = 300, default = 50}, function(value)
    spawn(function()
        getgenv().JumpPowerLooping = false
        task.wait(.01)
        getgenv().JumpPowerLooping = true
        if localplayer.Character then
            while getgenv().JumpPowerLooping do
                task.wait()
                localplayer.Character.Humanoid.JumpPower = value
            end
        end
    end)
end)
-- NoClip Toggle (not done yet)
local NoclipToggle = PlayerTab:NewToggle("Noclip (not done yet)", false, function(noclip)
end)
local Label1 = PlayerTab:NewLabel("Fake Stats", "left")--"left", "center", "right"

local KillCount = PlayerTab:NewTextbox("Kill Count", "", "Type a number...", "all", "small", true, false, function(val)
    localplayer.leaderstats.Kills.Value = val
end)

local TotalKillCount = PlayerTab:NewTextbox("Total Kill Count", "", "Type a number...", "all", "small", true, false, function(val)
    localplayer.leaderstats["Total Kills"].Value = val
end)
-- END OF PLAYER TAB

-- SETTINGS TAB
local Tab1 = Init:NewTab("Settings")

local Section1 = Tab1:NewSection("UI Settings")

local Keybind1 = Tab1:NewKeybind("Toggle UI", Enum.KeyCode.RightAlt, function(key)
    Init:UpdateKeybind(Enum.KeyCode[key])
end)

local Toggle1 = Tab1:NewToggle("Watermark", true, function(value)
    if value then
        Wm:Show()
        FpsWm:Show()
    else
        Wm:Hide()
        FpsWm:Hide()
    end
end)
-- END OF SETTINGS TAB
local FinishedLoading = Notif:Notify("Loaded Arizona!", 4, "success")