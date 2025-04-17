local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")

local gui = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 260, 0, 150)
frame.Position = UDim2.new(0.5, -130, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local copyBtn = Instance.new("TextButton", frame)
copyBtn.Size = UDim2.new(1, -20, 0, 40)
copyBtn.Position = UDim2.new(0, 10, 0, 10)
copyBtn.Text = "Copy Job ID"
copyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
copyBtn.Font = Enum.Font.SourceSansBold
copyBtn.TextSize = 20

local textbox = Instance.new("TextBox", frame)
textbox.Size = UDim2.new(1, -20, 0, 40)
textbox.Position = UDim2.new(0, 10, 0, 60)
textbox.PlaceholderText = "Enter Job ID"
textbox.Text = ""
textbox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
textbox.TextColor3 = Color3.fromRGB(255, 255, 255)
textbox.Font = Enum.Font.SourceSans
textbox.TextSize = 18
textbox.ClearTextOnFocus = false

local teleportBtn = Instance.new("TextButton", frame)
teleportBtn.Size = UDim2.new(1, -20, 0, 30)
teleportBtn.Position = UDim2.new(0, 10, 0, 110)
teleportBtn.Text = "Teleport"
teleportBtn.BackgroundColor3 = Color3.fromRGB(40, 100, 40)
teleportBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportBtn.Font = Enum.Font.SourceSansBold
teleportBtn.TextSize = 20

copyBtn.MouseButton1Click:Connect(function()
	setclipboard(game.JobId)
	copyBtn.Text = "Copied!"
	task.wait(1.2)
	copyBtn.Text = "Copy Job ID"
end)

teleportBtn.MouseButton1Click:Connect(function()
	local jobId = textbox.Text
	if jobId and jobId ~= "" then
		TeleportService:TeleportToPlaceInstance(game.PlaceId, jobId, Players.LocalPlayer)
	end
end)
