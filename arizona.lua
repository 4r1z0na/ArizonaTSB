local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Consistt/Ui/main/UnLeaked"))()

local localplayer = game.Players.LocalPlayer
local humanoid = game.StarterPlayer.StarterCharacter.Humanoid
local Wm = library:Watermark("Arizona | v0.2 | " .. library:GetUsername())
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
-- NO STUN TOGGLE
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
-- RESPAWN AT SAME PLACE
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
-- FLY TOGGLE
local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()

localplayer = plr

if workspace:FindFirstChild("Core") then
    workspace.Core:Destroy()
end

local Core = Instance.new("Part")
Core.Name = "Core"
Core.Size = Vector3.new(0.05, 0.05, 0.05)

spawn(function()
    Core.Parent = workspace
    local Weld = Instance.new("Weld", Core)
    Weld.Part0 = Core
    Weld.Part1 = localplayer.Character.HumanoidRootPart
    Weld.C0 = CFrame.new(0, 0, 0)
end)

workspace:WaitForChild("Core")

local torso = workspace.Core
flying = false
local speed = 10
local keys = {a = false, d = false, w = false, s = false}
local e1
local e2

local animations = {
    FlyLeft = 17124105294,
    FlyRight = 17124112547,
    FlyBack = 17124067635,
    FlyForward = 17124063826,
    FlyIdle = 17124061663
}

local humanoid = localplayer.Character:WaitForChild("Humanoid")
local loadedAnimations = {}
local activeAnimations = {}

for name, id in pairs(animations) do
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://" .. id
    loadedAnimations[name] = humanoid:LoadAnimation(anim)
    activeAnimations[loadedAnimations[name]] = true
end

local function stopAllAnimations()
    for _, anim in pairs(loadedAnimations) do
        anim:Stop()
    end
end

local function playAnimation(name)
    stopAllAnimations()
    if loadedAnimations[name] then
        loadedAnimations[name]:Play()
    end
end

-- Prevent other animations from playing during flight
local originalAnimationPlayed = humanoid.AnimationPlayed
humanoid.AnimationPlayed:Connect(function(animationTrack)
    if flying and not activeAnimations[animationTrack] then
        animationTrack:Stop()
    end
end)

local function start()
    local pos = Instance.new("BodyPosition", torso)
    local gyro = Instance.new("BodyGyro", torso)
    pos.Name = "EPIXPOS"
    pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
    pos.position = torso.Position
    gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    gyro.cframe = torso.CFrame
    repeat
        wait()
        if not flying then break end
        localplayer.Character.Humanoid.PlatformStand = true
        local new = gyro.cframe - gyro.cframe.p + pos.position
        if not keys.w and not keys.s and not keys.a and not keys.d then
            speed = 5
            playAnimation("FlyIdle")
        end
        if keys.w then
            new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
            playAnimation("FlyForward")
        end
        if keys.s then
            new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
            playAnimation("FlyBack")
        end
        if keys.d then
            new = new * CFrame.new(speed, 0, 0)
            playAnimation("FlyRight")
        end
        if keys.a then
            new = new * CFrame.new(-speed, 0, 0)
            playAnimation("FlyLeft")
        end
        pos.position = new.p
        gyro.cframe = workspace.CurrentCamera.CoordinateFrame
    until not flying
    if gyro then gyro:Destroy() end
    if pos then pos:Destroy() end
    flying = false
    localplayer.Character.Humanoid.PlatformStand = false
    speed = 10
    stopAllAnimations()
end

local FlyToggle = MainTab:NewToggle("Fly", false, function(flyin)
    flying = flyin
    if flying then
        start()
    end
end):AddKeybind(Enum.KeyCode.X)

e1 = mouse.KeyDown:connect(function(key)
    if not torso or not torso.Parent then flying = false e1:disconnect() e2:disconnect() return end
    if key == "w" then
        keys.w = true
    elseif key == "s" then
        keys.s = true
    elseif key == "a" then
        keys.a = true
    elseif key == "d" then
        keys.d = true
    elseif key == "x" then
        flying = not flying
        if flying then
            start()
        end
    elseif key == "e" then
        flying = false
    end
end)

e2 = mouse.KeyUp:connect(function(key)
    if key == "w" then
        keys.w = false
    elseif key == "s" then
        keys.s = false
    elseif key == "a" then
        keys.a = false
    elseif key == "d" then
        keys.d = false
    end
end)

-- END OF MAIN TAB
-- TP TAB
local TPTab = Init:NewTab("Teleport")

local TpBaseplateButton = TPTab:NewButton("Baseplate", function()
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    
    local function teleportToPosition(position)
        if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(position)
        end
    end
    
    teleportToPosition(Vector3.new(1085, 406, 22964))
end)

local TpSaitamaButton = TPTab:NewButton("Saitama Death Counter", function()
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    
    local function teleportToPosition(position)
        if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(position)
        end
    end
    
    teleportToPosition(Vector3.new(-63, 29, 20337))
end)

local TpAtomicButton = TPTab:NewButton("Atomic Samurai Ultimate", function()
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    
    local function teleportToPosition(position)
        if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(position)
        end
    end
    
    teleportToPosition(Vector3.new(1065, 131, 23008))
end)

local TpMiddleButton = TPTab:NewButton("Middle of the map", function()
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    
    local function teleportToPosition(position)
        if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(position)
        end
    end
    
    teleportToPosition(Vector3.new(131, 441, -13))
end)

local TpMt1Button = TPTab:NewButton("Mountain 1", function()
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    
    local function teleportToPosition(position)
        if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(position)
        end
    end
    
    teleportToPosition(Vector3.new(327, 671, 455))
end)

local TpMt1Button = TPTab:NewButton("Mountain 1", function()
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    
    local function teleportToPosition(position)
        if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(position)
        end
    end
    
    teleportToPosition(Vector3.new(327, 671, 455))
end)

local TpMt2Button = TPTab:NewButton("Mountain 2", function()
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    
    local function teleportToPosition(position)
        if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(position)
        end
    end
    
    teleportToPosition(Vector3.new(-8, 653, -387))
end)
-- END OF TP TAB

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

local TimeSlider = VisualTab:NewSlider("Time", "", true, "/", {min = 0, max = 23, default = 16}, function(val)
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

--SCRIPT TAB
local ScriptTab = Init:NewTab("Scripts")
local ExecIYButton = ScriptTab:NewButton("Infinite Yield", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)
local NAButton = ScriptTab:NewButton("Nameless Admin", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Source'))()
end)
local DexButton = ScriptTab:NewButton("Dex Explorer", function()
    loadstring(game:HttpGet("https://gist.githubusercontent.com/DinosaurXxX/b757fe011e7e600c0873f967fe427dc2/raw/ee5324771f017073fc30e640323ac2a9b3bfc550/dark%2520dex%2520v4"))()
end)
local RSpyButton = ScriptTab:NewButton("Remote Spy", function()
    loadstring(game:HttpGetAsync("https://github.com/richie0866/remote-spy/releases/latest/download/RemoteSpy.lua"))()
end)
local SSInstanceButton = ScriptTab:NewButton("Save Instance", function()
    local Params = {
        RepoURL = "https://raw.githubusercontent.com/luau/SynSaveInstance/main/",
        SSI = "saveinstance",
    }
    
    local synsaveinstance = loadstring(game:HttpGet(Params.RepoURL .. Params.SSI .. ".luau", true), Params.SSI)()
    
    local CustomOptions = { SafeMode = true, timeout = 15, SaveBytecode = true }
    
    synsaveinstance(CustomOptions)
end)
-- END OF SCRIPT TAB
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