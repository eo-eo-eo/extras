local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 320, 0, 210)
frame.Position = UDim2.new(0.5, -160, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local dragBar = Instance.new("Frame")
dragBar.Size = UDim2.new(1, 0, 0, 30)
dragBar.Position = UDim2.new(0, 0, 0, 0)
dragBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
dragBar.BorderSizePixel = 0
dragBar.Parent = frame

local dragLabel = Instance.new("TextLabel")
dragLabel.Size = UDim2.new(1, 0, 1, 0)
dragLabel.BackgroundTransparency = 1
dragLabel.Text = "Remote / Bindable Fire Tool by funny"
dragLabel.Font = Enum.Font.GothamBold
dragLabel.TextSize = 18
dragLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
dragLabel.TextXAlignment = Enum.TextXAlignment.Center
dragLabel.TextYAlignment = Enum.TextYAlignment.Center
dragLabel.Parent = dragBar

local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(85, 170, 255)
uiStroke.Thickness = 2
uiStroke.Parent = frame

local remoteBox = Instance.new("TextBox")
remoteBox.PlaceholderText = "Remote / Bindable Name"
remoteBox.Size = UDim2.new(1, -20, 0, 35)
remoteBox.Position = UDim2.new(0, 10, 0, 40)
remoteBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
remoteBox.TextColor3 = Color3.fromRGB(230, 230, 230)
remoteBox.BorderSizePixel = 0
remoteBox.Text = ""
remoteBox.Font = Enum.Font.Gotham
remoteBox.TextSize = 18
remoteBox.TextXAlignment = Enum.TextXAlignment.Center
remoteBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
remoteBox.Parent = frame

local argsBox = Instance.new("TextBox")
argsBox.PlaceholderText = "Args (comma separated)"
argsBox.Size = UDim2.new(1, -20, 0, 35)
argsBox.Position = UDim2.new(0, 10, 0, 85)
argsBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
argsBox.TextColor3 = Color3.fromRGB(230, 230, 230)
argsBox.BorderSizePixel = 0
argsBox.Text = ""
argsBox.Font = Enum.Font.Gotham
argsBox.TextSize = 18
argsBox.TextXAlignment = Enum.TextXAlignment.Center
argsBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
argsBox.Parent = frame

local fireButton = Instance.new("TextButton")
fireButton.Text = "Fire"
fireButton.Size = UDim2.new(1, -20, 0, 40)
fireButton.Position = UDim2.new(0, 10, 0, 130)
fireButton.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
fireButton.TextColor3 = Color3.fromRGB(255, 255, 255)
fireButton.BorderSizePixel = 0
fireButton.Font = Enum.Font.GothamBold
fireButton.TextSize = 22
fireButton.Parent = frame

local printButton = Instance.new("TextButton")
printButton.Text = "Print Remotes/Binds"
printButton.Size = UDim2.new(1, -20, 0, 30)
printButton.Position = UDim2.new(0, 10, 0, 180)
printButton.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
printButton.TextColor3 = Color3.fromRGB(255, 255, 255)
printButton.BorderSizePixel = 0
printButton.Font = Enum.Font.GothamBold
printButton.TextSize = 18
printButton.Parent = frame

local foundObject = nil

remoteBox.FocusLost:Connect(function()
	local name = remoteBox.Text
	foundObject = game.ReplicatedStorage:FindFirstChild(name) or workspace:FindFirstChild(name)
	if not foundObject then
		StarterGui:SetCore("SendNotification", {
			Title = "Warning",
			Text = "Object not found",
			Duration = 2,
		})
	end
end)

fireButton.MouseButton1Click:Connect(function()
	if not foundObject then return end
	local args = {}
	for val in string.gmatch(argsBox.Text, "([^,]+)") do
		local num = tonumber(val)
		if num then
			table.insert(args, num)
		else
			table.insert(args, val)
		end
	end
	if foundObject:IsA("RemoteEvent") then
		foundObject:FireServer(unpack(args))
	elseif foundObject:IsA("RemoteFunction") then
		foundObject:InvokeServer(unpack(args))
	elseif foundObject:IsA("BindableEvent") then
		foundObject:Fire(unpack(args))
	elseif foundObject:IsA("BindableFunction") then
		foundObject:Invoke(unpack(args))
	end
end)

printButton.MouseButton1Click:Connect(function()
	local remotes = {}
	local function search(parent)
		for _, child in pairs(parent:GetChildren()) do
			if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") or child:IsA("BindableEvent") or child:IsA("BindableFunction") then
				table.insert(remotes, child:GetFullName())
			end
			search(child)
		end
	end
	search(game)
	print("Remotes and Bindables:")
	for _, v in pairs(remotes) do
		print(v)
	end
end)
