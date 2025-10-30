
game:GetService("ReplicatedStorage").GetUserIdFromUsername:InvokeServer("SilentNinjaDark")
game:GetService("ReplicatedStorage").SetBottingMode:FireServer("user_social", 1396763807)

game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.random(-50,50), 3, math.random(-50,50)))
task.wait(5)

if not workspace:FindFirstChild("AMD") then
	local AMD = Instance.new("Pants", workspace)
	AMD.Name = "AMD"
--// ☁️ AIR MODE + SESSION GUI (Extreme Performance)
--// Turns everything to low visual load + adds minimal info overlay GUI

--// --- CONFIGURATION --- //--
local FPS_CAP = 2
local COLOR_MODE = Color3.new(0, 0, 0) -- black world color (slightly less GPU)
-- You can change to Color3.new(1,1,1) for white

--// --- PERFORMANCE SETTINGS --- //--
pcall(function() setfpscap(FPS_CAP) end)

pcall(function() sethiddenproperty(game:GetService("RunService"), "Render3D", false) end)
pcall(function()
    if game:GetService("RunService").Set3dRenderingEnabled then
        game:GetService("RunService"):Set3dRenderingEnabled(false)
    end
end)

pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)

local function simplifyPart(p)
    if p:IsA("BasePart") then
        p.Material = Enum.Material.SmoothPlastic
        p.Color = COLOR_MODE
        p.Reflectance = 0
        p.CastShadow = false
        p.Anchored = true
        p.CanCollide = false
    elseif p:IsA("MeshPart") then
        p.MeshId = ""
        p.TextureID = ""
        p.Color = COLOR_MODE
    elseif p:IsA("UnionOperation") then
        p.UsePartColor = true
        p.Color = COLOR_MODE
    end
end

for _, obj in ipairs(workspace:GetDescendants()) do simplifyPart(obj) end
workspace.DescendantAdded:Connect(simplifyPart)

for _, d in ipairs(game:GetDescendants()) do
    if d:IsA("Texture") or d:IsA("Decal") then
        d:Destroy()
    end
end
game.DescendantAdded:Connect(function(d)
    if d:IsA("Texture") or d:IsA("Decal") then
        d:Destroy()
    end
end)

local lighting = game:GetService("Lighting")
lighting.GlobalShadows = false
lighting.Brightness = 0
lighting.EnvironmentDiffuseScale = 0
lighting.EnvironmentSpecularScale = 0
lighting.FogEnd = 9e9
lighting.Ambient = COLOR_MODE
lighting.OutdoorAmbient = COLOR_MODE
lighting.ClockTime = 12

for _, e in ipairs(lighting:GetChildren()) do
    if e:IsA("PostEffect") or e:IsA("Atmosphere") or e:IsA("Sky") then
        e:Destroy()
    end
end

for _, v in ipairs(game:GetDescendants()) do
    if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") or v:IsA("Smoke") then
        v.Enabled = false
    end
end
game.DescendantAdded:Connect(function(v)
    if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") or v:IsA("Smoke") then
        v.Enabled = false
    end
end)

for _, s in ipairs(game:GetDescendants()) do
    if s:IsA("Sound") then s.Volume = 0 end
end
game.DescendantAdded:Connect(function(s)
    if s:IsA("Sound") then s.Volume = 0 end
end)

pcall(function()
    local t = workspace.Terrain
    t.WaterWaveSize = 0
    t.WaterWaveSpeed = 0
    t.WaterReflectance = 0
    t.WaterTransparency = 1
end)

print("[AIR MODE] Visuals off, FPS=" .. FPS_CAP .. ", world simplified.")

--// --- FULLSCREEN BLACK GUI SECTION --- //--
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local startTime = tick()

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.Name = "AirModeUI"
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Fullscreen black background
local Background = Instance.new("Frame")
Background.Size = UDim2.new(1, 0, 1, 0)
Background.Position = UDim2.new(0, 0, 0, 0)
Background.BackgroundColor3 = Color3.new(0, 0, 0)
Background.BorderSizePixel = 0
Background.Parent = ScreenGui

-- Center holder for avatar, username, and timer
local Holder = Instance.new("Frame")
Holder.AnchorPoint = Vector2.new(0.5, 0.5)
Holder.Position = UDim2.new(0.5, 0, 0.5, 0)
Holder.Size = UDim2.new(0, 250, 0, 300)
Holder.BackgroundTransparency = 1
Holder.Parent = Background

-- Player avatar thumbnail
local Thumb = Instance.new("ImageLabel")
Thumb.AnchorPoint = Vector2.new(0.5, 0)
Thumb.Position = UDim2.new(0.5, 0, 0, 20)
Thumb.Size = UDim2.new(0, 150, 0, 150)
Thumb.BackgroundTransparency = 1
Thumb.Image = ("rbxthumb://type=AvatarHeadShot&id=%d&w=180&h=180"):format(player.UserId)
Thumb.Parent = Holder

-- Username label
local NameLabel = Instance.new("TextLabel")
NameLabel.AnchorPoint = Vector2.new(0.5, 0)
NameLabel.Position = UDim2.new(0.5, 0, 0, 190)
NameLabel.Size = UDim2.new(1, -20, 0, 40)
NameLabel.BackgroundTransparency = 1
NameLabel.Font = Enum.Font.GothamBold
NameLabel.TextScaled = true
NameLabel.TextColor3 = Color3.new(1, 1, 1)
NameLabel.Text = player.DisplayName or player.Name
NameLabel.Parent = Holder

-- Timer label
local TimerLabel = Instance.new("TextLabel")
TimerLabel.AnchorPoint = Vector2.new(0.5, 0)
TimerLabel.Position = UDim2.new(0.5, 0, 0, 240)
TimerLabel.Size = UDim2.new(1, -20, 0, 40)
TimerLabel.BackgroundTransparency = 1
TimerLabel.Font = Enum.Font.Gotham
TimerLabel.TextScaled = true
TimerLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
TimerLabel.Text = "Playtime: 00:00:00"
TimerLabel.Parent = Holder

-- Follower label
local FollowerLabel = Instance.new("TextLabel")
FollowerLabel.AnchorPoint = Vector2.new(0.5, 0)
FollowerLabel.Position = UDim2.new(0.5, 0, 0, 280)
FollowerLabel.Size = UDim2.new(1, -20, 0, 40)
FollowerLabel.BackgroundTransparency = 1
FollowerLabel.Font = Enum.Font.Gotham
FollowerLabel.TextScaled = true
FollowerLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
FollowerLabel.Text = "New Followers: 9,999,999"
FollowerLabel.Parent = Holder

-- Update timer every second
task.spawn(function()
    while task.wait(1) do
        local elapsed = math.floor(tick() - startTime)
        local h = math.floor(elapsed / 3600)
        local m = math.floor((elapsed % 3600) / 60)
        local s = elapsed % 60
        TimerLabel.Text = string.format("Playtime: %02d:%02d:%02d", h, m, s)
		FollowerLabel.Text = "Total Followers:" .. game:GetService("Players").LocalPlayer.leaderstats["Total Requested"].Value
    end
end)
--// --- SIMPLE ANTI-AFKv2 --- //--
task.spawn(function()
    local VIM = game:GetService("VirtualInputManager")
    while true do
        VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
        VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
        wait(5)
    end
end)
--// --- SIMPLE ANTI-AFK --- //--
task.spawn(function()
local vu = game:GetService("VirtualUser")
	game:GetService("Players").LocalPlayer.Idled:Connect(function()
    	vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    	task.wait(1)
    	vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
	end)
end)
print("[Air Mode UI] Fullscreen session info displayed.")
elseif workspace:FindFirstChild("AMD") then
	print("Already Executed.")
end
