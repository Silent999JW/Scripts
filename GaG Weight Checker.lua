local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Remove old GUI if exists
for i, v in pairs(PlayerGui:GetChildren()) do
    if v:IsA("ScreenGui") and v.Name == "WeightMarkers" then
        v:Destroy()
    end
end

local farmFolder = workspace:FindFirstChild("Farm")
if not farmFolder then return end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WeightMarkers"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

local function formatWeight(value)
    return string.format("%.1f", value)
end

local function getColorByWeight(weight)
    if weight > 100 then
        return Color3.new(0, 0, 0)
    elseif weight > 50 then
        return Color3.fromRGB(255, 0, 0)
    elseif weight >= 40 then
        return Color3.fromRGB(255, 165, 0)
    elseif weight >= 10 then
        return Color3.fromRGB(255, 255, 0)
    else
        return Color3.new(1, 1, 1)
    end
end

local function findFirstPartInParent(parent)
    for i, v in ipairs(parent:GetChildren()) do
        if v:IsA("BasePart") then
            return v
        end
    end
    return nil
end

for _, playerFarm in ipairs(farmFolder:GetChildren()) do
    local important = playerFarm:FindFirstChild("Important")
    if important then
        local plantsPhysical = important:FindFirstChild("Plants_Physical")
        if plantsPhysical then
            for _, obj in ipairs(plantsPhysical:GetDescendants()) do
                if obj:IsA("NumberValue") and obj.Name == "Weight" then
                    local parentModel = obj.Parent
                    if parentModel and parentModel:IsA("Model") then
                        local part = findFirstPartInParent(parentModel)
                        if part then
                            local billboard = Instance.new("BillboardGui")
                            billboard.Name = "WeightGui"
                            billboard.Adornee = part
                            billboard.AlwaysOnTop = true
                            billboard.Size = UDim2.new(0, 90, 0, 25)
                            billboard.StudsOffset = Vector3.new(0, part.Size.Y + 1.5, 0)
                            billboard.LightInfluence = 0
                            billboard.MaxDistance = 10000
                            billboard.Parent = screenGui

                            local label = Instance.new("TextLabel")
                            label.Size = UDim2.new(1, 0, 1, 0)
                            label.BackgroundTransparency = 0.5
                            label.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                            label.TextColor3 = getColorByWeight(obj.Value)
                            label.TextStrokeColor3 = Color3.new(0, 0, 0)
                            label.TextStrokeTransparency = 0.3
                            label.TextScaled = false
                            label.TextSize = 18
                            label.Font = Enum.Font.GothamBold
                            label.Text = formatWeight(obj.Value) .. " kg"
                            label.Parent = billboard

                            local uiCorner = Instance.new("UICorner")
                            uiCorner.CornerRadius = UDim.new(0, 8)
                            uiCorner.Parent = label

                            obj:GetPropertyChangedSignal("Value"):Connect(function()
                                label.Text = formatWeight(obj.Value) .. " kg"
                                label.TextColor3 = getColorByWeight(obj.Value)
                            end)
                        end
                    end
                end
            end
        end
    end
end
