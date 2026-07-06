-- Scribble's Vortex Admin Bootstrap
repeat task.wait() until game:IsLoaded()
local Http = game:GetService("HttpService")
local Core = game:GetService("CoreGui")
local Plr = game.Players.LocalPlayer
local Data = Http:JSONDecode(game:HttpGet("https://raw.githubusercontent.com/ScribbleDevelopment/vortex-admin/refs/heads/main/admin_commands.json")).Commands

local function run(cmdName)
    local cmd = Data[string.lower(cmdName)]
    if cmd then
        local success, err = pcall(function()
            loadstring("local Character = game.Players.LocalPlayer.Character; local Humanoid = Character:FindFirstChild('Humanoid'); local HumanoidRootPart = Character:FindFirstChild('HumanoidRootPart'); " .. cmd)()
        end)
        if not success then warn("Vortex Error: " .. tostring(err)) end
    end
end

local Gui = Instance.new("ScreenGui", Core)
local Scroll = Instance.new("ScrollingFrame", Gui)
Scroll.Size = UDim2.new(0, 160, 0, 300); Scroll.Position = UDim2.new(0, 10, 0.2, 0)
Scroll.CanvasSize = UDim2.new(0, 0, 5, 0); Scroll.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local i = 0
for n, c in pairs(Data) do
    local b = Instance.new("TextButton", Scroll)
    b.Size = UDim2.new(1, -10, 0, 30); b.Position = UDim2.new(0, 5, 0, i * 35)
    b.Text = n; b.MouseButton1Click:Connect(function() run(n) end)
    i = i + 1
end

local Txt = Instance.new("TextBox", Gui)
Txt.Size = UDim2.new(0, 160, 0, 30); Txt.Position = UDim2.new(0, 10, 0.2, 305)
Txt.PlaceholderText = "Cmd..."
Txt.FocusLost:Connect(function(e) if e then run(Txt.Text) end end)

Plr.Chatted:Connect(function(m) if m:sub(1,1)=="/" then run(m:sub(2)) end end)
