-- ts file was generated at discord.gg/25ms

local _Players = game:GetService('Players')
local _TweenService = game:GetService('TweenService')

game:GetService('RunService')
game:GetService('UserInputService')

local _HttpService = game:GetService('HttpService')
local _LocalPlayer = _Players.LocalPlayer
local _ScreenGui = Instance.new('ScreenGui')

_ScreenGui.Name = 'AdminAbusePanel'
_ScreenGui.Parent = _LocalPlayer:WaitForChild('PlayerGui')
_ScreenGui.ResetOnSpawn = false

local _Frame = Instance.new('Frame')

_Frame.Size = UDim2.new(0, 300, 0, 420)
_Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
_Frame.AnchorPoint = Vector2.new(0.5, 0.5)
_Frame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
_Frame.BorderSizePixel = 0
_Frame.Active = true
_Frame.Draggable = true
_Frame.Parent = _ScreenGui
Instance.new('UICorner', _Frame).CornerRadius = UDim.new(0, 14)

local _UIStroke = Instance.new('UIStroke', _Frame)

_UIStroke.Thickness = 1
_UIStroke.Transparency = 0.9

local _Frame2 = Instance.new('Frame', _Frame)

_Frame2.Size = UDim2.new(1, 0, 0, 56)
_Frame2.BackgroundTransparency = 1

local _TextLabel = Instance.new('TextLabel', _Frame2)

_TextLabel.Size = UDim2.new(1, -24, 1, 0)
_TextLabel.Position = UDim2.new(0, 60, 0, 0)
_TextLabel.BackgroundTransparency = 1
_TextLabel.Font = Enum.Font.GothamBold
_TextLabel.Text = 'Admin Abuse Helper'
_TextLabel.TextSize = 22
_TextLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
_TextLabel.TextXAlignment = Enum.TextXAlignment.Left
_TextLabel.TextYAlignment = Enum.TextYAlignment.Center

local _TextButton = Instance.new('TextButton', _Frame2)

_TextButton.Size = UDim2.new(0, 28, 0, 28)
_TextButton.Position = UDim2.new(1, -36, 0.5, -14)
_TextButton.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
_TextButton.Font = Enum.Font.GothamBold
_TextButton.Text = 'X'
_TextButton.TextSize = 20
_TextButton.TextColor3 = Color3.fromRGB(240, 240, 240)
_TextButton.AutoButtonColor = false
Instance.new('UICorner', _TextButton).CornerRadius = UDim.new(0, 8)

local _UIStroke2 = Instance.new('UIStroke', _TextButton)

_UIStroke2.Thickness = 1
_UIStroke2.Transparency = 0.9

local _ScrollingFrame = Instance.new('ScrollingFrame', _Frame)

_ScrollingFrame.Size = UDim2.new(1, -24, 1, -80)
_ScrollingFrame.Position = UDim2.new(0, 12, 0, 64)
_ScrollingFrame.BackgroundTransparency = 1
_ScrollingFrame.ScrollBarThickness = 8
_ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

local _UIListLayout = Instance.new('UIListLayout', _ScrollingFrame)

_UIListLayout.Padding = UDim.new(0, 12)
_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
_UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function v30(p14)
    local _Frame3 = Instance.new('Frame')

    _Frame3.Size = UDim2.new(0.95, 0, 0, 66)
    _Frame3.BackgroundTransparency = 1
    _Frame3.Parent = _ScrollingFrame

    local _Frame4 = Instance.new('Frame', _Frame3)

    _Frame4.Size = UDim2.new(1, 0, 1, 0)
    _Frame4.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
    _Frame4.BorderSizePixel = 0
    Instance.new('UICorner', _Frame4).CornerRadius = UDim.new(0, 12)

    local _UIStroke3 = Instance.new('UIStroke', _Frame4)

    _UIStroke3.Thickness = 1
    _UIStroke3.Transparency = 0.9

    local _Frame5 = Instance.new('Frame', _Frame4)

    _Frame5.Size = UDim2.new(0, 46, 0, 46)
    _Frame5.Position = UDim2.new(0, 10, 0.5, -23)
    _Frame5.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
    Instance.new('UICorner', _Frame5).CornerRadius = UDim.new(0, 10)

    local _TextLabel2 = Instance.new('TextLabel', _Frame5)

    _TextLabel2.Size = UDim2.new(1, 0, 1, 0)
    _TextLabel2.BackgroundTransparency = 1
    _TextLabel2.Font = Enum.Font.GothamBold
    _TextLabel2.Text = string.sub(p14, 1, 1)
    _TextLabel2.TextColor3 = Color3.fromRGB(220, 220, 220)
    _TextLabel2.TextSize = 18
    _TextLabel2.TextYAlignment = Enum.TextYAlignment.Center

    local _TextLabel3 = Instance.new('TextLabel', _Frame4)

    _TextLabel3.Size = UDim2.new(0.58, 0, 1, 0)
    _TextLabel3.Position = UDim2.new(0, 66, 0, 0)
    _TextLabel3.BackgroundTransparency = 1
    _TextLabel3.Font = Enum.Font.GothamSemibold
    _TextLabel3.Text = p14
    _TextLabel3.TextSize = 16
    _TextLabel3.TextColor3 = Color3.fromRGB(240, 240, 240)
    _TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
    _TextLabel3.TextYAlignment = Enum.TextYAlignment.Center

    local _Frame6 = Instance.new('Frame', _Frame4)

    _Frame6.Size = UDim2.new(0, 84, 0, 36)
    _Frame6.Position = UDim2.new(1, -100, 0.5, -18)
    _Frame6.BackgroundColor3 = Color3.fromRGB(58, 58, 58)
    _Frame6.BorderSizePixel = 0
    Instance.new('UICorner', _Frame6).CornerRadius = UDim.new(0, 18)

    local _UIStroke4 = Instance.new('UIStroke', _Frame6)

    _UIStroke4.Thickness = 1
    _UIStroke4.Transparency = 0.9

    local _Frame7 = Instance.new('Frame', _Frame6)

    _Frame7.Size = UDim2.new(0, 28, 0, 28)
    _Frame7.Position = UDim2.new(0, 6, 0, 4)
    _Frame7.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
    _Frame7.BorderSizePixel = 0
    Instance.new('UICorner', _Frame7).CornerRadius = UDim.new(0, 14)

    local _TextButton2 = Instance.new('TextButton', _Frame4)

    _TextButton2.Size = UDim2.new(1, 0, 1, 0)
    _TextButton2.Position = UDim2.new(0, 0, 0, 0)
    _TextButton2.BackgroundTransparency = 1
    _TextButton2.Text = ''
    _TextButton2.AutoButtonColor = false

    local u25 = false
    local _BindableEvent = Instance.new('BindableEvent')

    local function u28(p27)
        u25 = p27 and true or false

        if u25 then
            _TweenService:Create(_Frame7, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Position = UDim2.new(1, -34, 0, 4),
            }):Play()
            _TweenService:Create(_Frame6, TweenInfo.new(0.22), {
                BackgroundColor3 = Color3.fromRGB(45, 135, 255),
            }):Play()
            _TweenService:Create(_Frame5, TweenInfo.new(0.22), {
                BackgroundColor3 = Color3.fromRGB(38, 120, 255),
            }):Play()
        else
            _TweenService:Create(_Frame7, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Position = UDim2.new(0, 6, 0, 4),
            }):Play()
            _TweenService:Create(_Frame6, TweenInfo.new(0.22), {
                BackgroundColor3 = Color3.fromRGB(58, 58, 58),
            }):Play()
            _TweenService:Create(_Frame5, TweenInfo.new(0.22), {
                BackgroundColor3 = Color3.fromRGB(46, 46, 46),
            }):Play()
        end

        _BindableEvent:Fire(u25)
    end

    _TextButton2.MouseButton1Click:Connect(function()
        u28(not u25)
    end)

    return {
        Holder = _Frame3,
        Tile = _Frame4,
        Touch = _TextButton2,
        GetState = function()
            return u25
        end,
        SetState = function(p29)
            u28(p29)
        end,
        Changed = _BindableEvent.Event,
    }
end

local v31, v32, v33 = ipairs({
    'Anchor',
    'Auto Buy',
})
local u34 = _ScrollingFrame
local u35 = {}

while true do
    local v36

    v33, v36 = v31(v32, v33)

    if v33 == nil then
        break
    end

    local v37 = v30(v36)

    v37.Holder.LayoutOrder = v33
    u35[v36] = v37
end

_UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
    u34.CanvasSize = UDim2.new(0, 0, 0, _UIListLayout.AbsoluteContentSize.Y + 8)
end)
_TextButton.MouseButton1Click:Connect(function()
    _ScreenGui:Destroy()
end)

local u38 = 'StealMenuSettings.json'

local function u39()
    return type(writefile) == 'function' and type(readfile) == 'function' and true or type(syn) == 'table' and (type(syn.write_file) == 'function' and type(syn.read_file) == 'function')
end
local function u42(p40, p41)
    if type(writefile) == 'function' then
        writefile(p40, p41)

        return true
    end
    if type(syn) ~= 'table' or type(syn.write_file) ~= 'function' then
        return false
    end

    syn.write_file(p40, p41)

    return true
end
local function u44(p43)
    if type(readfile) ~= 'function' then
        if type(syn) ~= 'table' or type(syn.read_file) ~= 'function' then
            return nil
        else
            return syn.read_file(p43)
        end
    else
        return readfile(p43)
    end
end
local function _(p45)
    local v46, u47 = pcall(function()
        return _HttpService:JSONEncode(p45)
    end)

    if not v46 then
        return false
    end
    if not u39() then
        return false
    end

    pcall(function()
        u42(u38, u47)
    end)

    return true
end
local function u52()
    if u39() then
        local v48, u49 = pcall(function()
            return u44(u38)
        end)

        if v48 and u49 then
            local v50, v51 = pcall(function()
                return _HttpService:JSONDecode(u49)
            end)

            if v50 then
                return v51
            else
                return nil
            end
        else
            return nil
        end
    else
        return nil
    end
end
local function _()
    local v53, v54, v55 = pairs(u35)
    local v56 = {}

    while true do
        local u57

        v55, u57 = v53(v54, v55)

        if v55 == nil then
            break
        end
        if v55 ~= 'Desync' and v55 ~= 'Floor Steal' then
            local v58, v59 = pcall(function()
                return u57.GetState()
            end)

            if v58 then
                v56[v55] = v59
            end
        end
    end

    return v56
end
local function u66(p60)
    if type(p60) == 'table' then
        local v61, v62, v63 = pairs(p60)

        while true do
            local u64

            v63, u64 = v61(v62, v63)

            if v63 == nil then
                break
            end
            if v63 ~= 'Desync' and v63 ~= 'Floor Steal' then
                local u65 = u35[v63]

                if u65 and type(u65.SetState) == 'function' then
                    pcall(function()
                        u65.SetState(u64)
                    end)
                end
            end
        end
    end
end

(function()
    local v67, v68, v69 = pairs(u35)

    while true do
        local u70

        v69, u70 = v67(v68, v69)

        if v69 == nil then
            break
        end
        if v69 ~= 'Desync' and (v69 ~= 'Floor Steal' and type(u70.SetState) == 'function') then
            pcall(function()
                u70.SetState(false)
            end)
        end
    end

    local v71 = u52()

    if v71 and type(v71) == 'table' then
        u66(v71)
    else
        local v72, v73, v74 = pairs(u35)
        local v75 = {}

        while true do
            local v76, _ = v72(v73, v74)

            if v76 == nil then
                break
            end

            v74 = v76

            if v76 ~= 'Desync' and v76 ~= 'Floor Steal' then
                local v77 = _LocalPlayer:GetAttribute('StealTools_' .. v76)

                if v77 ~= nil then
                    v75[v76] = v77
                end
            end
        end

        u66(v75)
    end
end)()

if u35.Anchor then
    local _LocalPlayer2 = game:GetService('Players').LocalPlayer

    if not _LocalPlayer2.Character then
        _LocalPlayer2.CharacterAdded:Wait()
    end

    local function u85(p79)
        local v80 = _LocalPlayer2.Character or _LocalPlayer2.CharacterAdded:Wait()
        local v81, v82, v83 = pairs(v80:GetDescendants())

        while true do
            local v84

            v83, v84 = v81(v82, v83)

            if v83 == nil then
                break
            end
            if v84:IsA('BasePart') then
                v84.Anchored = p79
            end
        end
    end

    u35.Anchor.Changed:Connect(function(p86)
        u85(p86)
    end)

    if u35.Anchor:GetState() then
        u85(true)
    end

    _LocalPlayer2.CharacterAdded:Connect(function()
        task.wait(0.5)

        if u35.Anchor:GetState() then
            u85(true)
        end
    end)
end
if u35['Auto Buy'] then
    local _Players2 = game:GetService('Players')
    local _RunService = game:GetService('RunService')
    local _Workspace = game:GetService('Workspace')
    local _LocalPlayer3 = _Players2.LocalPlayer
    local u91 = {}
    local u92 = false
    local u93 = nil
    local u94 = nil

    local function u99(p95)
        if not (p95 and p95:IsA('ProximityPrompt')) then
            return false
        end

        local _Parent = p95.Parent

        if not _Parent or _Parent.Name ~= 'PromptAttachment' then
            return false
        end

        local _Parent2 = _Parent.Parent

        if not _Parent2 or _Parent2.Name ~= 'Part' then
            return false
        end

        local _Parent3 = _Parent2.Parent

        return _Parent3 and _Parent3:IsA('Model') and true or false
    end
    local function u101(p100)
        if p100 and p100.Parent then
            if p100.Parent:IsA('Attachment') and (p100.Parent.Name == 'PromptAttachment' and (p100.Parent.Parent and p100.Parent.Parent.Name == 'Part')) then
                return p100.Parent.Parent.Position
            elseif p100.Parent:IsA('BasePart') then
                return p100.Parent.Position
            elseif p100.Parent:IsA('Model') and p100.Parent.PrimaryPart then
                return p100.Parent.PrimaryPart.Position
            else
                return nil
            end
        else
            return nil
        end
    end
    local function u105(p102)
        local v103 = u101(p102)

        if not v103 then
            return false
        end

        local _, v104 = workspace.CurrentCamera:WorldToViewportPoint(v103)

        return v104
    end
    local function u111(p106)
        local v107, v108, v109 = pairs({
            Enum.UserInputType.Keyboard,
            Enum.UserInputType.MouseButton1,
            Enum.UserInputType.Touch,
        })

        while true do
            local u110

            v109, u110 = v107(v108, v109)

            if v109 == nil then
                break
            end

            pcall(function()
                p106:InputHoldBegin(u110)
            end)
        end
    end
    local function u117(p112)
        local v113, v114, v115 = pairs({
            Enum.UserInputType.Keyboard,
            Enum.UserInputType.MouseButton1,
            Enum.UserInputType.Touch,
        })

        while true do
            local u116

            v115, u116 = v113(v114, v115)

            if v115 == nil then
                break
            end

            pcall(function()
                p112:InputHoldEnd(u116)
            end)
        end
    end
    local function u119(p118)
        if u99(p118) and not u91[p118] then
            u91[p118] = true
        end
    end
    local function u121(p120)
        u119(p120)
    end
    local function u133()
        if not u92 then
            u92 = true

            local v122 = _Workspace
            local v123, v124, v125 = pairs(v122:GetDescendants())

            while true do
                local v126

                v125, v126 = v123(v124, v125)

                if v125 == nil then
                    break
                end

                u119(v126)
            end

            if u94 then
                u94:Disconnect()

                u94 = nil
            end

            u94 = _Workspace.DescendantAdded:Connect(u121)

            if u93 then
                u93:Disconnect()

                u93 = nil
            end

            u93 = _RunService.RenderStepped:Connect(function()
                local _Character = _LocalPlayer3.Character

                if _Character then
                    _Character = _Character:FindFirstChild('HumanoidRootPart')
                end
                if _Character then
                    local v128, v129, v130 = pairs(u91)

                    while true do
                        local v131

                        v130, v131 = v128(v129, v130)

                        if v130 == nil then
                            break
                        end
                        if v130 and (v130.Parent and u99(v130)) then
                            local v132 = u101(v130)

                            if v132 then
                                if (_Character.Position - v132).Magnitude > 15 or not u105(v130) then
                                    u117(v130)
                                else
                                    u111(v130)
                                end
                            else
                                u91[v130] = nil
                            end
                        else
                            u91[v130] = nil
                        end
                    end
                end
            end)
        end
    end
    local function u138()
        if u92 then
            u92 = false

            if u93 then
                u93:Disconnect()

                u93 = nil
            end
            if u94 then
                u94:Disconnect()

                u94 = nil
            end

            local v134, v135, v136 = pairs(u91)

            while true do
                local v137

                v136, v137 = v134(v135, v136)

                if v136 == nil then
                    break
                end

                u117(v136)
            end

            u91 = {}
        end
    end

    u35['Auto Buy'].Changed:Connect(function(p139)
        if p139 then
            u133()
        else
            u138()
        end
    end)

    local v140, v141 = pcall(function()
        return u35['Auto Buy']:GetState()
    end)

    if v140 and v141 then
        u133()
    end

    _LocalPlayer3.CharacterRemoving:Connect(function()
        local v142, v143, v144 = pairs(u91)

        while true do
            local v145

            v144, v145 = v142(v143, v144)

            if v144 == nil then
                break
            end

            u117(v144)
        end

        u91 = {}
    end)
end

return u35
