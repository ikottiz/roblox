local tweenService = game:GetService('TweenService')
local userInputService = game:GetService('UserInputService')
local runService = game:GetService('RunService')
local studio = runService:IsStudio()
local coreGui = ((studio and game.Players.LocalPlayer.PlayerGui) or game:GetService('CoreGui'))
local mouse = game.Players.LocalPlayer:GetMouse()

local function tween(instance, time, properties)
	tweenService:Create(instance, TweenInfo.new(time), properties):Play()
end
local function mouseOverFrame(frame)
	local AbsPos, AbsSize = frame.AbsolutePosition, frame.AbsoluteSize;

	if mouse.X >= AbsPos.X and mouse.X <= AbsPos.X + AbsSize.X and mouse.Y >= AbsPos.Y and mouse.Y <= AbsPos.Y + AbsSize.Y then

		return true
	end
end
local function create(instance,properties)
	local object = Instance.new(instance)

	for property,value in next,properties do
		object[property] = value
	end

	return object
end
local function createUICorner(instance,radius)
	local object = Instance.new("UICorner",instance)

	object.CornerRadius = radius or UDim.new(0,8)

	return object
end
local function createList(instance,properties)
	local object = Instance.new("UIListLayout",instance)

	for property,value in next,properties do
		object[property] = value
	end

	return object
end
local function makeDraggable(object, Main)
	pcall(function()
		local Dragging = false
		local DragInput, MousePos, FramePos = nil
		object.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 then
				Dragging = true
				MousePos = Input.Position
				FramePos = Main.Position

				Input.Changed:Connect(function()
					if Input.UserInputState == Enum.UserInputState.End then
						Dragging = false
					end
				end)
			end
		end)
		object.InputChanged:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseMovement then
				DragInput = Input
			end
		end)
		userInputService.InputChanged:Connect(function(Input)
			if Input == DragInput and Dragging then
				local Delta = Input.Position - MousePos
				tween(Main, 0.1, {Position  = UDim2.new(FramePos.X.Scale,FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)})
			end
		end)
	end)
end   
if not studio then
	for i,v in next,coreGui:GetChildren() do
		if v.Name == "TRXUI" then
			v:Destroy()
		end
	end
end
local library = {}
library.CreateWindow = function(name,keybind)
	local ScreenGui = create("ScreenGui",{
		Name = 'TRXUI',
		ResetOnSpawn = 2,
		Parent = coreGui
	})

	wait(2.5)
	local Loader = create("Frame",{
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 0, 0, 0),
		Name = "Loader",
		Parent = ScreenGui
	})
	local Logo = create("Frame",{
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(255,255, 255),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 0, 0, 0),
		Name = "Logo",
		Parent = Loader
	})
	local gradient = create("UIGradient",{
		Color = ColorSequence.new(Color3.fromRGB(95,86,199),Color3.fromRGB(64,51,129)),
		Enabled = true,
		Rotation = 45,
		Parent = Logo
	})
	local Temp1 = createUICorner(Logo,UDim.new(0,45))
	local LogoImage = create("ImageLabel",{
		Image = "rbxassetid://13461873878",
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		LayoutOrder = -1,
		Position = UDim2.new(0.0909090936, 0, 0.0909090936, 0),
		Size = UDim2.new(0.818181813, 0, 0.818181813, 0),
		Name = "LogoImage",
		Parent = Logo
	})
	local TextLabel = create("TextLabel",{
		Font = Enum.Font.Gotham,
		Text = "Experience Roblox like never before",
		TextScaled = false,
		TextSize = 0,
		TextTransparency = 1,
		TextColor3 = Color3.fromRGB(247, 247, 247),
		TextStrokeColor3 = Color3.fromRGB(50, 50, 50),
		TextStrokeTransparency = 0.6000000238418579,
		AnchorPoint = Vector2.new(0.5,0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 1, 0),
		Size = UDim2.new(0, 0, 0, 0),
		Parent = Logo
	})
	tween(TextLabel,0.5,{Size = UDim2.new(1.464, 0,0.179, 0),TextTransparency = 0,TextSize = 25})
	tween(Loader,0.5,{Size = UDim2.new(0,280,0,280)})
	tween(Logo,0.5,{Size = UDim2.new(1,0,1,0)})
	wait(2)
	tween(Logo,0.5,{BackgroundColor3 = Color3.fromRGB(30, 30, 30),BackgroundTransparency = 0.2})
	wait(1.5)
	LogoImage.Image = ""
	TextLabel:Destroy()
	TextLabel = nil
	tween(Loader,0.5,{Size = UDim2.new(0,600,0,350)})
	tween(Temp1,0.5,{CornerRadius = UDim.new(0,15)})
	wait(0.55)
	Loader:Destroy()
	Loader = nil
	Logo:Destroy()
	Logo = nil
	LogoImage:Destroy()
	LogoImage = nil
	gradient = nil
	local Window = create("Frame",{
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(17, 17, 18),
		BackgroundTransparency = 0,
		ClipsDescendants = true,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 600, 0, 350),
		Name = "Window",
		Parent = ScreenGui
	})
	createUICorner(Window)
	local Notifications = create("Frame",{
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0.913073719, 0, 0.670212805, 0),
		Size = UDim2.new(0, 250, 0, 500),
		Name = "Notifications",
		Parent = ScreenGui
	})
	createList(Notifications,{
		Padding = UDim.new(0, 5),
		SortOrder = Enum.SortOrder.LayoutOrder,
		VerticalAlignment = Enum.VerticalAlignment.Bottom
	})
	local PagesListHolder = create("Frame",{
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0.094, 0, 0.5, 0),
		Size = UDim2.new(0, 108, 0, 348),
		ZIndex = -1,
		Name = "PagesListHolder",
		Parent = Window
	})
	local Logo = create("Frame",{
		BackgroundColor3 = Color3.fromRGB(255,255,255),
		Position = UDim2.new(0.280000001, 0, 0.0257142857, 0),
		Size = UDim2.new(0, 44, 0, 44),
		Name = "Logo",
		Parent = PagesListHolder,
	})
	local gradient = create("UIGradient",{
		Color = ColorSequence.new(Color3.fromRGB(95,86,199),Color3.fromRGB(64,51,129)),
		Enabled = true,
		Rotation = 45,
		Parent = Logo
	})
	createUICorner(Logo,UDim.new(0,10))
	local LogoImage = create("ImageLabel",{
		Image = "rbxassetid://13461873878",
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		LayoutOrder = -1,
		Position = UDim2.new(0.0909090936, 0, 0.0909090936, 0),
		Size = UDim2.new(0.818181813, 0, 0.818181813, 0),
		Name = "LogoImage",
		Parent = Logo
	})
	local LogoName = create("TextLabel",{
		Font = Enum.Font.Gotham,
		Text = name or "TRX BETA",
		TextColor3 = Color3.fromRGB(93, 87, 255),
		TextSize = 13,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0.18, 0),
		Size = UDim2.new(0, 95, 0, 19),
		Name = "LogoName",
		Parent = PagesListHolder
	})
	local PagesListContent = create("ScrollingFrame",{
		CanvasSize = UDim2.new(0, 0, 1, 0),
		ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
		ScrollBarThickness = 6,
		VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left,
		Active = true,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0.61, 0),
		Size = UDim2.new(1, 0, 0, 275),
		Name = "PagesListContent",
		Parent = PagesListHolder
	})
	createList(PagesListContent,{
		Padding = UDim.new(0, 5),
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = PagesListContent
	})
	local PagesContentHolder = create("Frame",{
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0.583992124, 0, 0.500217795, 0),
		Size = UDim2.new(0, 498, 0, 348),
		ZIndex = -1,
		Name = "PagesContentHolder",
		Parent = Window
	})

	makeDraggable(Window,Window)
	makeDraggable(PagesListHolder,Window)
	makeDraggable(Logo,Window)

	runService.RenderStepped:Connect(function()
		PagesListContent.CanvasSize = UDim2.new(0,0,0,PagesListContent.UIListLayout.AbsoluteContentSize.Y)
	end)
	local WindowFunctions = {}
	WindowFunctions.CreatePage = function(name,default)
		local PageButton = create("TextButton",{
			Font = Enum.Font.Gotham,
			Text = name or "Page name",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 13,
			AnchorPoint = Vector2.new(0.5, 0.5),
			AutoButtonColor = false,
			BackgroundTransparency = (default and 0.6) or 0.4,
			BackgroundColor3 = (default and Color3.fromRGB(64, 51, 129)) or Color3.fromRGB(30, 30, 30),
			Position = UDim2.new(1, 0, 0.0545454547, 0),
			Size = UDim2.new(0, 100, 0, 30),
			ZIndex = 2,
			Name = "PageButton",
			Parent = PagesListContent
		})
		createUICorner(PageButton)
		local PageContent = create("ScrollingFrame",{
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			CanvasSize = UDim2.new(0, 0, 1, 0),
			ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
			ScrollBarThickness = 6,
			Active = true,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0.5, 0, 0.485, 0),
			Size = UDim2.new(0, 500, 0, 320),
			Name = "PageContent",
			Visible = (default and true) or false,
			Parent = PagesContentHolder
		})
		createList(PageContent,{
			Padding = UDim.new(0, 5),
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
		})
		PageButton.MouseButton1Click:Connect(function()
			for i,v in next,PagesContentHolder:GetChildren() do
				if v ~= PageContent then
					v.Visible = false
					PageContent.Visible = true
				end
			end
			for i,v in next,PagesListContent:GetChildren() do
				if v.ClassName == 'TextButton' and v ~= PageButton then
					tween(v,0.1,{BackgroundTransparency = 0.4,BackgroundColor3 = Color3.fromRGB(30, 30, 30)})
				end
				tween(PageButton,0.1,{BackgroundTransparency = 0.6,BackgroundColor3 = Color3.fromRGB(64, 51, 129)})
			end
		end)

		local Elements = {}
		Elements.CreateButton = function(text,callback)
			text = text or "Button"
			callback = callback or function() end
			local ButtonElement = create("Frame",{
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromRGB(30, 30, 30),
				BackgroundTransparency = 0.6499999761581421,
				BorderSizePixel = 0,
				LayoutOrder = 3,
				Position = UDim2.new(0.0199999996, 0, 0, 0),
				Size = UDim2.new(0, 480, 0, 45),
				Name = "ButtonElement",
				Parent = PageContent
			})
			local Interact = create("ImageButton",{
				Image = "rbxassetid://13467147168",
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromRGB(212, 212, 212),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.new(0.95, 0, 0.5, 0),
				Size = UDim2.new(0, 25, 0, 25),
				Name = "Interact",
				Parent = ButtonElement
			})
			local Name = create("TextLabel",{
				Font = Enum.Font.Gotham,
				Text = text,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 13,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(0, 180, 0, 45),
				Name = "Name",
				Parent = ButtonElement
			})
			createUICorner(ButtonElement)

			Interact.MouseButton1Click:Connect(function()
				callback()
				tween(ButtonElement,0.1,{BackgroundColor3 = Color3.fromRGB(64,51,129)})
				wait(0.1)
				ButtonElement.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			end)
		end
		Elements.CreateLabel = function(text)
			text = text or "Label"
			local LabelElement = create("Frame",{
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromRGB(30, 30, 30),
				BackgroundTransparency = 0.6499999761581421,
				BorderSizePixel = 0,
				LayoutOrder = 3,
				Position = UDim2.new(0.0199999996, 0, 0, 0),
				Size = UDim2.new(0, 480, 0, 45),
				Name = "LabelElement",
				Parent = PageContent
			});
			local Name = create("TextLabel",{
				Font = Enum.Font.Gotham,
				Text = text,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 13,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(0, 480, 0, 45),
				Name = "Name",
				Parent = LabelElement
			});
			createUICorner(LabelElement)
		end
		Elements.CreateSlider = function(text,min,max,default,callback)
			text = text or "Slider"
			min = min or 0
			max = max or 100
			default = default or 50
			callback = callback or function() end
			local SliderElement = create("Frame",{
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromRGB(30, 30, 30),
				BackgroundTransparency = 0.6499999761581421,
				BorderSizePixel = 0,
				LayoutOrder = 1,
				Position = UDim2.new(0.5, 0, 0, 0),
				Size = UDim2.new(0, 480, 0, 45),
				Name = "SliderElement",
				Parent = PageContent
			})
			local Name = create("TextLabel",{
				Font = Enum.Font.Gotham,
				Text = text,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 13,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(0, 180, 0, 45),
				Name = "Name",
				Parent = SliderElement
			})
			local Slider = create("Frame",{
				Active = true,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromRGB(29, 31, 36),
				Position = UDim2.new(0.686458468, 0, 0.533333361, 0),
				Selectable = true,
				Size = UDim2.new(0, 200, 0, 5),
				Name = "Slider",
				Parent = SliderElement
			})
			createUICorner(Slider)
			local SliderFilled = create("Frame",{
				Active = true,
				AnchorPoint = Vector2.new(0.0, 0.5),
				BackgroundColor3 = Color3.fromRGB(64, 51, 129),
				Position = UDim2.new(0.0, 0, 0.5, 0),
				Selectable = true,
				Size = UDim2.new(0.5, 0, 0, 5),
				Name = "SliderFilled",
				Parent = Slider
			})
			createUICorner(SliderFilled)
			local ImageButton = create("ImageButton",{
				Image = "rbxasset://textures/ui/GuiImagePlaceholder.png",
				ImageTransparency = 1,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromRGB(248, 248, 248),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				Size = UDim2.new(0, 5, 0, 15),
				ZIndex = 2,
				Parent = Slider
			})
			createUICorner(ImageButton,UDim.new(0,25))
			local Value = create("TextLabel",{
				Font = Enum.Font.Gotham,
				Text = default,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 13,
				AnchorPoint= Vector2.new(0.5,0.5),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.new(0.95, 0, 0.5, 0),
				Size = UDim2.new(0, 25, 0, 25),
				Name = "Value",
				Parent = SliderElement
			})
			--workspace.Library.Window.PagesContentHolder.PageContent.SliderElement.Slider.ImageButton.Position
			createUICorner(SliderElement)
			--
			do
				local down = false
				local previous
				userInputService.InputEnded:connect(function(key)
					if key.UserInputType == Enum.UserInputType.MouseButton1 then
						down = false
						if mouseOverFrame(SliderElement) then
							callback(Value.Text)
						end
					end
				end)
				ImageButton.MouseButton1Down:connect(function()
					down = true
					previous = Value.Text
					while runService.RenderStepped:wait() and down and mouseOverFrame(SliderElement) do
						local percentage = math.clamp((mouse.X - Slider.AbsolutePosition.X) / (Slider.AbsoluteSize.X), 0, 1)
						local value = ((max - min) * percentage) + min
						Value.Text = math.floor(value)
						tween(SliderFilled,0,{Size = UDim2.fromScale(percentage, 1)})
						tween(ImageButton,0,{Position = UDim2.fromScale(percentage,0.5)})
					end
				end)
			end
		end
		Elements.CreateTextBox = function(text,default,placeholder,callback)
			text = text or "Textbox"
			default = default or "Default"
			placeholder = placeholder or "Placeholder"
			callback = callback or function() end
			local TextboxElement = create("Frame",{
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromRGB(30, 30, 30),
				BackgroundTransparency = 0.6499999761581421,
				BorderSizePixel = 0,
				LayoutOrder = 3,
				Position = UDim2.new(0.0199999996, 0, 0, 0),
				Size = UDim2.new(0, 480, 0, 45),
				Name = "TextboxElement",
				Parent = PageContent
			})
			createUICorner(TextboxElement)
			local Name = create("TextLabel",{
				Font = Enum.Font.Gotham,
				Text = text,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 13,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(0, 180, 0, 45),
				Name = "Name",
				Parent = TextboxElement
			})
			local Interact = create("TextBox",{
				Font = Enum.Font.Gotham,
				PlaceholderColor3 = Color3.fromRGB(88, 104, 139),
				PlaceholderText = placeholder,
				Text = default,
				TextColor3 = Color3.fromRGB(184, 206, 255),
				TextScaled = false,
				TextSize = 13,
				TextWrapped = false,
				AnchorPoint = Vector2.new(1, 0.5),
				BackgroundColor3 = Color3.fromRGB(32, 33, 43),
				Position = UDim2.new(0.97, 0, 0.5, 0),
				Size = UDim2.new(0, 70, 0, 25),
				Name = "Interact",
				Parent = TextboxElement
			})
			createUICorner(Interact)
			Interact.FocusLost:Connect(function() 
				callback(Interact.Text)
			end)
			Interact:GetPropertyChangedSignal("Text"):Connect(function()
				if string.len(Interact.Text) <= 34 then
					tween(Interact, 0.1, {Size = UDim2.new(0, Interact.TextBounds.X + 24, 0, 30)})
				else
					return
				end
			end)
		end
		Elements.CreateKeybind = function(text,default,mode,callback)
			text = text or "Keybind"
			default = default or "Q"
			callback = callback or function() end
			local KeybindElement = create("Frame",{
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromRGB(30, 30, 30),
				BackgroundTransparency = 0.6499999761581421,
				BorderSizePixel = 0,
				LayoutOrder = 3,
				Position = UDim2.new(0.0199999996, 0, 0, 0),
				Size = UDim2.new(0, 480, 0, 45),
				Name = "KeybindElement",
				Parent = PageContent
			})
			createUICorner(KeybindElement)
			local Name = create("TextLabel",{
				Font = Enum.Font.Gotham,
				Text = text,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 13,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(0, 180, 0, 45),
				Name = "Name",
				Parent = KeybindElement
			})
			local Interact = create("TextBox",{
				Font = Enum.Font.Gotham,
				Text = default,
				TextColor3 = Color3.fromRGB(184, 206, 255),
				TextScaled = false,
				TextSize = 13,
				TextWrapped = false,
				AnchorPoint = Vector2.new(1, 0.5),
				BackgroundColor3 = Color3.fromRGB(32, 33, 43),
				Position = UDim2.new(0.97, 0, 0.5, 0),
				Size = UDim2.new(0, 25, 0, 25),
				Name = "Interact",
				Parent = KeybindElement
			})
			createUICorner(Interact)
			local CheckingForKey = false
			local mem = false
			Interact.Text = default
			Interact.Size = UDim2.new(0, Interact.TextBounds.X + 24, 0, 30)

			Interact.Focused:Connect(function()
				CheckingForKey = true
			end)
			Interact.FocusLost:Connect(function()
				CheckingForKey = false
			end)

			userInputService.InputBegan:Connect(function(input, processed)
				if CheckingForKey then
					if input.UserInputType == Enum.UserInputType.Keyboard then
						if input.KeyCode ~= Enum.KeyCode.Unknown and input.KeyCode ~= Enum.KeyCode.RightShift then
							local SplitMessage = string.split(tostring(input.KeyCode), ".")
							local NewKeyNoEnum = SplitMessage[3]
							Interact.Text = tostring(NewKeyNoEnum)
							Interact:ReleaseFocus()
						end
					end
				elseif Interact.Text ~= "" and (input.KeyCode == Enum.KeyCode[Interact.Text] and not processed) then -- Test
					local Held = true
					
					local Connection
					Connection = input.Changed:Connect(function(prop)
						if prop == "UserInputState" then
							Connection:Disconnect()
							Held = false
						end
					end)

					if mode == 'Toggle' then
						callback(mem)
						mem = not mem
					else
						wait(0.25)
						if Held then
							local Loop; Loop = runService.Stepped:Connect(function()
								if not Held then
									callback(false)
									Loop:Disconnect()
								else
									callback(true)
								end
							end)	
						end
					end
				end
			end)

			Interact:GetPropertyChangedSignal("Text"):Connect(function()
				tween(Interact, 0.1, {Size = UDim2.new(0, Interact.TextBounds.X + 24, 0, 30)})
			end)
		end
		Elements.CreateToggle = function(name,callback)
			name = name or "Toggle"
			callback = callback or function() end
			local ToggleElement = create("Frame",{
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromRGB(30, 30, 30),
				BackgroundTransparency = 0.6499999761581421,
				BorderSizePixel = 0,
				Position = UDim2.new(0.0199999996, 0, 0, 0),
				Size = UDim2.new(0, 480, 0, 45),
				Name = "ToggleElement",
				Parent = PageContent
			})
			local Interact = create("ImageButton",{
				Image = "rbxasset://textures/ui/GuiImagePlaceholder.png",
				ImageTransparency = 1,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromRGB(29, 31, 36),
				Position = UDim2.new(0.95, 0, 0.5, 0),
				Size = UDim2.new(0, 25, 0, 25),
				Name = "Interact",
				Parent = ToggleElement
			})
			createUICorner(Interact,UDim.new(0,5))
			local Name = create("TextLabel",{
				Font = Enum.Font.Gotham,
				Text = name,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 13,
				AutomaticSize = Enum.AutomaticSize.X,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(0, 180, 0, 45),
				Name = "Name",
				Parent = ToggleElement
			})
			createUICorner(ToggleElement)
			Interact.MouseButton1Click:Connect(function()
				if Interact.BackgroundColor3 == Color3.fromRGB(29, 31, 36) then
					Interact.BackgroundColor3 = Color3.fromRGB(64, 51, 129)
					callback(true)
				else
					Interact.BackgroundColor3 = Color3.fromRGB(29, 31, 36)
					callback(false)
				end
			end)
		end
		Elements.CreateDropdown = function(name,variants,callback)
			name = name or "Dropdown"
			variants = variants or {"1","2","3"}
			callback = callback or function() end
			local DropdownElement = create("Frame",{
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromRGB(30, 30, 30),
				BackgroundTransparency = 0.65,
				BorderSizePixel = 0,
				LayoutOrder = 2,
				Position = UDim2.new(0.0199999996, 0, 0, 0),
				Size = UDim2.new(0, 480, 0, 45),
				Name = "DropdownElement",
				Parent = PageContent
			})
			createUICorner(DropdownElement)
			local Name = create("TextLabel",{
				Font = Enum.Font.Gotham,
				Text = "Dropdown name",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 13,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(0, 180, 0, 45),
				Name = "Name",
				Parent = DropdownElement
			})
			local Interact = create("ImageButton",{
				Image = "rbxassetid://13462195426",
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromRGB(83, 83, 83),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.new(0.95, 0,0.5, 0),
				Rotation = 0,
				Size = UDim2.new(0, 25, 0, 25),
				Name = "Interact",
				Parent = DropdownElement
			})
			local DropdownContent = create("Frame",{
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.new(0.499166608, 0, 0.637142837, 0),
				Size = UDim2.new(0, 480, 0, 130),
				Visible = false,
				Name = "DropdownContent",
				Parent = DropdownElement
			})
			createUICorner(DropdownContent)
			local ScrollingFrame = create("ScrollingFrame",{
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				CanvasSize = UDim2.new(0, 0, 1, 0),
				ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
				ScrollBarThickness = 6,
				Active = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 1, 0),
				Parent = DropdownContent
			})
			createUICorner(ScrollingFrame)
			createList(ScrollingFrame,{
				Padding = UDim.new(0, 1),
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder
			})
			local gradient = create("UIGradient",{
				Color = ColorSequence.new(Color3.fromRGB(95,86,199),Color3.fromRGB(64,51,129)),
				Enabled = true,
				Rotation = 45,
				Parent = nil
			})
			Interact.MouseButton1Click:Connect(function()
				if DropdownContent.Visible then
					DropdownContent.Visible = false
					tween(DropdownElement,0.1,{Size = UDim2.new(0,480,0,45)})
					tween(Interact,0.1,{Rotation = 0})
					Interact.Position = UDim2.new(0.94, 0,0.5, 0)
				else
					DropdownContent.Visible = true
					tween(DropdownElement,0.1,{Size = UDim2.new(0,480,0,175)})
					tween(Interact,0.1,{Rotation = 180})
					Interact.Position = UDim2.new(0.94, 0,0.128, 0)
				end
			end)
			for i,v in next,variants do
				local TextButton = create("TextButton",{
					Font = Enum.Font.Gotham,
					Text = tostring(v),
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 13,
					BackgroundColor3 = Color3.fromRGB(30,30,30),
					BackgroundTransparency = 0,
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 0, 40),
					Parent = ScrollingFrame
				})
				createUICorner(TextButton)
				TextButton.MouseButton1Click:Connect(function()
					if TextButton.BackgroundColor3 == Color3.fromRGB(30,30,30) then
						TextButton.BackgroundColor3 = Color3.fromRGB(64, 51, 129)
						TextButton.BackgroundTransparency = 1
						for i2,v2 in next,ScrollingFrame:GetChildren() do
							if (v2 ~= TextButton  and v2.ClassName == 'TextButton') then
								v2.BackgroundColor3 = Color3.fromRGB(30,30,30)
								TextButton.BackgroundTransparency = 0
							end
						end
						callback(v)
					end
				end)
			end
		end
		return Elements
	end
	WindowFunctions.CreateNotification = function(name,content)
		name = name or "Notification"
		content = content or "Notification content"
		local Notification = create("ImageButton",{
			Active = false,
			AutoButtonColor = false,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(30, 30, 30),
			BackgroundTransparency = 0.1,
			BorderSizePixel = 0,
			Position = UDim2.new(0.148817807, 0, 0.412234038, 0),
			Selectable = false,
			Size = UDim2.new(0, 250, 0, 75),
			Name = "Notification",
			Parent = Notifications
		})
		createUICorner(Notification);
		local Label = create("TextLabel",{
			Font = Enum.Font.Gotham,
			Text = name,
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0.50999999, 0, 0.226666659, 0),
			Size = UDim2.new(0, 235, 0, 26),
			Name = "Label",
			Parent = Notification
		})
		local Content = create("TextLabel",{
			Font = Enum.Font.Gotham,
			Text = content,
			TextColor3 = Color3.fromRGB(172, 172, 172),
			TextSize = 13,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0.50999999, 0, 0.673333347, 0),
			Size = UDim2.new(0, 236, 0, 41),
			Name = "Content",
			Parent = Notification
		})		
		Notification.MouseButton1Click:Connect(function()
			tween(Notification,0.1,{BackgroundTransparency = 1})
			tween(Label,0.1,{TextTransparency = 1})
			tween(Content,0.1,{TextTransparency = 1})
			wait(0.15)
			Notification:Destroy()
		end)
	end
	return WindowFunctions
end
return library
