if not game:IsLoaded() then
    game.Loaded:Wait()
end

if getgenv().LD_LOADER_LOADED then
    print("[Lamduck] Loader already loaded!")
    return
end
getgenv().LD_LOADER_LOADED = true

print("[Loader] Hola...")

local BASE_URL = "https://cdn.jsdelivr.net/gh/lamduck2005/RobloxScript@master"

local GAME_LIST = {
    { GameId = 10039338037, Display = "Build A Ring Farm", File = "BuildARingFarm.luau" },
    { GameId = 7812848099,  Display = "Build A Beehive",   File = "BuildABeehive.luau" },
    { GameId = 10200395747, Display = "Grow A Garden 2",   File = "grow-a-garden-2.lua" },
    { GameId = 7395930870,  Display = "Sell Lemon",        File = "SellLemon.luau" },
    { GameId = 7139435866,  Display = "Free Fire Max",     File = "free-fire-max.lua" },
    { GameId = 10081194651, Display = "Pickaxe Tycoon",    File = "pickaxe-tycoon.lua" },
    { GameId = 8181391950,  Display = "Neo Tennis",        File = "neo-tennis.lua" },
}

local function runScript(filename)
    local ok, result = pcall(function()
        return game:HttpGet(BASE_URL .. "/" .. filename)
    end)
    if ok and result then
        local func = loadstring(result)
        if func then
            func()
        end
    end
end

local target = nil
local currentGameId = game.GameId
for _, g in ipairs(GAME_LIST) do
    if g.GameId == currentGameId then
        target = g
        break
    end
end
if target then
    runScript(target.File)
    return
end

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local DISCORD_URL = "https://discord.gg/N3uxkAHYtM"

local gui = Instance.new("ScreenGui")
gui.Name = "LamduckSelector"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = Player:WaitForChild("PlayerGui")

local container = Instance.new("Frame")
container.Size = UDim2.fromOffset(380, 290)
container.Position = UDim2.fromScale(0.5, 0.5)
container.AnchorPoint = Vector2.new(0.5, 0.5)
container.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
container.BorderSizePixel = 0
container.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = container

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(55, 55, 75)
stroke.Thickness = 1
stroke.Parent = container

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -50, 0, 46)
titleLabel.Position = UDim2.fromOffset(16, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Lamduck"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 20
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = container

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.fromOffset(32, 32)
closeBtn.Position = UDim2.new(1, -40, 0, 7)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(120, 120, 140)
closeBtn.TextSize = 18
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = container

closeBtn.MouseEnter:Connect(function()
    closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
end)
closeBtn.MouseLeave:Connect(function()
    closeBtn.TextColor3 = Color3.fromRGB(120, 120, 140)
end)
closeBtn.MouseButton1Click:Connect(function()
    getgenv().LD_LOADER_LOADED = nil
    gui:Destroy()
end)

local descLabel = Instance.new("TextLabel")
descLabel.Size = UDim2.new(1, -40, 0, 44)
descLabel.Position = UDim2.fromOffset(20, 48)
descLabel.BackgroundTransparency = 1
descLabel.Text = "This game is not supported yet.\nChoose a script to run manually:"
descLabel.TextColor3 = Color3.fromRGB(170, 170, 185)
descLabel.TextSize = 14
descLabel.Font = Enum.Font.Gotham
descLabel.TextXAlignment = Enum.TextXAlignment.Left
descLabel.TextWrapped = true
descLabel.Parent = container

local ROW_HEIGHT = 34
local ROW_GAP = 4
local ROW_STEP = ROW_HEIGHT + ROW_GAP

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -20, 0, 132)
scrollFrame.Position = UDim2.fromOffset(10, 96)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 3
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 100)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, #GAME_LIST * ROW_STEP)
scrollFrame.Parent = container

for i, entry in ipairs(GAME_LIST) do
    local y = (i - 1) * ROW_STEP

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, -52, 0, ROW_HEIGHT)
    nameLabel.Position = UDim2.fromOffset(2, y)
    nameLabel.BackgroundColor3 = Color3.fromRGB(38, 38, 52)
    nameLabel.BorderSizePixel = 0
    nameLabel.Text = "  " .. entry.Display
    nameLabel.TextColor3 = Color3.fromRGB(210, 210, 225)
    nameLabel.TextSize = 14
    nameLabel.Font = Enum.Font.Gotham
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = scrollFrame

    local nameCorner = Instance.new("UICorner")
    nameCorner.CornerRadius = UDim.new(0, 6)
    nameCorner.Parent = nameLabel

    local runBtn = Instance.new("TextButton")
    runBtn.Size = UDim2.fromOffset(44, ROW_HEIGHT)
    runBtn.Position = UDim2.new(1, -48, 0, y)
    runBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    runBtn.BorderSizePixel = 0
    runBtn.Text = "Run"
    runBtn.TextColor3 = Color3.fromRGB(220, 220, 235)
    runBtn.TextSize = 13
    runBtn.Font = Enum.Font.GothamBold
    runBtn.AutoButtonColor = false
    runBtn.Parent = scrollFrame

    local runCorner = Instance.new("UICorner")
    runCorner.CornerRadius = UDim.new(0, 6)
    runCorner.Parent = runBtn

    runBtn.MouseEnter:Connect(function()
        runBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    end)
    runBtn.MouseLeave:Connect(function()
        runBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    end)
    runBtn.MouseButton1Click:Connect(function()
        getgenv().LD_LOADER_LOADED = nil
        gui:Destroy()
        runScript(entry.File)
    end)
end

local discordBtn = Instance.new("TextButton")
discordBtn.Size = UDim2.new(1, -40, 0, 38)
discordBtn.Position = UDim2.new(0, 20, 1, -48)
discordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
discordBtn.BorderSizePixel = 0
discordBtn.Text = "Join Discord"
discordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
discordBtn.TextSize = 16
discordBtn.Font = Enum.Font.GothamBold
discordBtn.Parent = container

local dcCorner = Instance.new("UICorner")
dcCorner.CornerRadius = UDim.new(0, 8)
dcCorner.Parent = discordBtn

discordBtn.MouseEnter:Connect(function()
    discordBtn.BackgroundColor3 = Color3.fromRGB(110, 120, 255)
end)
discordBtn.MouseLeave:Connect(function()
    discordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
end)
discordBtn.MouseButton1Click:Connect(function()
    local copied = false
    if setclipboard then
        pcall(function() setclipboard(DISCORD_URL) end)
        copied = true
    end
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(1, -40, 0, 32)
    notif.Position = UDim2.new(0, 20, 1, -92)
    notif.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
    notif.BorderSizePixel = 0
    notif.Parent = container

    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 6)
    notifCorner.Parent = notif

    local notifStroke = Instance.new("UIStroke")
    notifStroke.Color = Color3.fromRGB(55, 55, 75)
    notifStroke.Thickness = 1
    notifStroke.Parent = notif

    local notifText = Instance.new("TextLabel")
    notifText.Size = UDim2.new(1, 0, 1, 0)
    notifText.BackgroundTransparency = 1
    notifText.Text = copied and "Discord link copied to clipboard!" or "Clipboard not available"
    notifText.TextColor3 = Color3.fromRGB(180, 180, 195)
    notifText.TextSize = 13
    notifText.Font = Enum.Font.Gotham
    notifText.Parent = notif

    task.delay(2, function()
        if notif and notif.Parent then notif:Destroy() end
    end)
end)