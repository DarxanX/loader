local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- === СОЗДАНИЕ GUI ===
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CustomToggleGui"
-- Пытаемся поместить в CoreGui (если инжектор поддерживает), иначе в PlayerGui
ScreenGui.Parent = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 140)
Frame.Position = UDim2.new(0.5, -100, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true -- Можно перетаскивать мышкой
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "AA helper"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.BackgroundTransparency = 1
Title.Parent = Frame

-- Вспомогательная функция для создания кнопок-переключателей
local function createToggleButton(text, positionY)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.85, 0, 0, 35)
    Btn.Position = UDim2.new(0.075, 0, 0, positionY)
    Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    Btn.Text = text .. ": OFF"
    Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    Btn.Font = Enum.Font.SourceSansSemibold
    Btn.TextSize = 14
    Btn.Parent = Frame

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = Btn

    return Btn
end

local AutoBuyBtn = createToggleButton("Auto Buy", 35)
local AnchorBtn = createToggleButton("Anchor Character", 80)

-- === ЛОГИКА ФУНКЦИЙ ===

local autoBuyEnabled = false
local anchorEnabled = false

-- 1. Логика Auto Buy
AutoBuyBtn.MouseButton1Click:Connect(function()
    autoBuyEnabled = not autoBuyEnabled
    if autoBuyEnabled then
        AutoBuyBtn.Text = "Auto Buy: ON"
        AutoBuyBtn.BackgroundColor3 = Color3.fromRGB(46, 139, 87)
        AutoBuyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    else
        AutoBuyBtn.Text = "Auto Buy: OFF"
        AutoBuyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
        AutoBuyBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
end)

-- Поклинка / Поиск ProximityPrompt в цикле
task.spawn(function()
    while true do
        task.wait(0.1)
        if autoBuyEnabled then
            for _, prompt in ipairs(workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") then
                    local nameMatch = string.find(string.lower(prompt.Name), "purchase")
                    local textMatch = string.find(string.lower(prompt.ActionText), "purchase")
                    
                    if nameMatch or textMatch then
                        -- Вызов стандартной функции для выполнения промпта
                        if fireproximityprompt then
                            fireproximityprompt(prompt)
                        else
                            -- Резервный вариант, если чит не поддерживает fireproximityprompt
                            prompt:InputHoldBegin()
                            task.wait(prompt.HoldDuration)
                            prompt:InputHoldEnd()
                        end
                    end
                end
            end
        end
    end
end)

-- 2. Логика Anchor
AnchorBtn.MouseButton1Click:Connect(function()
    anchorEnabled = not anchorEnabled
    if anchorEnabled then
        AnchorBtn.Text = "Anchor: ON"
        AnchorBtn.BackgroundColor3 = Color3.fromRGB(46, 139, 87)
        AnchorBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    else
        AnchorBtn.Text = "Anchor: OFF"
        AnchorBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
        AnchorBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
end)

-- Постоянная проверка / поддержание Anchor при респавне или движении
RunService.Stepped:Connect(function()
    local character = LocalPlayer.Character
    if character then
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                if anchorEnabled then
                    part.Anchored = true
                else
                    -- Не рас-анчорим HumanoidRootPart во время обычного хождения, 
                    -- но сбрасываем, если тумблер выключен вручную
                    if part.Name ~= "HumanoidRootPart" or not anchorEnabled then
                        part.Anchored = false
                    end
                end
            end
        end
    end
end)
