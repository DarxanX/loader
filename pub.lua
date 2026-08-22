local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- ================= CONFIG / LOCAL VARIABLES =================
local CONFIG = {
    HOLD_MIN = 1.3,          -- Время готовности (100% заполнения бара)
    HOLD_MAX = 2.6,          -- Лимит удерживания на 100% перед сбросом цикла
    ENTRY_DELAY = 0.15,      -- Задержка при входе, если промпт появился издалека
    INSTANT_RADIUS = 10,     -- Радиус мгновенной активации при появлении промпта
    SEARCH_RANGE = 1000,     -- Радиус поиска промптов
    POST_TRIGGER_WAIT = 0.1, -- Задержка после fireproximityprompt перед новым holdBegan
}
-- ============================================================

local LP = Players.LocalPlayer
local parentGui = LP:FindFirstChildOfClass("PlayerGui")
pcall(function()
    if CoreGui then parentGui = CoreGui end
end)

if parentGui:FindFirstChild("MinimalInstantGrabGui") then
    parentGui.MinimalInstantGrabGui:Destroy()
end

local PromptMemoryCache = {}
local autoGiant = false

local function getMyPlot()
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return nil end

    for _, plot in ipairs(plots:GetChildren()) do
        local sign = plot:FindFirstChild("PlotSign")
        if sign and sign:FindFirstChild("SurfaceGui") then
            local fr = sign.SurfaceGui:FindFirstChild("Frame")
            if fr and fr:FindFirstChild("TextLabel") then
                if fr.TextLabel.Text == LP.DisplayName.."'s Base" then 
                    return plot 
                end
            end
        end
    end
    return nil
end

local function findNearestPromptInPlots(maxRadius)
    local char = LP.Character
    if not char then return nil, math.huge, nil end
    local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
    if not root then return nil, math.huge, nil end

    local plots = workspace:FindFirstChild("Plots")
    if not plots then return nil, math.huge, nil end
    local myPlot = getMyPlot()

    local nearestPrompt, minDist, nearestUID = nil, maxRadius, nil
    for _, plot in ipairs(plots:GetChildren()) do
        if myPlot and plot == myPlot then
            continue
        end

        local podiums = plot:FindFirstChild("AnimalPodiums")
        if podiums then
            for _, podium in ipairs(podiums:GetChildren()) do
                local uid = plot.Name .. "_" .. podium.Name
                local cached = PromptMemoryCache[uid]
                local targetPrompt = nil

                if cached and cached.Parent then
                    targetPrompt = cached
                else
                    local base = podium:FindFirstChild("Base")
                    local spawnPoint = base and base:FindFirstChild("Spawn")
                    local attachment = spawnPoint and spawnPoint:FindFirstChild("PromptAttachment")
                    
                    if attachment then
                        for _, child in ipairs(attachment:GetChildren()) do
                            if child:IsA("ProximityPrompt") and child.Enabled then
                                targetPrompt = child
                                PromptMemoryCache[uid] = child
                                break
                            end
                        end
                    end
                end

                if targetPrompt and targetPrompt.Enabled and targetPrompt.Parent then
                    local part = targetPrompt.Parent
                    if part:IsA("Attachment") then part = part.Parent end
                    
                    if part and part:IsA("BasePart") then
                        local dist = (part.Position - root.Position).Magnitude
                        if dist < minDist then
                            minDist = dist
                            nearestPrompt = targetPrompt
                            nearestUID = uid
                        end
                    end
                end
            end
        end
    end

    return nearestPrompt, minDist, nearestUID
end

local function triggerHoldBegan(prompt)
    if not prompt then return end
    if getconnections then
        for _, conn in ipairs(getconnections(prompt.PromptButtonHoldBegan)) do
            if conn.Function then task.spawn(conn.Function) end
        end
    else
        prompt:InputHoldBegan()
    end
end

local function useGiantPotion()
    local char = LP.Character
    local backpack = LP:FindFirstChildOfClass("Backpack")
    if not char or not backpack then return end

    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local potion = backpack:FindFirstChild("Giant Potion") or char:FindFirstChild("Giant Potion")

    if potion then
        if potion.Parent == backpack and humanoid then
            humanoid:EquipTool(potion)
        end
        potion:Activate()
    end
end

local function triggerPrompt(prompt)
    if not prompt then return end
    if fireproximityprompt then
        if autoGiant then
          task.spawn(useGiantPotion)
        end
        fireproximityprompt(prompt)
    else
        prompt:InputHoldEnded()
    end
end

-- ================= UI CREATION =================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MinimalInstantGrabGui"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 999
screenGui.Parent = parentGui

-- 1. ЭЛЕМЕНТ: ПРОГРЕСС-БАР
local barFrame = Instance.new("Frame")
barFrame.Name = "ProgressBarFrame"
barFrame.Size = UDim2.new(0, 280, 0, 26)
barFrame.Position = UDim2.new(0.5, -140, 1, -130)
barFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
barFrame.BorderSizePixel = 0
barFrame.Active = true
barFrame.Parent = screenGui

local barFrameCorner = Instance.new("UICorner")
barFrameCorner.CornerRadius = UDim.new(0, 8)
barFrameCorner.Parent = barFrame

local barFrameStroke = Instance.new("UIStroke")
barFrameStroke.Color = Color3.fromRGB(40, 40, 55)
barFrameStroke.Thickness = 1
barFrameStroke.Parent = barFrame

local progressBackground = Instance.new("Frame")
progressBackground.Name = "ProgressBG"
progressBackground.Size = UDim2.new(1, -6, 1, -6)
progressBackground.Position = UDim2.new(0, 3, 0, 3)
progressBackground.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
progressBackground.BorderSizePixel = 0
progressBackground.ClipsDescendants = true
progressBackground.Parent = barFrame

local bgCorner = Instance.new("UICorner")
bgCorner.CornerRadius = UDim.new(0, 6)
bgCorner.Parent = progressBackground

local progressBar = Instance.new("Frame")
progressBar.Name = "ProgressBar"
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
progressBar.BorderSizePixel = 0
progressBar.Parent = progressBackground

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(0, 6)
barCorner.Parent = progressBar

local barGradient = Instance.new("UIGradient")
barGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(130, 80, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 190, 255))
})
barGradient.Enabled = false
barGradient.Parent = progressBar

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 1, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "UNREADY (0%)"
statusLabel.TextColor3 = Color3.fromRGB(220, 220, 235)
statusLabel.Font = Enum.Font.GothamBold
statusLabel.TextSize = 10
statusLabel.ZIndex = 4
statusLabel.Parent = progressBackground

-- 2. ЭЛЕМЕНТ: МЕНЮ НАСТРОЕК
local menuFrame = Instance.new("Frame")
menuFrame.Name = "MenuFrame"
menuFrame.Size = UDim2.new(0, 220, 0, 90)
menuFrame.Position = UDim2.new(0.5, -110, 0.4, -45)
menuFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
menuFrame.BorderSizePixel = 0
menuFrame.Active = true
menuFrame.Parent = screenGui

local menuCorner = Instance.new("UICorner")
menuCorner.CornerRadius = UDim.new(0, 12)
menuCorner.Parent = menuFrame

local menuStroke = Instance.new("UIStroke")
menuStroke.Color = Color3.fromRGB(40, 40, 55)
menuStroke.Thickness = 1.2
menuStroke.Parent = menuFrame

local menuTitle = Instance.new("TextLabel")
menuTitle.Size = UDim2.new(1, -20, 0, 28)
menuTitle.Position = UDim2.new(0, 10, 0, 2)
menuTitle.BackgroundTransparency = 1
menuTitle.Text = "CONTROL"
menuTitle.TextColor3 = Color3.fromRGB(150, 150, 175)
menuTitle.Font = Enum.Font.GothamBold
menuTitle.TextSize = 10
menuTitle.TextXAlignment = Enum.TextXAlignment.Left
menuTitle.Parent = menuFrame

local function createToggleRow(parent, yOffset, labelText, defaultState, onClick)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -20, 0, 22)
    row.Position = UDim2.new(0, 10, 0, yOffset)
    row.BackgroundTransparency = 1
    row.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0, 130, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = labelText
    lbl.TextColor3 = Color3.fromRGB(220, 220, 235)
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = row

    local toggleBg = Instance.new("TextButton")
    toggleBg.Size = UDim2.new(0, 34, 0, 18)
    toggleBg.Position = UDim2.new(1, -34, 0.5, -9)
    toggleBg.BackgroundColor3 = defaultState and Color3.fromRGB(100, 70, 240) or Color3.fromRGB(35, 35, 48)
    toggleBg.Text = ""
    toggleBg.AutoButtonColor = false
    toggleBg.Parent = row

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(1, 0)
    toggleCorner.Parent = toggleBg

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = defaultState and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
    knob.BackgroundColor3 = Color3.fromRGB(240, 240, 250)
    knob.BorderSizePixel = 0
    knob.Parent = toggleBg

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = knob

    local state = defaultState
    toggleBg.Activated:Connect(function()
        state = not state
        TweenService:Create(knob, TweenInfo.new(0.12), {
            Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
        }):Play()
        TweenService:Create(toggleBg, TweenInfo.new(0.12), {
            BackgroundColor3 = state and Color3.fromRGB(100, 70, 240) or Color3.fromRGB(35, 35, 48)
        }):Play()
        onClick(state)
    end)
end

-- ================= SCRIPT LOGIC =================
local isEnabled = false
local mainLoopConnection = nil
local isExecutingGrab = false

local function resetUI()
    progressBar.Size = UDim2.new(0, 0, 1, 0)
    barGradient.Enabled = false
    progressBar.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
    statusLabel.Text = "UNREADY (0%)"
end

local function stopAutoGrab()
    isEnabled = false
    isExecutingGrab = false
    
    resetUI()
    
    if mainLoopConnection then
        mainLoopConnection:Disconnect()
        mainLoopConnection = nil
    end
    
    table.clear(PromptMemoryCache)
end

local function startAutoGrab()
    isEnabled = true
    
    mainLoopConnection = RunService.Heartbeat:Connect(function()
        if not isEnabled or isExecutingGrab then return end

        local prompt, dist, promptUID = findNearestPromptInPlots(CONFIG.SEARCH_RANGE)
        if not prompt then
            resetUI()
            return
        end

        isExecutingGrab = true
        task.spawn(function()
            local startTime = tick()
            
            local activeUID = promptUID
            local spawnedInInstantRadius = (dist <= CONFIG.INSTANT_RADIUS)

            triggerHoldBegan(prompt)

            while isEnabled and prompt and prompt.Parent do
                local elapsed = tick() - startTime

                local currentPrompt, currentDist, currentUID = findNearestPromptInPlots(CONFIG.SEARCH_RANGE)

                -- Если таргет ушел из радиуса или исчез
                if not currentPrompt then
                    resetUI()
                    break
                end

                if currentUID ~= activeUID then
                    prompt = currentPrompt
                    activeUID = currentUID
                    spawnedInInstantRadius = (currentDist <= CONFIG.INSTANT_RADIUS)
                end

                if elapsed < CONFIG.HOLD_MIN then
                    local fillProgress = math.clamp(elapsed / CONFIG.HOLD_MIN, 0, 1)
                    progressBar.Size = UDim2.new(fillProgress, 0, 1, 0)

                    barGradient.Enabled = false
                    progressBar.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
                    statusLabel.Text = string.format("UNREADY (%d%%)", math.floor(fillProgress * 100))
                elseif elapsed >= CONFIG.HOLD_MIN and elapsed < CONFIG.HOLD_MAX then
                    progressBar.Size = UDim2.new(1, 0, 1, 0)
                    barGradient.Enabled = true
                    statusLabel.Text = "READY (100%)"

                    local maxDist = prompt.MaxActivationDistance or 10
                    if currentDist <= maxDist then
                        if not spawnedInInstantRadius and CONFIG.ENTRY_DELAY > 0 then
                            task.wait(CONFIG.ENTRY_DELAY)
                        end

                        triggerPrompt(prompt)
                        task.wait(CONFIG.POST_TRIGGER_WAIT)
                        triggerHoldBegan(prompt)
                        break
                    end
                else
                    break
                end

                task.wait()
            end

            isExecutingGrab = false
        end)
    end)
end

createToggleRow(menuFrame, 32, "Auto Grab", false, function(state)
    if state then startAutoGrab() else stopAutoGrab() end
end)

createToggleRow(menuFrame, 58, "Auto Giant", false, function(state)
    autoGiant = state
end)

local function makeDraggable(frame)
    local dragging, dragStart, startPos = false, nil, nil

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end

makeDraggable(barFrame)
makeDraggable(menuFrame)
