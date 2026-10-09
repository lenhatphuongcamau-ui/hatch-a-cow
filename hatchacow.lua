-- Tải và khởi tạo thư viện Rayfield UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Tạo Cửa Sổ Giao Diện (Window)
local Window = Rayfield:CreateWindow({
   Name = "Auto Clicker Hub | Ngân Nguyệt",
   LoadingTitle = "Đang tải Script...",
   LoadingSubtitle = "by Ngân Nguyệt",
   ConfigurationSaving = {
      Enabled = false,
   },
   Discord = {
      Enabled = false,
   },
   KeySystem = false -- Đặt true nếu muốn làm hệ thống Key
})

-- Tạo Tab Chính
local MainTab = Window:CreateTab("Auto Clicker", 4483362458) -- Icon ID

-- Biến lưu trạng thái Bật/Tắt và Tốc độ
local _G.AutoClickEnabled = false
local _G.ClickDelay = 0.1

-- Dịch vụ VirtualUser để giả lập click chuột trên màn hình
local VirtualUser = game:GetService("VirtualUser")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Tạo Nút Công Tắc (Toggle) Bật/Tắt Auto Click
local Toggle = MainTab:CreateToggle({
   Name = "Auto Click",
   CurrentValue = false,
   Flag = "AutoClickToggle",
   Callback = function(Value)
      _G.AutoClickEnabled = Value
      
      if Value then
         -- Sử dụng task.spawn để chạy vòng lặp ngầm không làm đơ/lag game
         task.spawn(function()
            while _G.AutoClickEnabled do
               -- Cách 1: Click chuột vật lý giả lập trên màn hình
               VirtualUser:CaptureController()
               VirtualUser:ClickButton1(Vector2.new(0, 0))
               
               -- Cách 2: Tự động kích hoạt Vũ khí/Công cụ (Tool) đang cầm trên tay (nếu có)
               local character = LocalPlayer.Character
               if character then
                  local tool = character:FindFirstChildOfClass("Tool")
                  if tool then
                     tool:Activate()
                  end
               end
               
               -- Khoảng thời gian nghỉ giữa các lần click (đối bằng Slider)
               task.wait(_G.ClickDelay)
            end
         end)
      end
   end,
})

-- Tạo Thanh Trượt (Slider) Điều Chỉnh Tốc Độ Click
local Slider = MainTab:CreateSlider({
   Name = "Tốc độ Click (Độ trễ - Giây)",
   Range = {0.01, 1},
   Increment = 0.01,
   Suffix = "s",
   CurrentValue = 0.1,
   Flag = "ClickDelaySlider",
   Callback = function(Value)
      _G.ClickDelay = Value
   end,
})

-- Thông báo khi Script được tải thành công
Rayfield:Notify({
   Title = "Script đã kích hoạt!",
   Content = "Auto Clicker đã sẵn sàng sử dụng.",
   Duration = 5,
   Image = 4483362458,
})
