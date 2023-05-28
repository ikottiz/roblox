# hi there,this is opensource ui library that I made!!
## !!!w.i.p!!!
example script:
```lua
local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/ikottiz/roblox/main/library'))()
local Window = Library.CreateWindow('UI Library',nil) --text,toggle keybind

local Pages = { --own preference,you can use it any way you want
	  Main = Window.CreatePage('Main',true) --text,default
}
local Button1 = Pages.Main.CreateButton('Button',function() --text,callback
    print('hi') 
end) 
local Label = Pages.Main.CreateLabel('Label') --text
local Slider = Pages.Main.CreateSlider('Slider',0,100,50,function(v) --text,minimum,maximum,default,callback
    print(v) 
end) 
local Textbox = Pages.Main.CreateTextBox('Textbox','default','placeholder', function(v) --text,default,placeholder,callback
    print(v) 
end) 
local Toggle = Pages.Main.CreateToggle('Toggle',function(v) --text,callback
    print(v)
nd) 
local Dropdown = Pages.Main.CreateDropdown('Dropdown',{"FIRST","SECOND","THIRD"},function(v)  --text,callback
    print(v) 
end)
local Keybind = Pages.Main.CreateKeybind('Keybind','Q','Toggle',function(v) --text,keybind,mode:toggle,hold,callback
    print(v) 
end) 
local Page2 = Window.CreatePage('Second Page',false)
local Button2 = Pages.Main.CreateButton('Button',function()  --label,content 
    Window.CreateNotification('Hello guys!','Notification.com blah') 
end)
```
