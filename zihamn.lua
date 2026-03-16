--[[
  MOUNT ZIHAN v4 — FULL AUTO CP + CLAIM
  BY ALFIAN
]]

local Players  = game:GetService("Players")
local UIS      = game:GetService("UserInputService")
local TweenSvc = game:GetService("TweenService")
local player   = Players.LocalPlayer

pcall(function()
    for _, g in ipairs(player.PlayerGui:GetChildren()) do
        if g.Name == "ZihanV4" then g:Destroy() end
    end
end)

local function applyAntiLag()
    pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)
    pcall(function() settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01 end)
    pcall(function() workspace.GlobalShadows = false end)
    pcall(function() settings().Rendering.MaxFrameRate = 15 end)
    pcall(function()
        local L = game:GetService("Lighting")
        L.GlobalShadows = false; L.Brightness = 1
        L.EnvironmentDiffuseScale = 0; L.EnvironmentSpecularScale = 0
        for _, v in ipairs(L:GetChildren()) do
            if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or
               v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or
               v:IsA("DepthOfFieldEffect") then v.Enabled = false end
        end
    end)
    pcall(function()
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Fire") or
               v:IsA("Smoke") or v:IsA("Sparkles") or v:IsA("Beam") then v.Enabled = false end
            if v:IsA("Decal") or v:IsA("Texture") then v.Transparency = 1 end
        end
    end)
end

local CP = {
    Vector3.new(3.718,    9.096,    -814.067),
    Vector3.new(15.466,   0.587,    -1582.924),
    Vector3.new(53.692,   -2.904,   -2587.625),
    Vector3.new(697.452,  -2.904,   -3379.274),
    Vector3.new(763.092,  -2.904,   -4153.929),
    Vector3.new(716.686,  -0.304,   -5268.813),
    Vector3.new(718.528,  9.096,    -6662.083),
    Vector3.new(733.307,  65.369,   -7357.708),
    Vector3.new(729.570,  45.096,   -8257.154),
    Vector3.new(693.703,  29.096,   -9473.930),
    Vector3.new(632.958,  17.096,   -10757.811),
    Vector3.new(-274.093, 13.096,   -10770.299),
    Vector3.new(-2132.081,65.096,   -10861.727),
    Vector3.new(-2079.158,49.096,   -12480.547),
    Vector3.new(-1990.396,177.096,  -13240.868),
    Vector3.new(-568.436, 173.096,  -13232.987),
    Vector3.new(364.100,  161.096,  -13303.718),
    Vector3.new(1964.868, 977.096,  -13425.020),
    Vector3.new(2916.492, 969.096,  -13417.518),
    Vector3.new(3791.279, 968.896,  -13516.630),
    Vector3.new(3807.351, 985.096,  -14792.040),
    Vector3.new(3923.011, 1061.096, -15996.030),
    Vector3.new(3786.341, 1053.096, -16987.496),
    Vector3.new(2837.195, 1109.096, -16993.457),
    Vector3.new(2091.328, 1193.096, -17300.779),
    Vector3.new(1784.328, 1185.096, -18237.713),
    Vector3.new(1762.944, 1333.096, -19254.902),
    Vector3.new(1746.264, 1297.096, -20030.475),
    Vector3.new(1782.646, 1269.096, -21033.840),
    Vector3.new(1769.587, 1477.096, -21856.654),
    Vector3.new(1796.448, 1485.096, -22655.854),
    Vector3.new(1795.741, 1509.096, -23597.246),
    Vector3.new(1885.794, 1505.096, -25383.686),
    Vector3.new(1919.203, 1493.096, -26686.721),
    Vector3.new(1978.322, 1249.096, -27823.242),
    Vector3.new(2124.946, 1557.096, -28848.211),
    Vector3.new(4529.437, 1557.096, -28730.084),
    Vector3.new(4575.867, 1545.096, -27846.295),
    Vector3.new(5585.702, 1865.096, -27786.719),
    Vector3.new(5574.089, 1869.096, -26634.725),
    Vector3.new(5656.031, 1989.096, -25738.797),
    Vector3.new(6650.281, 2161.096, -25623.770),
    Vector3.new(6632.104, 2153.096, -24755.275),
    Vector3.new(6627.148, 2149.096, -23977.988),
    Vector3.new(6660.656, 2181.096, -23023.488),
    Vector3.new(6545.862, 2133.096, -22057.986),
    Vector3.new(6628.912, 2167.135, -21425.582),
    Vector3.new(7462.223, 2165.096, -21428.570),
    Vector3.new(8300.794, 2540.896, -21567.137),
    Vector3.new(9170.898, 5054.228, -21355.643),
    Vector3.new(9209.609, 5054.228, -21342.803),
    Vector3.new(9814.756, 2951.411, -21591.408),
}

local CLAIM = Vector3.new(10284.1, 3013.4, -21465.0)

local running   = false
local stopped   = false
local statusCB  = nil
local progressCB= nil

local function setStatus(msg, col)
    if statusCB then statusCB(msg, col) end
end
local function setProgress(cur, total)
    if progressCB then progressCB(cur, total) end
end
local function notif(t, m)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification",
            {Title=t, Text=m, Duration=3})
    end)
end

local function findPrimary()
    local best, bestDist = nil, math.huge
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            local at = (v.ActionText or ""):lower()
            local pn = (v.Parent and v.Parent.Name or ""):lower()
            if at:match("claim") or at:match("voucher") or pn == "primary" then
                local par = v.Parent
                if par then
                    local pos
                    if par:IsA("BasePart") then pos = par.Position
                    elseif par:IsA("Model") then
                        local pp = par.PrimaryPart or par:FindFirstChildWhichIsA("BasePart")
                        pos = pp and pp.Position
                    end
                    if pos then
                        local d = (pos - CLAIM).Magnitude
                        if d < bestDist then bestDist=d; best={prompt=v,pos=pos} end
                    end
                end
            end
        end
    end
    return best
end

local function tryFire(pr)
    if not pr then return false end
    for _ = 1, 3 do
        local ok = pcall(function() fireproximityprompt(pr) end)
        if ok then return true end
        task.wait(0.08)
    end
    return false
end

local function runSequence(startFrom)
    if running then return end
    running = true; stopped = false

    task.spawn(function()
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp  = char:WaitForChild("HumanoidRootPart", 5)
        if not hrp then
            setStatus("ERROR", "err"); running=false; return
        end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = 0 end

        local from = math.clamp(startFrom or 1, 1, #CP)

        for i = from, #CP do
            if stopped then
                setStatus("STOPPED", "err"); running=false; return
            end
            setStatus("CP "..i.."/"..#CP, "wait")
            setProgress(i, #CP)
            hrp.CFrame = CFrame.new(CP[i] + Vector3.new(0,5,0))
            task.wait(i >= 50 and 0.35 or 0.18)
        end

        -- ZihanV3 sequence
        setStatus("MENUJU CLAIM", "wait")

        hrp.CFrame = CFrame.new(9874.0, 2955.8, -21571.6)
        task.wait(0.3)
        if stopped then setStatus("STOPPED","err"); running=false; return end

        hrp.CFrame = CFrame.new(9233.1, 5059.2, -21332.8)
        task.wait(0.3)
        if stopped then setStatus("STOPPED","err"); running=false; return end

        hrp.CFrame = CFrame.new(9814.0, 2957.5, -21591.3)
        task.wait(0.25)
        if stopped then setStatus("STOPPED","err"); running=false; return end

        hrp.CFrame = CFrame.new(CLAIM + Vector3.new(0,5,0))
        task.wait(0.3)

        if hum then hum.WalkSpeed = 16 end
        task.wait(0.1)

        local result = findPrimary()
        if result then
            local dir = (hrp.Position - result.pos)
            local safe = result.pos + (dir.Magnitude > 0.1 and dir.Unit*6 or Vector3.new(0,0,6))
            hrp.CFrame = CFrame.new(safe + Vector3.new(0,3,0))
            task.wait(0.2)
            if hum then hum.Jump = true end
            task.wait(0.1)
            tryFire(result.prompt)
            if not tryFire(result.prompt) then
                hrp.CFrame = CFrame.new(CLAIM + Vector3.new(0,3,0))
                task.wait(0.15)
                if hum then hum.Jump = true end
                task.wait(0.08)
                tryFire(result.prompt)
            end
        else
            hrp.CFrame = CFrame.new(CLAIM + Vector3.new(0,3,0))
            task.wait(0.2)
            if hum then hum.Jump = true end
            task.wait(0.1)
            result = findPrimary()
            if result then tryFire(result.prompt) end
        end

        setStatus("DONE — CLAIM MANUAL", "done")
        setProgress(#CP, #CP)
        notif("Mount Zihan v4", "Selesai! Claim voucher sekarang.")
        running = false
    end)
end

-- ══════════════════════════════
-- GUI — FIXED LAYOUT
-- Panel 220 × 280, semua elemen
-- pakai posisi absolut bukan
-- UIListLayout agar tidak terpotong
-- ══════════════════════════════
local PNL = Color3.fromRGB(14,14,14)
local MID = Color3.fromRGB(22,22,22)
local BRD = Color3.fromRGB(34,34,34)
local BRD2= Color3.fromRGB(50,50,50)
local DIM = Color3.fromRGB(100,100,100)
local SIL = Color3.fromRGB(153,153,153)
local WHT = Color3.fromRGB(230,230,230)
local DEEP= Color3.fromRGB(8,8,8)
local GR  = Color3.fromRGB(150,255,170)
local RD  = Color3.fromRGB(255,100,100)
local YL  = Color3.fromRGB(230,200,100)

local function uic(p,r)
    local u=Instance.new("UICorner",p); u.CornerRadius=UDim.new(0,r or 6)
end
local function usk(p,c,t)
    local s=Instance.new("UIStroke",p); s.Color=c or BRD; s.Thickness=t or 1; return s
end
local function mkL(par,txt,col,sz,font,xa)
    local l=Instance.new("TextLabel",par)
    l.BackgroundTransparency=1; l.Text=txt or ""
    l.TextColor3=col or WHT; l.Font=font or Enum.Font.Gotham
    l.TextSize=sz or 10; l.ZIndex=14
    l.TextXAlignment=xa or Enum.TextXAlignment.Left
    return l
end

local sg=Instance.new("ScreenGui")
sg.Name="ZihanV4"; sg.ResetOnSpawn=false
sg.DisplayOrder=9999; sg.IgnoreGuiInset=true
sg.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
sg.Parent=player.PlayerGui

-- PANEL 220 × 280
local F=Instance.new("Frame",sg)
F.Size=UDim2.new(0,220,0,280)
F.Position=UDim2.new(0.5,-110,0.5,-140)
F.BackgroundColor3=PNL; F.BorderSizePixel=0
F.Active=true; F.Draggable=true; F.ZIndex=10
uic(F,8); usk(F,BRD,1)

-- top accent
local TL=Instance.new("Frame",F)
TL.Size=UDim2.new(1,-4,0,1); TL.Position=UDim2.new(0,2,0,0)
TL.BackgroundColor3=SIL; TL.BorderSizePixel=0; TL.ZIndex=15; uic(TL,1)

-- TOPBAR — y=0, h=40
local TB=Instance.new("Frame",F)
TB.Size=UDim2.new(1,0,0,40); TB.Position=UDim2.new(0,0,0,0)
TB.BackgroundColor3=DEEP; TB.BorderSizePixel=0; TB.ZIndex=11
uic(TB,8)
local tbF=Instance.new("Frame",TB)
tbF.Size=UDim2.new(1,0,0,8); tbF.Position=UDim2.new(0,0,1,-8)
tbF.BackgroundColor3=DEEP; tbF.BorderSizePixel=0; tbF.ZIndex=11
local tbB=Instance.new("Frame",TB)
tbB.Size=UDim2.new(1,0,0,1); tbB.Position=UDim2.new(0,0,1,-1)
tbB.BackgroundColor3=BRD; tbB.BorderSizePixel=0; tbB.ZIndex=12

local TTi=mkL(TB,"MOUNT ZIHAN v4",WHT,11,Enum.Font.GothamBold)
TTi.Size=UDim2.new(1,-46,0,16); TTi.Position=UDim2.new(0,12,0,6); TTi.ZIndex=13

local TBy=mkL(TB,"BY ALFIAN  ·  AUTO CP 1/52",DIM,8,Enum.Font.Gotham)
TBy.Size=UDim2.new(1,-46,0,12); TBy.Position=UDim2.new(0,12,0,23); TBy.ZIndex=13

local XB=Instance.new("TextButton",TB)
XB.Size=UDim2.new(0,22,0,22); XB.Position=UDim2.new(1,-28,0.5,-11)
XB.BackgroundColor3=MID; XB.Text="✕"; XB.TextColor3=DIM
XB.Font=Enum.Font.GothamBold; XB.TextSize=9; XB.BorderSizePixel=0; XB.ZIndex=14
uic(XB,5); usk(XB,BRD2,1)
XB.MouseEnter:Connect(function() XB.TextColor3=WHT end)
XB.MouseLeave:Connect(function() XB.TextColor3=DIM end)
XB.MouseButton1Click:Connect(function()
    TweenSvc:Create(F,TweenInfo.new(0.18,Enum.EasingStyle.Quart),
        {Size=UDim2.new(0,220,0,0),BackgroundTransparency=1}):Play()
    task.delay(0.2,function() sg:Destroy() end)
end)

-- ── STATUS — y=48, h=24
local SR=Instance.new("Frame",F)
SR.Size=UDim2.new(1,-24,0,24); SR.Position=UDim2.new(0,12,0,48)
SR.BackgroundColor3=MID; SR.BorderSizePixel=0; SR.ZIndex=12
uic(SR,5); usk(SR,BRD,1)

local SDot=Instance.new("Frame",SR)
SDot.Size=UDim2.new(0,5,0,5); SDot.Position=UDim2.new(0,9,0.5,-2)
SDot.BackgroundColor3=GR; SDot.BorderSizePixel=0; SDot.ZIndex=13; uic(SDot,5)

local SVl=mkL(SR,"READY",GR,9,Enum.Font.GothamBold)
SVl.Size=UDim2.new(1,-22,1,0); SVl.Position=UDim2.new(0,20,0,0); SVl.ZIndex=13
SVl.TextTruncate=Enum.TextTruncate.AtEnd

statusCB=function(msg,col)
    SVl.Text=msg
    if col=="done" then SVl.TextColor3=GR; SDot.BackgroundColor3=GR
    elseif col=="err" then SVl.TextColor3=RD; SDot.BackgroundColor3=RD
    elseif col=="wait" then SVl.TextColor3=YL; SDot.BackgroundColor3=YL
    else SVl.TextColor3=WHT; SDot.BackgroundColor3=WHT end
end

-- ── PROGRESS BAR — y=80, h=18
local PBG=Instance.new("Frame",F)
PBG.Size=UDim2.new(1,-24,0,18); PBG.Position=UDim2.new(0,12,0,80)
PBG.BackgroundColor3=MID; PBG.BorderSizePixel=0; PBG.ZIndex=12
uic(PBG,5); usk(PBG,BRD,1)

local PFill=Instance.new("Frame",PBG)
PFill.Size=UDim2.new(0,0,1,0); PFill.BackgroundColor3=GR
PFill.BorderSizePixel=0; PFill.ZIndex=13; uic(PFill,5)

local PPct=mkL(PBG,"0 / 52",8,DIM,Enum.Font.GothamBold,Enum.TextXAlignment.Center)
PPct.Size=UDim2.new(1,0,1,0); PPct.ZIndex=14

progressCB=function(cur,total)
    local pct=cur/total
    TweenSvc:Create(PFill,TweenInfo.new(0.15),
        {Size=UDim2.new(pct,0,1,0)}):Play()
    PPct.Text=cur.." / "..total
    PPct.TextColor3=pct>=1 and GR or (pct>0.7 and YL or DIM)
end

-- ── MULAI DARI CP — y=106, h=26
local IR=Instance.new("Frame",F)
IR.Size=UDim2.new(1,-24,0,26); IR.Position=UDim2.new(0,12,0,106)
IR.BackgroundColor3=MID; IR.BorderSizePixel=0; IR.ZIndex=12
uic(IR,5); usk(IR,BRD,1)

local IKey=mkL(IR,"Mulai dari CP :",DIM,9,Enum.Font.GothamBold)
IKey.Size=UDim2.new(0.6,0,1,0); IKey.Position=UDim2.new(0,8,0,0); IKey.ZIndex=13

local IBox=Instance.new("TextBox",IR)
IBox.Size=UDim2.new(0,50,0,18); IBox.Position=UDim2.new(1,-56,0.5,-9)
IBox.BackgroundColor3=Color3.fromRGB(16,16,16); IBox.BorderSizePixel=0
IBox.Text="1"; IBox.TextColor3=WHT; IBox.Font=Enum.Font.GothamBold
IBox.TextSize=10; IBox.PlaceholderText="1"; IBox.ZIndex=13
IBox.TextXAlignment=Enum.TextXAlignment.Center
uic(IBox,4); usk(IBox,BRD2,1)

-- ── ANTI-LAG — y=140, h=26
local AL=Instance.new("Frame",F)
AL.Size=UDim2.new(1,-24,0,26); AL.Position=UDim2.new(0,12,0,140)
AL.BackgroundColor3=MID; AL.BorderSizePixel=0; AL.ZIndex=12
uic(AL,5); usk(AL,BRD,1)

local ALK=mkL(AL,"ANTI-LAG / LOW GRAPHICS",DIM,9,Enum.Font.GothamBold)
ALK.Size=UDim2.new(0.65,0,1,0); ALK.Position=UDim2.new(0,8,0,0); ALK.ZIndex=13

local ALB=Instance.new("TextButton",AL)
ALB.Size=UDim2.new(0,36,0,18); ALB.Position=UDim2.new(1,-42,0.5,-9)
ALB.BackgroundColor3=MID; ALB.Text="ON"; ALB.TextColor3=WHT
ALB.Font=Enum.Font.GothamBold; ALB.TextSize=8; ALB.BorderSizePixel=0; ALB.ZIndex=13
uic(ALB,4); local ALsk=usk(ALB,SIL,1)

local alOn=true
ALB.MouseButton1Click:Connect(function()
    alOn=not alOn
    ALB.Text=alOn and "ON" or "OFF"
    ALB.TextColor3=alOn and WHT or DIM
    ALsk.Color=alOn and SIL or BRD2
    if alOn then applyAntiLag() end
end)

-- ── SEPARATOR — y=174
local Sep=Instance.new("Frame",F)
Sep.Size=UDim2.new(1,-24,0,1); Sep.Position=UDim2.new(0,12,0,174)
Sep.BackgroundColor3=BRD; Sep.BorderSizePixel=0; Sep.ZIndex=12

-- ── STOP BUTTON — y=183, h=36
local StopBtn=Instance.new("TextButton",F)
StopBtn.Size=UDim2.new(0,72,0,36); StopBtn.Position=UDim2.new(0,12,0,183)
StopBtn.BackgroundColor3=Color3.fromRGB(40,12,12)
StopBtn.Text="■ STOP"; StopBtn.TextColor3=RD
StopBtn.Font=Enum.Font.GothamBold; StopBtn.TextSize=11
StopBtn.BorderSizePixel=0; StopBtn.ZIndex=12
uic(StopBtn,7); usk(StopBtn,Color3.fromRGB(80,20,20),1)
StopBtn.MouseButton1Click:Connect(function()
    stopped=true
    StopBtn.Text="✓ OK"; StopBtn.TextColor3=YL
    task.delay(1.5,function()
        StopBtn.Text="■ STOP"; StopBtn.TextColor3=RD
    end)
end)

-- ── START BUTTON — y=183, h=36
local StartBtn=Instance.new("TextButton",F)
StartBtn.Size=UDim2.new(1,-96,0,36); StartBtn.Position=UDim2.new(0,90,0,183)
StartBtn.BackgroundColor3=WHT; StartBtn.Text="▶  START"
StartBtn.TextColor3=DEEP; StartBtn.Font=Enum.Font.GothamBold
StartBtn.TextSize=13; StartBtn.BorderSizePixel=0; StartBtn.ZIndex=12
uic(StartBtn,7); usk(StartBtn,BRD2,1)

local pulsing=true
task.spawn(function()
    while sg and sg.Parent do
        task.wait(0.05)
        if pulsing then
            TweenSvc:Create(StartBtn,TweenInfo.new(1.3,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),
                {BackgroundColor3=Color3.fromRGB(200,200,200)}):Play()
            task.wait(1.3)
            if pulsing then
                TweenSvc:Create(StartBtn,TweenInfo.new(1.3,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),
                    {BackgroundColor3=WHT}):Play()
                task.wait(1.3)
            end
        else task.wait(0.2) end
    end
end)

StartBtn.MouseButton1Click:Connect(function()
    if running then return end
    pulsing=false
    StartBtn.BackgroundColor3=MID; StartBtn.TextColor3=YL; StartBtn.Text="▶  RUNNING"
    local fromCP = tonumber(IBox.Text) or 1
    fromCP = math.clamp(fromCP, 1, #CP)
    runSequence(fromCP)
    task.spawn(function()
        while running do task.wait(0.1) end
        task.wait(0.4)
        StartBtn.BackgroundColor3=WHT; StartBtn.TextColor3=DEEP
        StartBtn.Text="▶  START"; pulsing=true
    end)
end)

-- ── F9 toggle
UIS.InputBegan:Connect(function(inp,gpe)
    if gpe then return end
    if inp.KeyCode==Enum.KeyCode.F9 then F.Visible=not F.Visible end
end)

task.spawn(function()
    task.wait(0.5); applyAntiLag()
end)

print("Mount Zihan v4 | By Alfian | F9 toggle")
