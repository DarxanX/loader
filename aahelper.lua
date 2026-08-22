local _Players = game:GetService('Players')
local _TweenService = game:GetService('TweenService')
local _RunService = game:GetService('RunService')
local _Workspace = game:GetService('Workspace')

local _LocalPlayer = _Players.LocalPlayer
local _Camera = _Workspace.CurrentCamera

-- ==========================================
-- СОЗДАНИЕ ИНТЕРФЕЙСА (GUI)
-- ==========================================
local ScreenGui = Instance.new('ScreenGui')
ScreenGui.Name = 'CustomHelperGUI'
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = _LocalPlayer:WaitForChild('PlayerGui')

-- Уменьшенные размеры главного окна (было 260x170, стало 210x135)
local MainFrame = Instance.new('Frame', ScreenGui)
MainFrame.Size = UDim2.new(0, 210, 0, 135)
MainFrame.Position = UDim2.new(0.5, -105, 0.5, -67)
MainFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
Instance.new('UICorner', MainFrame).CornerRadius = UDim.new(0, 10)

local UIStroke = Instance.new('UIStroke', MainFrame)
UIStroke.Thickness = 1
UIStroke.Transparency = 0.8
UIStroke.Color = Color3.fromRGB(255, 255, 255)

-- Заголовок
local Title = Instance.new('TextLabel', MainFrame)
Title.Size = UDim2.new(1, -40, 0, 32)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = 'Admin Abuse Helper'
Title.TextSize = 14
Title.TextColor3 = Color3.fromRGB(240, 240, 240)
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Кнопка Сворачивания / Разворачивания (-)
local MinimizeBtn = Instance.new('TextButton', MainFrame)
MinimizeBtn.Size = UDim2.new(0, 20, 0, 20)
MinimizeBtn.Position = UDim2.new(1, -26, 0, 6)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = '-'
MinimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeBtn.TextSize = 14
Instance.new('UICorner', MinimizeBtn).CornerRadius = UDim.new(0, 5)

local Container = Instance.new('Frame', MainFrame)
Container.Size = UDim2.new(1, -16, 1, -38)
Container.Position = UDim2.new(0, 8, 0, 34)
Container.BackgroundTransparency = 1

local UIListLayout = Instance.new('UIListLayout', Container)
UIListLayout.Padding = UDim.new(0, 8)

-- Логика свертывания
local isMinimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    
    if isMinimized then
        MinimizeBtn.Text = '+'
        Container.Visible = false
        _TweenService:Create(MainFrame, TweenInfo.new(0.2), {Size = UDim2.new(0, 210, 0, 32)}):Play()
    else
        MinimizeBtn.Text = '-'
        _TweenService:Create(MainFrame, TweenInfo.new(0.2), {Size = UDim2.new(0, 210, 0, 135)}):Play()
        task.delay(0.1, function()
            if not isMinimized then
                Container.Visible = true
            end
        end)
    end
end)

-- ==========================================
-- ФУНКЦИЯ СОЗДАНИЯ ТУМБЛЕРА
-- ==========================================
local function createToggle(text, callback)
    local Frame = Instance.new('Frame', Container)
    Frame.Size = UDim2.new(1, 0, 0, 38)
    Frame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
    Instance.new('UICorner', Frame).CornerRadius = UDim.new(0, 6)

    local Label = Instance.new('TextLabel', Frame)
    Label.Size = UDim2.new(0.6, 0, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.GothamSemibold
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(230, 230, 230)
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left

    -- Фон тумблера
    local SwitchBG = Instance.new('Frame', Frame)
    SwitchBG.Size = UDim2.new(0, 40, 0, 20)
    SwitchBG.Position = UDim2.new(1, -48, 0.5, -10)
    SwitchBG.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Instance.new('UICorner', SwitchBG).CornerRadius = UDim.new(0, 10)

    -- Кружок тумблера
    local SwitchCircle = Instance.new('Frame', SwitchBG)
    SwitchCircle.Size = UDim2.new(0, 16, 0, 16)
    SwitchCircle.Position = UDim2.new(0, 2, 0.5, -8)
    SwitchCircle.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
    Instance.new('UICorner', SwitchCircle).CornerRadius = UDim.new(0, 8)

    local Button = Instance.new('TextButton', Frame)
    Button.Size = UDim2.new(1, 0, 1, 0)
    Button.BackgroundTransparency = 1
    Button.Text = ''

    local state = false

    Button.MouseButton1Click:Connect(function()
        state = not state
        
        -- Анимация тумблера
        if state then
            _TweenService:Create(SwitchCircle, TweenInfo.new(0.2), {Position = UDim2.new(1, -18, 0.5, -8)}):Play()
            _TweenService:Create(SwitchBG, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 135, 255)}):Play()
        else
            _TweenService:Create(SwitchCircle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -8)}):Play()
            _TweenService:Create(SwitchBG, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
        end

        callback(state)
    end)
end

-- ==========================================
-- ЛОГИКА ФУНКЦИЙ (AUTO BUY & ANCHOR)
-- ==========================================

-- 1. Auto Buy
local autoBuyConnection = nil

local function isPromptOnScreen(prompt)
    local parent = prompt.Parent
    local position = nil

    if parent:IsA('BasePart') then
        position = parent.Position
    elseif parent:IsA('Model') and parent.PrimaryPart then
        position = parent.PrimaryPart.Position
    elseif parent:IsA('Attachment') then
        position = parent.WorldPosition
    end

    if not position then return false end

    local _, isOnScreen = _Camera:WorldToViewportPoint(position)
    return isOnScreen
end

createToggle('Auto Buy', function(enabled)
    if enabled then
        autoBuyConnection = _RunService.RenderStepped:Connect(function()
            for _, prompt in ipairs(_Workspace:GetDescendants()) do
                if prompt:IsA('ProximityPrompt') and prompt.ActionText == 'Purchase' and prompt.Enabled then
                    if isPromptOnScreen(prompt) then
                        if typeof(fireproximityprompt) == 'function' then
                            fireproximityprompt(prompt)
                        else
                            prompt:InputHoldBegin()
                            task.wait(prompt.HoldDuration)
                            prompt:InputHoldEnd()
                        end
                    end
                end
            end
        end)
    else
        if autoBuyConnection then
            autoBuyConnection:Disconnect()
            autoBuyConnection = nil
        end
    end
end)

-- 2. Anchor
local isAnchored = false

local function setCharacterAnchor(state)
    local character = _LocalPlayer.Character
    if character then
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA('BasePart') then
                part.Anchored = state
            end
        end
    end
end

createToggle('Anchor', function(enabled)
    isAnchored = enabled
    setCharacterAnchor(isAnchored)
end)

-- Сохранение состояния при респавне
_LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    if isAnchored then
        setCharacterAnchor(true)
    end
end)
