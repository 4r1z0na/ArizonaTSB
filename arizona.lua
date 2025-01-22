-- local Label1 = Tab1:NewLabel("Keybinds", "left")--"left", "center", "right"
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Consistt/Ui/main/UnLeaked"))()

local localplayer = game.Players.LocalPlayer
local humanoid = game.StarterPlayer.StarterCharacter.Humanoid
library.rank = "user"
local Wm = library:Watermark("Arizona | v" .. library.version ..  " | " .. library:GetUsername() .. " | rank: " .. library.rank)
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

local VisualTab = Init:NewTab("Visual")
local EnvSection = VisualTab:NewSection("Environment")
local TimeSlider = VisualTab:NewSlider("Time", "", true, "/", {min = 0, max = 23, default = 12}, function(val)
local timeValue = game.Workspace.Terrain.Time
timeValue.Value = val
timeValue:GetPropertyChangedSignal("Value"):Connect(function()
    if timeValue.Value ~= val then
        timeValue.Value = val
    end
end)
end)

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
end):AddKeybind(Enum.KeyCode.N)
local Label1 = PlayerTab:NewLabel("Fake Stats", "left")--"left", "center", "right"

local KillCount = PlayerTab:NewTextbox("Kill Count", "", "Type a number...", "all", "small", true, false, function(val)
    localplayer.leaderstats.Kills.Value = val
end)

local TotalKillCount = PlayerTab:NewTextbox("Total Kill Count", "", "Type a number...", "all", "small", true, false, function(val)
    localplayer.leaderstats["Total Kills"].Value = val
end)


local FinishedLoading = Notif:Notify("Loaded Arizona!", 4, "success")

-- // FUNCTION DOCS: 
--[[
    MAIN COMPONENT DOCS:

    -- // local library = loadstring(game:HttpGet(link: url))()
    -- // library.title = text: string
    -- // local Window = library:Init()

    -- [library.title contains rich text]

    -- / library:Remove()
    -- destroys the library

    -- / library:Text("new")
    -- sets the lbrary's text to something new

    - / library:UpdateKeybind(Enum.KeyCode.RightAlt)
    -- sets the lbrary's keybind to switch visibility to something new

    __________________________

    -- // local notificationLibrary = library:InitNotifications()
    -- // local Notification = notificationLibrary:Notify(text: string, time: number, type: string (information, notification, alert, error, success))

    -- [Notify contains rich text]

    -- / 3rd argument is a function, used like this:
    
    Notif:Notify("Function notification", 7, function()
        print("done")
    end)

    -- / Welcome:Text("new text")
    -- sets the notifications text to something differet [ADDS A +0.4 ONTO YOUR TIMER]

    __________________________

    -- // local Wm = library:Watermark(text: string)

    -- [Watermark contains rich text]

    -- / Wm:Hide()
    -- hides the watermark from eye view

    -- / Wm:Show()
    -- makes the watermark visible at the top of your screen

    -- / Wm:Text("new")
    -- sets the watermark's text to something new

    -- / Wm:Remove()
    -- destroys the watermark

    __________________________

    -- // local Tab1 = Init:NewTab(text: string)

    -- [tab title contains rich text]

    -- / Tab1:Open()
    -- opens the tab you want

    -- / Tab1:Remove()
    -- destroys the tab

    -- / Tab1:Hide()
    -- hides the tab from eye view

    -- / Tab1:Show()
    -- makes the tab visible on the selection table

    -- / Tab1:Text("new")
    -- sets the tab's text to something new

    __________________________

    -- [label contains rich text]

    -- / Label1:Text("new")
    -- sets the label's text to something new

    -- / Label1:Remove()
    -- destroys the label

    -- / Label1:Hide()
    -- hides the label from eye view

    -- / Label1:Show()
    -- makes the tab visible on the page that is used

    -- / Label1:Align("le")
    -- aligns the label to a new point in text X

    __________________________

    -- [Button contains rich text]

    -- / Button1:AddButton("text", function() end)
    -- adds a new button inside of the frame [CAN ONLY GO UP TO 4 BUTTONS AT A TIME]

    -- / Button1:Fire()
    -- executes the script within the button

    -- / Button1:Text("new")
    -- sets the button's text to something new

    -- / Button1:Hide()
    -- hides the button from eye view

    -- / Button1:Show()
    -- makes the button visible

    -- / Button1:Remove()
    -- destroys the button

    __________________________

    -- [Sections contain rich text]

    -- / Section1:Text("new")
    -- sets the section's text to something new

    -- / Section1:Hide()
    -- hides the section from eye view

    -- / Section1:Show()
    -- makes the section visible

    -- / Section1:Remove()
    -- destroys the section

    __________________________

    -- [Toggles contain rich text]

    -- / Toggle1:Text("new")
    -- sets the toggle's text to something new

    -- / Toggle1:Hide()
    -- hides the toggle from eye view

    -- / Toggle1:Show()
    -- makes the toggle visible

    -- / Toggle1:Remove()
    -- destroys the toggle

    -- / Toggle1:Change()
    -- changes the toggles state to the opposite

    -- / Toggle1:Set(true)
    -- sets the toggle to true even if it is true

    -- / Toggle1:AddKeybind(Enum.KeyCode.P, false, function() end) -- false / true is used for just changing the toggles state
    -- adds a keybind to the toggle

    -- / Toggle1:SetFunction(function() end)
    -- sets the toggles function

    __________________________

    -- [Keybinds contain rich text]

    -- / Keybind1:Text("new")
    -- sets the keybind's text to something new

    -- / Keybind1:Hide()
    -- hides the keybind from eye view

    -- / Keybind1:Show()
    -- makes the keybind visible

    -- / Keybind1:Remove()
    -- destroys the keybind

    -- / Keybind1:SetKey(Enum.KeyCode.P)
    -- sets the keybinds new key

    -- / Keybind1:Fire()
    -- fires the keybind function

    -- / Keybind1:SetFunction(function() end)
    -- sets the new keybind function

    __________________________

    -- [Textboxes contain rich text]

    -- / Textbox1:Input("new")
    -- sets the text box's input to something new

    -- / Textbox1:Place("new")
    -- sets the text box's placeholder to something new

    -- / Textbox1:Fire()
    -- fires the textbox function

    -- / Textbox1:SetFunction(function() end)
    -- sets the text boxes new function

    -- / Textbox1:Text("new")
    -- sets the textbox's text to something new

    -- / Textbox1:Hide()
    -- hides the textbox from eye view

    -- / Textbox1:Show()
    -- makes the textbox visible

    -- / Textbox1:Remove()
    -- destroys the textbox

    __________________________

    -- [Selectors contain rich text]

    -- / Selector1:SetFunction(function() end)
    -- sets the selector new function

    -- / Selector1:Text("new")
    -- sets the selector's text to something new

    -- / Selector1:Hide()
    -- hides the selector from eye view

    -- / Selector1:Show()
    -- makes the selector visible

    -- / Selector1:Remove()
    -- destroys the selector

    __________________________

    -- [Sliders contain rich text]

    -- / Slider1:Value(1)
    -- sets the slider new value

    -- / Slider1:SetFunction(function() end)
    -- sets the slider new function

    -- / Slider1:Text("new")
    -- sets the slider's text to something new

    -- / Slider1:Hide()
    -- hides the slider from eye view

    -- / Slider1:Show()
    -- makes the slider visible

    -- / Slider1:Remove()
    -- destroys the slider

    ---------------------------------------------------------------------------------------------------------

    MISC SEMI USELESS DOCS:

    -- / library.rank = ""
    -- returns the rank you choose (default = "private")

    -- / library.fps
    -- returns FPS you're getting in game

    -- / library.version
    -- returns the version of the library

    -- / library.title = ""
    -- returns the title of the library

    -- / library:GetDay("word") -- word, short, month, year
    -- returns the os day

    -- / library:GetTime("24h") -- 24h, 12h, minute, half, second, full, ISO, zone
    -- returns the os time

    -- / library:GetMonth("word") -- word, short, digit
    -- returns the os month

    -- / library:GetWeek("year_S") -- year_S, day, year_M
    -- returns the os week

    -- / library:GetYear("digits") -- digits, full
    -- returns the os year

    -- / library:GetUsername()
    -- returns the localplayers username

    -- / library:GetUserId()
    -- returns the localplayers userid

    -- / library:GetPlaceId()
    -- returns the games place id

    -- / library:GetJobId()
    -- returns the games job id

    -- / library:CheckIfLoaded()
    -- returns true if you're fully loaded

    -- / library:Rejoin()
    -- rejoins the same server as you was in

    -- / library:Copy("stuff")
    -- copies the inputed string

    -- / library:UnlockFps(500) -- only works with synapse
    -- sets the max fps to something you choose
    
    -- / library:PromptDiscord("invite")
    -- invites you to a discord
]]