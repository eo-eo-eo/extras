if game.GameId == 6523512604 then
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local UserInputService = game:GetService("UserInputService")

    local player = Players.LocalPlayer
    local gui = Instance.new("ScreenGui")
    gui.Name = "AddCorruptedUI"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromOffset(260, 210)
    frame.Position = UDim2.new(0.5, -130, 0.5, -105)
    frame.BackgroundColor3 = Color3.fromRGB(32, 34, 37)
    frame.BorderSizePixel = 0
    frame.Parent = gui

    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 36)
    title.BackgroundTransparency = 1
    title.Text = "Add Corrupted"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.SourceSansSemibold
    title.TextSize = 22
    title.Parent = frame

    local textbox = Instance.new("TextBox")
    textbox.Size = UDim2.new(1, -30, 0, 34)
    textbox.Position = UDim2.new(0, 15, 0, 46)
    textbox.PlaceholderText = "Enter number"
    textbox.Text = ""
    textbox.ClearTextOnFocus = false
    textbox.Font = Enum.Font.SourceSans
    textbox.TextSize = 18
    textbox.TextColor3 = Color3.new(1, 1, 1)
    textbox.BackgroundColor3 = Color3.fromRGB(47, 49, 54)
    textbox.BorderSizePixel = 0
    textbox.Parent = frame

    Instance.new("UICorner", textbox).CornerRadius = UDim.new(0, 8)

    local function createButton(text, yOffset, callback)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, -30, 0, 34)
        button.Position = UDim2.new(0, 15, 0, yOffset)
        button.Text = text
        button.Font = Enum.Font.SourceSansSemibold
        button.TextSize = 18
        button.TextColor3 = Color3.new(1, 1, 1)
        button.BackgroundColor3 = Color3.fromRGB(64, 68, 75)
        button.BorderSizePixel = 0
        button.Parent = frame
        Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)
        button.MouseButton1Click:Connect(callback)
    end

    createButton("Add", 90, function()
        local value = tonumber(textbox.Text)
        if value then
            ReplicatedStorage:WaitForChild("RemoveCorrupted"):InvokeServer(-value)
        end
    end)

    createButton("Add Inf", 130, function()
        ReplicatedStorage:WaitForChild("RemoveCorrupted"):InvokeServer(-math.huge)
    end)

    createButton("Add NaN", 170, function()
        ReplicatedStorage:WaitForChild("RemoveCorrupted"):InvokeServer(0/0)
    end)

    local dragging, dragInput, startPos, startOffset

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            startPos = input.Position
            startOffset = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - startPos
            frame.Position = UDim2.new(
                startOffset.X.Scale,
                startOffset.X.Offset + delta.X,
                startOffset.Y.Scale,
                startOffset.Y.Offset + delta.Y
            )
        end
    end)
end
