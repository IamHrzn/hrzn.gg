--> Chat spy

repeat task.wait() until game:IsLoaded()
shared.Console = {Connections = {}}

local function AddConnection(Signal, Function)
    if (not shared.Console:IsRunning()) then return end
    local Connection = Signal:Connect(Function)
    table.insert(shared.Console.Connections, Connection)
    return Connection
end

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()


local function AddConnection(Signal, Function)
	local Connection = Signal:Connect(Function)
	return Connection
end

local function MakeDraggable(DragPoint, Main)
	pcall(function()
		local Dragging, DragInput, MousePos, FramePos = false
		AddConnection(DragPoint.InputBegan, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				MousePos = Input.Position
				FramePos = Main.Position

				AddConnection(Input.Changed, function()
					if Input.UserInputState == Enum.UserInputState.End then
						Dragging = false
					end
				end)
			end
		end)
		AddConnection(DragPoint.InputChanged, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseMovement then
				DragInput = Input
			end
		end)
		AddConnection(UserInputService.InputChanged, function(Input)
			if (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) and Dragging then
				local Delta = Input.Position - MousePos
				Main.Position  = UDim2.new(FramePos.X.Scale,FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)
			end
		end)
	end)
end

local function Create(Name, Properties, Children)
    local Object = Instance.new(tostring(Name))
    for i, v in next, Properties or {} do
        Object[tostring(i)] = v
    end
    for i, v in next, Children or {} do
        v.Parent = Object
    end
    return Object
end

local screen_gui = Instance.new("ScreenGui")
screen_gui.IgnoreGuiInset = false
screen_gui.ResetOnSpawn = false
screen_gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screen_gui.Parent = gethui()

local GUI = Create("ScreenGui", {
    Parent = gethui(),
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
})

local CanvasGroup = Create("CanvasGroup", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392),
    BorderColor3 = Color3.new(0, 0, 0),
    BorderSizePixel = 0,
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0, 600, 0, 350),
    Visible = true, Parent = GUI 
}, {
    Create("UICorner", {
        CornerRadius = UDim.new(0,5),
        Parent = TopBar
    })
})

local TopBar = Create("Frame", {
    BackgroundColor3 = Color3.new(0.105882, 0.105882, 0.105882),
    Position = UDim2.new(0, 0, 0, -1),
    Size = UDim2.new(1, 0, 0, 38),
    Visible = true,
    ZIndex = 2,
    Name = "TopBar",
    Parent = CanvasGroup
}, {
    Create("UICorner", {
        CornerRadius = UDim.new(0,5),
        Parent = TopBar
    })
})


local BackFrame = Create("Frame", {
    BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078),
    BackgroundTransparency = 0.4000000059604645,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 0, 1, 0),
    Size = UDim2.new(1, 0, 0, 1),
    Visible = true,
    ZIndex = 2,
    Parent = TopBar
})

local ConsoleName = Create("TextLabel", {
    Font = Enum.Font.Gotham,
    RichText = true,
    Text = "Console",
    TextColor3 = Color3.new(0.705882, 0.705882, 0.705882),
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left,
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 1, 0),
    Visible = true,
    ZIndex = 2,
    Parent = TopBar
}, {
    Create("UIPadding", {
        PaddingLeft = UDim.new(0, 15)
    })
})

local ExitButton = Create("TextButton", {
    Text = "",
    BackgroundTransparency = 1,
    Position = UDim2.new(1, -34, 0, 4),
    Size = UDim2.new(1, -8, 1, -8),
    SizeConstraint = Enum.SizeConstraint.RelativeYY,
    Visible = true,
    ZIndex = 2,
    Parent = TopBar
}, {
    Create("ImageLabel", {
        Image = "rbxassetid://6235536018",
        ImageColor3 = Color3.new(0.705882, 0.705882, 0.705882),
        ScaleType = Enum.ScaleType.Crop,
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, -9, 0.5, -9),
        Size = UDim2.new(0, 18, 0, 18),
        Visible = true,
        ZIndex = 2,
        Name = "Ico",
    })
})

local Hover = Create("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.new(0.14902, 0.14902, 0.14902),
    BackgroundTransparency = 1,
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0.800000012, 0, 0.800000012, 0),
    Visible = true,
    ZIndex = 2,
    Name = "Hover",
    Parent = ExitButton
}, {
    Create("UICorner", {
        CornerRadius = UDim.new(0,5),
        Parent = TopBar
    })
})

local ScrollingFrame = Create("ScrollingFrame", {
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    ScrollBarImageColor3 = Color3.new(0.196078, 0.196078, 0.196078),
    ScrollBarThickness = 2,
    AnchorPoint = Vector2.new(0.5, 1),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Position = UDim2.new(0.5, 0, 1, 0),
    Size = UDim2.new(1, -1, 1, -40),
    Visible = true,
    Parent = CanvasGroup
}, {
    Create("UIPadding", {
        PaddingTop = UDim.new(0, 13),
        PaddingBottom = UDim.new(0, 20)
    }),

    Create("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Name = "Layout"
    }),
})

--> Code
MakeDraggable(TopBar, CanvasGroup)

ScrollingFrame.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	ScrollingFrame.CanvasSize = UDim2.new(0,0,0,ScrollingFrame.Layout.AbsoluteContentSize.Y + 28)
end)

ExitButton.MouseEnter:Connect(function()
	TweenService:Create(Hover, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 0}):Play()
	TweenService:Create(ExitButton.Ico, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(255, 0, 0)}):Play()
end)

ExitButton.MouseLeave:Connect(function()
	TweenService:Create(Hover, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0.8, 0, 0.8, 0), BackgroundTransparency = 1}):Play()
	TweenService:Create(ExitButton.Ico, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(180, 180, 180)}):Play()
end)

local function getTime()
	local date = os.date("*t")
	local h = string.format("%02d", date.hour)
	local m = string.format("%02d", date.min)
	return `{h}:{m}`
end

local frameCounter = 0
local ColorBG = Color3.fromRGB(29, 29, 29)

function newPrint(text)
	frameCounter = frameCounter + 1

	if frameCounter % 2 == 0 then
		ColorBG = Color3.fromRGB(27, 27, 27)
	else
		ColorBG = Color3.fromRGB(29, 29, 29)
	end

	local frame = Instance.new("Frame")
	frame.AutomaticSize = Enum.AutomaticSize.Y
	frame.BackgroundColor3 = ColorBG
	frame.BorderColor3 = Color3.new(0, 0, 0)
	frame.BorderSizePixel = 0
	frame.Size = UDim2.new(1, -2, 0, 35)
	frame.Visible = true
	frame.Parent = ScrollingFrame

	local _1time = Instance.new("TextLabel")
	_1time.Font = Enum.Font.Gotham
	_1time.Text = getTime()
	_1time.TextColor3 = Color3.new(0.729412, 0.729412, 0.729412)
	_1time.TextSize = 14
	_1time.TextXAlignment = Enum.TextXAlignment.Left
	_1time.BackgroundColor3 = Color3.new(1, 1, 1)
	_1time.BackgroundTransparency = 1
	_1time.BorderColor3 = Color3.new(0, 0, 0)
	_1time.BorderSizePixel = 0
	_1time.Size = UDim2.new(0, 65, 0, 35)
	_1time.Visible = true
	_1time.Name = "1time"
	_1time.Parent = frame

	local uipadding = Instance.new("UIPadding")
	uipadding.PaddingLeft = UDim.new(0, 15)
	uipadding.Parent = _1time

	local _2textbox = Instance.new("TextBox")
	_2textbox.Font = Enum.Font.Gotham
	_2textbox.LineHeight = 1.399999976158142
	_2textbox.MultiLine = true
	_2textbox.PlaceholderText = "Some Text..."
	_2textbox.RichText = true
	_2textbox.Text = text
	_2textbox.TextColor3 = Color3.new(0.870588, 0.870588, 0.870588)
	_2textbox.TextSize = 14
	_2textbox.ClearTextOnFocus = false
	_2textbox.TextTruncate = Enum.TextTruncate.AtEnd
	_2textbox.TextWrapped = true
	_2textbox.TextXAlignment = Enum.TextXAlignment.Left
	_2textbox.TextYAlignment = Enum.TextYAlignment.Top
	_2textbox.AutomaticSize = Enum.AutomaticSize.Y
	_2textbox.BackgroundColor3 = Color3.new(1, 1, 1)
	_2textbox.BackgroundTransparency = 1
	_2textbox.BorderColor3 = Color3.new(0, 0, 0)
	_2textbox.BorderSizePixel = 0
	_2textbox.Position = UDim2.new(0.10851419, 0, 0, 0)
	_2textbox.Size = UDim2.new(1, -109, 0, 35)
	_2textbox.Visible = true
	_2textbox.Name = "2textbox"
	_2textbox.Parent = frame

	local uistroke = Instance.new("UIStroke")
	uistroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	uistroke.Color = Color3.new(0.0784314, 0.0784314, 0.0784314)
	uistroke.Parent = _2textbox

	local uipadding_2 = Instance.new("UIPadding")
	uipadding_2.PaddingBottom = UDim.new(0, 10)
	uipadding_2.PaddingLeft = UDim.new(0, 15)
	uipadding_2.PaddingRight = UDim.new(0, 15)
	uipadding_2.PaddingTop = UDim.new(0, 10)
	uipadding_2.Parent = _2textbox

	local _3f = Instance.new("Frame")
	_3f.BackgroundColor3 = Color3.new(1, 1, 1)
	_3f.BackgroundTransparency = 1
	_3f.BorderColor3 = Color3.new(0, 0, 0)
	_3f.BorderSizePixel = 0
	_3f.Position = UDim2.new(0.926544249, 0, 0, 0)
	_3f.Size = UDim2.new(0, 45, 1, 0)
	_3f.Visible = true
	_3f.Name = "3f"
	_3f.Parent = frame

	local copy = Instance.new("TextButton")
	copy.Font = Enum.Font.Gotham
	copy.Text = "C"
	copy.TextColor3 = Color3.new(1, 1, 1)
	copy.TextSize = 14
	copy.AnchorPoint = Vector2.new(0.5, 0.5)
	copy.BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255)
	copy.BorderColor3 = Color3.new(0, 0, 0)
	copy.BorderSizePixel = 0
	copy.Position = UDim2.new(0.5, 0, 0.5, 0)
	copy.Size = UDim2.new(0, 25, 0, 25)
	copy.Visible = true
	copy.Name = "copy"
	copy.Parent = _3f

	local uicorner = Instance.new("UICorner")
	uicorner.CornerRadius = UDim.new(0, 5)
	uicorner.Parent = copy

	local uistroke_2 = Instance.new("UIStroke")
	uistroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	uistroke_2.Color = Color3.new(0.0784314, 0.0784314, 0.0784314)
	uistroke_2.Parent = frame

	local uilist_layout = Instance.new("UIListLayout")
	uilist_layout.FillDirection = Enum.FillDirection.Horizontal
	uilist_layout.Parent = frame
end

function shared.Console:Clear()
    for _,logs in pairs(ScrollingFrame:GetChildren()) do
        if logs:IsA("Frame") then
            logs:Destroy()
        end
    end
end

function shared.Console:Load(title : string)
    ConsoleName.Text = title
end

function shared.Console:Set(state : boolean)
    GUI.Enabled = state
end

function shared.Console:Log(... : string)
    newPrint(...)
end

shared.Console:Load("Console | Fluxgg")
shared.Console:Set(false)
