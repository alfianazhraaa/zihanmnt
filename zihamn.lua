--[[
  MOUNT ZIHAN v4
  BY ALFIAN
]]

local Players  = game:GetService("Players")
local UIS      = game:GetService("UserInputService")
local TweenSvc = game:GetService("TweenService")
local player   = Players.LocalPlayer

pcall(function()
    for _,g in ipairs(player.PlayerGui:GetChildren()) do
        if g.Name=="ZihanV4" then g:Destroy() end
    end
end)

local function applyAntiLag()
    pcall(function() settings().Rendering.QualityLevel=Enum.QualityLevel.Level01 end)
    pcall(function() settings().Rendering.MeshPartDetailLevel=Enum.MeshPartDetailLevel.Level01 end)
    pcall(function() workspace.GlobalShadows=false end)
    pcall(function() settings().Rendering.MaxFrameRate=15 end)
    pcall(function()
        local L=game:GetService("Lighting")
        L.GlobalShadows=false;L.Brightness=1
        L.EnvironmentDiffuseScale=0;L.EnvironmentSpecularScale=0
        for _,v in ipairs(L:GetChildren()) do
            if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or
               v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or
               v:IsA("DepthOfFieldEffect") then v.Enabled=false end
        end
    end)
    pcall(function()
        for _,v in ipairs(workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Fire") or
               v:IsA("Smoke") or v:IsA("Sparkles") or v:IsA("Beam") then v.Enabled=false end
            if v:IsA("Decal") or v:IsA("Texture") then v.Transparency=1 end
        end
    end)
end

-- ══════════════════════════════
-- CP LIST — CP4 diupdate
-- ══════════════════════════════
local CP={
    Vector3.new(3.718,    9.096,    -814.067),      -- CP1
    Vector3.new(15.466,   0.587,    -1582.924),     -- CP2
    Vector3.new(52.873,   -2.904,   -2585.646),     -- CP3
    Vector3.new(697.765,  -2.904,   -3376.978),     -- CP4 FIXED
    Vector3.new(763.092,  -2.904,   -4153.929),     -- CP5
    Vector3.new(716.686,  -0.304,   -5268.813),     -- CP6
    Vector3.new(719.526,  9.096,    -6660.934),     -- CP7
    Vector3.new(733.307,  65.369,   -7357.708),     -- CP8
    Vector3.new(730.029,  45.096,   -8256.237),     -- CP9
    Vector3.new(693.703,  29.096,   -9473.930),     -- CP10
    Vector3.new(633.774,  17.096,   -10758.329),    -- CP11
    Vector3.new(-274.093, 13.096,   -10770.299),    -- CP12
    Vector3.new(-2132.081,65.096,   -10861.727),    -- CP13
    Vector3.new(-2079.158,49.096,   -12480.547),    -- CP14
    Vector3.new(-1986.048,177.096,  -13241.836),    -- CP15
    Vector3.new(-565.005, 173.096,  -13231.008),    -- CP16
    Vector3.new(364.100,  161.096,  -13303.718),    -- CP17
    Vector3.new(1964.868, 977.096,  -13425.020),    -- CP18
    Vector3.new(2916.492, 969.096,  -13417.518),    -- CP19
    Vector3.new(3791.164, 968.896,  -13518.130),    -- CP20
    Vector3.new(3807.351, 985.096,  -14792.040),    -- CP21
    Vector3.new(3923.011, 1061.096, -15996.030),    -- CP22
    Vector3.new(3786.341, 1053.096, -16987.496),    -- CP23
    Vector3.new(2837.195, 1109.096, -16993.457),    -- CP24
    Vector3.new(2091.328, 1193.096, -17300.779),    -- CP25
    Vector3.new(1784.328, 1185.096, -18237.713),    -- CP26
    Vector3.new(1762.944, 1333.096, -19254.902),    -- CP27
    Vector3.new(1746.264, 1297.096, -20030.475),    -- CP28
    Vector3.new(1782.646, 1269.096, -21033.840),    -- CP29
    Vector3.new(1769.587, 1477.096, -21856.654),    -- CP30
    Vector3.new(1796.448, 1485.096, -22655.854),    -- CP31
    Vector3.new(1795.741, 1509.096, -23597.246),    -- CP32
    Vector3.new(1799.751, 1505.096, -24445.350),    -- CP33
    Vector3.new(1886.778, 1493.096, -25389.064),    -- CP34
    Vector3.new(1920.820, 1493.096, -26689.889),    -- CP35
    Vector3.new(2124.946, 1557.096, -28848.211),    -- CP36
    Vector3.new(2127.019, 1557.096, -28848.459),    -- CP37
    Vector3.new(4575.867, 1545.096, -27846.295),    -- CP38
    Vector3.new(5585.702, 1865.096, -27786.719),    -- CP39
    Vector3.new(5574.089, 1869.096, -26634.725),    -- CP40
    Vector3.new(5656.031, 1989.096, -25738.797),    -- CP41
    Vector3.new(5655.685, 2161.096, -25738.877),    -- CP42
    Vector3.new(6649.654, 2161.096, -25626.457),    -- CP43
    Vector3.new(6632.943, 2153.096, -24752.887),    -- CP44
    Vector3.new(6660.656, 2181.096, -23023.488),    -- CP45
    Vector3.new(6545.862, 2133.096, -22057.986),    -- CP46
    Vector3.new(6544.157, 2133.096, -22056.053),    -- CP47
    Vector3.new(6632.839, 2167.344, -21428.551),    -- CP48
    Vector3.new(7466.051, 2165.096, -21427.057),    -- CP49
    Vector3.new(8303.392, 2540.896, -21564.656),    -- CP50
    Vector3.new(9209.609, 5054.228, -21342.803),    -- CP51
    Vector3.new(9814.756, 2951.411, -21591.408),    -- CP52
}

-- CP yang butuh retry karena trigger zone kecil
-- format: [index] = jumlah retry
local CP_RETRY = {
    [4]  = 3,
    [50] = 3,
    [51] = 3,
    [52] = 3,
}

local CLAIM=Vector3.new(10284.1,3013.4,-21465.0)
local running=false
local stopped=false

local GR=Color3.fromRGB(150,255,170)
local RD=Color3.fromRGB(255,100,100)
local YL=Color3.fromRGB(230,200,100)
local WHT=Color3.fromRGB(230,230,230)
local DIM=Color3.fromRGB(100,100,100)

local SVl,SDot,PFill,PPct

local function setStatus(msg,col)
    if not SVl then return end
    SVl.Text=msg
    local c=col=="done" and GR or col=="err" and RD or col=="wait" and YL or WHT
    SVl.TextColor3=c
    if SDot then SDot.BackgroundColor3=c end
end

local function setProgress(cur,total)
    if not PFill or not PPct then return end
    local pct=cur/total
    PFill.Size=UDim2.new(pct,0,1,0)
    PPct.Text=cur.." / "..total
    PPct.TextColor3=pct>=1 and GR or pct>0.7 and YL or DIM
end

local function findPrimary()
    local best,bestDist=nil,math.huge
    for _,v in ipairs(workspace:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            local at=(v.ActionText or ""):lower()
            local pn=(v.Parent and v.Parent.Name or ""):lower()
            if at:match("claim") or at:match("voucher") or pn=="primary" then
                local par=v.Parent
                if par then
                    local pos
                    if par:IsA("BasePart") then pos=par.Position
                    elseif par:IsA("Model") then
                        local pp=par.PrimaryPart or par:FindFirstChildWhichIsA("BasePart")
                        pos=pp and pp.Position
                    end
                    if pos then
                        local d=(pos-CLAIM).Magnitude
                        if d<bestDist then bestDist=d;best={prompt=v,pos=pos} end
                    end
                end
            end
        end
    end
    return best
end

local function tryFire(pr)
    if not pr then return end
    for _=1,3 do
        pcall(function() fireproximityprompt(pr) end)
        task.wait(0.08)
    end
end

-- ══════════════════════════════
-- CLAIM SEQUENCE (tanpa CP)
-- ══════════════════════════════
local function runClaimOnly()
    if running then return end
    running=true;stopped=false
    task.spawn(function()
        local char=player.Character or player.CharacterAdded:Wait()
        local hrp=char:WaitForChild("HumanoidRootPart",5)
        if not hrp then setStatus("ERROR","err");running=false;return end
        local hum=char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed=0 end

        setStatus("MENUJU CLAIM","wait")

        -- ZihanV3 sequence
        hrp.CFrame=CFrame.new(9874.0,2960.8,-21571.6);task.wait(0.3)
        if stopped then setStatus("STOPPED","err");running=false;return end
        hrp.CFrame=CFrame.new(9233.1,5064.2,-21332.8);task.wait(0.3)
        if stopped then setStatus("STOPPED","err");running=false;return end
        hrp.CFrame=CFrame.new(9814.0,2956.7,-21591.3);task.wait(0.25)
        if stopped then setStatus("STOPPED","err");running=false;return end
        hrp.CFrame=CFrame.new(CLAIM+Vector3.new(0,5,0));task.wait(0.3)

        if hum then hum.WalkSpeed=16 end
        task.wait(0.1)

        local result=findPrimary()
        if result then
            local dir=(hrp.Position-result.pos)
            local safe=result.pos+(dir.Magnitude>0.1 and dir.Unit*6 or Vector3.new(0,0,6))
            hrp.CFrame=CFrame.new(safe+Vector3.new(0,3,0));task.wait(0.2)
            if hum then hum.Jump=true end;task.wait(0.1)
            tryFire(result.prompt)
        else
            hrp.CFrame=CFrame.new(CLAIM+Vector3.new(0,3,0));task.wait(0.2)
            if hum then hum.Jump=true end;task.wait(0.1)
            result=findPrimary()
            if result then tryFire(result.prompt) end
        end

        setStatus("DONE — CLAIM MANUAL","done")
        setProgress(#CP,#CP)
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification",
                {Title="Zihan v4",Text="Selesai! Claim sekarang.",Duration=3})
        end)
        running=false
    end)
end

-- ══════════════════════════════
-- AUTO CP + CLAIM SEQUENCE
-- ══════════════════════════════
local function runAutoCP(fromCP)
    if running then return end
    running=true;stopped=false
    task.spawn(function()
        local char=player.Character or player.CharacterAdded:Wait()
        local hrp=char:WaitForChild("HumanoidRootPart",5)
        if not hrp then setStatus("ERROR","err");running=false;return end
        local hum=char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed=0 end

        local from=math.clamp(fromCP or 1,1,#CP)

        for i=from,#CP do
            if stopped then setStatus("STOPPED","err");running=false;return end
            setStatus("CP "..i.."/"..#CP,"wait")
            setProgress(i,#CP)

            local pt=CP[i]
            local retries=CP_RETRY[i] or 1

            -- teleport dengan retry untuk CP kritis
            for r=1,retries do
                hrp.CFrame=CFrame.new(pt+Vector3.new(0,5,0))
                task.wait(0.15)
                -- cek apakah sudah dekat (dalam 10 stud)
                local dist=(hrp.Position-pt).Magnitude
                if dist < 10 then break end
                -- belum dekat, coba offset sedikit dan retry
                hrp.CFrame=CFrame.new(pt+Vector3.new(0,3,0))
                task.wait(0.15)
            end

            -- delay lebih lama di CP kritis
            task.wait(i>=50 and 0.3 or (CP_RETRY[i] and 0.25 or 0.16))
        end

        -- lanjut claim
        setStatus("MENUJU CLAIM","wait")

        hrp.CFrame=CFrame.new(9874.0,2960.8,-21571.6);task.wait(0.3)
        if stopped then setStatus("STOPPED","err");running=false;return end
        hrp.CFrame=CFrame.new(9233.1,5064.2,-21332.8);task.wait(0.3)
        if stopped then setStatus("STOPPED","err");running=false;return end
        hrp.CFrame=CFrame.new(9814.0,2956.7,-21591.3);task.wait(0.25)
        if stopped then setStatus("STOPPED","err");running=false;return end
        hrp.CFrame=CFrame.new(CLAIM+Vector3.new(0,5,0));task.wait(0.3)

        if hum then hum.WalkSpeed=16 end
        task.wait(0.1)

        local result=findPrimary()
        if result then
            local dir=(hrp.Position-result.pos)
            local safe=result.pos+(dir.Magnitude>0.1 and dir.Unit*6 or Vector3.new(0,0,6))
            hrp.CFrame=CFrame.new(safe+Vector3.new(0,3,0));task.wait(0.2)
            if hum then hum.Jump=true end;task.wait(0.1)
            tryFire(result.prompt)
        else
            hrp.CFrame=CFrame.new(CLAIM+Vector3.new(0,3,0));task.wait(0.2)
            if hum then hum.Jump=true end;task.wait(0.1)
            result=findPrimary()
            if result then tryFire(result.prompt) end
        end

        setStatus("DONE — CLAIM MANUAL","done")
        setProgress(#CP,#CP)
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification",
                {Title="Zihan v4",Text="Selesai! Claim sekarang.",Duration=3})
        end)
        running=false
    end)
end

-- ══════════════════════════════
-- GUI
-- ══════════════════════════════
local PNL=Color3.fromRGB(14,14,14)
local MID=Color3.fromRGB(22,22,22)
local BRD=Color3.fromRGB(34,34,34)
local BRD2=Color3.fromRGB(50,50,50)
local SIL=Color3.fromRGB(153,153,153)
local DEEP=Color3.fromRGB(8,8,8)

local sg=Instance.new("ScreenGui")
sg.Name="ZihanV4";sg.ResetOnSpawn=false
sg.DisplayOrder=9999;sg.IgnoreGuiInset=false
sg.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
sg.Parent=player.PlayerGui

-- PANEL 280 × 260
local F=Instance.new("Frame",sg)
F.Size=UDim2.new(0,280,0,260)
F.Position=UDim2.new(0.5,-140,0.5,-130)
F.BackgroundColor3=PNL;F.BorderSizePixel=0
F.Active=true;F.Draggable=true;F.ZIndex=10
do Instance.new("UICorner",F).CornerRadius=UDim.new(0,8) end
do Instance.new("UIStroke",F).Color=BRD end

-- accent top
local ac=Instance.new("Frame",F)
ac.Size=UDim2.new(1,-4,0,1);ac.Position=UDim2.new(0,2,0,0)
ac.BackgroundColor3=SIL;ac.BorderSizePixel=0;ac.ZIndex=15
do Instance.new("UICorner",ac).CornerRadius=UDim.new(0,1) end

local function card(yPos,h)
    local fr=Instance.new("Frame",F)
    fr.Size=UDim2.new(1,-24,0,h);fr.Position=UDim2.new(0,12,0,yPos)
    fr.BackgroundColor3=MID;fr.BorderSizePixel=0;fr.ZIndex=12
    do Instance.new("UICorner",fr).CornerRadius=UDim.new(0,5) end
    do Instance.new("UIStroke",fr).Color=BRD end
    return fr
end
local function lbl(p,txt,col,sz,font,xa)
    local l=Instance.new("TextLabel",p)
    l.BackgroundTransparency=1;l.Text=txt
    l.TextColor3=col or WHT;l.Font=font or Enum.Font.Gotham
    l.TextSize=sz or 10;l.ZIndex=14
    l.TextXAlignment=xa or Enum.TextXAlignment.Left
    return l
end

-- TOPBAR y=0 h=36
local TB=Instance.new("Frame",F)
TB.Size=UDim2.new(1,0,0,36);TB.Position=UDim2.new(0,0,0,0)
TB.BackgroundColor3=DEEP;TB.BorderSizePixel=0;TB.ZIndex=11
do Instance.new("UICorner",TB).CornerRadius=UDim.new(0,8) end
do local fx=Instance.new("Frame",TB);fx.Size=UDim2.new(1,0,0,8);fx.Position=UDim2.new(0,0,1,-8);fx.BackgroundColor3=DEEP;fx.BorderSizePixel=0;fx.ZIndex=11 end
do local bx=Instance.new("Frame",TB);bx.Size=UDim2.new(1,0,0,1);bx.Position=UDim2.new(0,0,1,-1);bx.BackgroundColor3=BRD;bx.BorderSizePixel=0;bx.ZIndex=12 end

do local l=lbl(TB,"MOUNT ZIHAN v4",WHT,11,Enum.Font.GothamBold);l.Size=UDim2.new(1,-44,0,14);l.Position=UDim2.new(0,10,0,5) end
do local l=lbl(TB,"BY ALFIAN · AUTO CP 1/52",DIM,8,Enum.Font.Gotham);l.Size=UDim2.new(1,-44,0,11);l.Position=UDim2.new(0,10,0,20) end

local XB=Instance.new("TextButton",TB)
XB.Size=UDim2.new(0,22,0,22);XB.Position=UDim2.new(1,-26,0.5,-11)
XB.BackgroundColor3=MID;XB.Text="✕";XB.TextColor3=DIM
XB.Font=Enum.Font.GothamBold;XB.TextSize=9;XB.BorderSizePixel=0;XB.ZIndex=14
do Instance.new("UICorner",XB).CornerRadius=UDim.new(0,5) end
do Instance.new("UIStroke",XB).Color=BRD2 end
XB.MouseEnter:Connect(function() XB.TextColor3=WHT end)
XB.MouseLeave:Connect(function() XB.TextColor3=DIM end)
XB.MouseButton1Click:Connect(function()
    TweenSvc:Create(F,TweenInfo.new(0.15),{Size=UDim2.new(0,280,0,0)}):Play()
    task.delay(0.15,function() sg:Destroy() end)
end)

-- STATUS y=44 h=24
local sr=card(44,24)
SDot=Instance.new("Frame",sr);SDot.Size=UDim2.new(0,5,0,5);SDot.Position=UDim2.new(0,8,0.5,-2)
SDot.BackgroundColor3=GR;SDot.BorderSizePixel=0;SDot.ZIndex=13
do Instance.new("UICorner",SDot).CornerRadius=UDim.new(1,0) end
SVl=lbl(sr,"READY",GR,10,Enum.Font.GothamBold)
SVl.Size=UDim2.new(1,-22,1,0);SVl.Position=UDim2.new(0,18,0,0)
SVl.TextTruncate=Enum.TextTruncate.AtEnd

-- PROGRESS y=76 h=18
local pb=card(76,18)
PFill=Instance.new("Frame",pb);PFill.Size=UDim2.new(0,0,1,0)
PFill.BackgroundColor3=GR;PFill.BorderSizePixel=0;PFill.ZIndex=13
do Instance.new("UICorner",PFill).CornerRadius=UDim.new(0,5) end
PPct=lbl(pb,"0 / 52",DIM,8,Enum.Font.GothamBold,Enum.TextXAlignment.Center)
PPct.Size=UDim2.new(1,0,1,0)

-- MULAI DARI CP y=102 h=24
local ir=card(102,24)
do local l=lbl(ir,"Mulai dari CP :",DIM,9,Enum.Font.GothamBold);l.Size=UDim2.new(0.6,0,1,0);l.Position=UDim2.new(0,8,0,0) end
local IBox=Instance.new("TextBox",ir)
IBox.Size=UDim2.new(0,46,0,18);IBox.Position=UDim2.new(1,-50,0.5,-9)
IBox.BackgroundColor3=Color3.fromRGB(16,16,16);IBox.BorderSizePixel=0
IBox.Text="1";IBox.TextColor3=WHT;IBox.Font=Enum.Font.GothamBold
IBox.TextSize=10;IBox.TextXAlignment=Enum.TextXAlignment.Center;IBox.ZIndex=13
do Instance.new("UICorner",IBox).CornerRadius=UDim.new(0,4) end
do Instance.new("UIStroke",IBox).Color=BRD2 end

-- ANTI-LAG y=134 h=24
local al=card(134,24)
do local l=lbl(al,"ANTI-LAG",DIM,9,Enum.Font.GothamBold);l.Size=UDim2.new(0.5,0,1,0);l.Position=UDim2.new(0,8,0,0) end
local ALB=Instance.new("TextButton",al)
ALB.Size=UDim2.new(0,38,0,18);ALB.Position=UDim2.new(1,-42,0.5,-9)
ALB.BackgroundColor3=MID;ALB.Text="ON";ALB.TextColor3=WHT
ALB.Font=Enum.Font.GothamBold;ALB.TextSize=9;ALB.BorderSizePixel=0;ALB.ZIndex=13
do Instance.new("UICorner",ALB).CornerRadius=UDim.new(0,4) end
local ALsk=Instance.new("UIStroke",ALB);ALsk.Color=SIL
local alOn=true
ALB.MouseButton1Click:Connect(function()
    alOn=not alOn;ALB.Text=alOn and "ON" or "OFF"
    ALB.TextColor3=alOn and WHT or DIM;ALsk.Color=alOn and SIL or BRD
    if alOn then applyAntiLag() end
end)

-- SEPARATOR y=166
local sep=Instance.new("Frame",F)
sep.Size=UDim2.new(1,-24,0,1);sep.Position=UDim2.new(0,12,0,166)
sep.BackgroundColor3=BRD;sep.BorderSizePixel=0;sep.ZIndex=12

-- STOP y=174 h=42  (kiri)
local StopBtn=Instance.new("TextButton",F)
StopBtn.Size=UDim2.new(0,68,0,42);StopBtn.Position=UDim2.new(0,12,0,174)
StopBtn.BackgroundColor3=Color3.fromRGB(38,10,10)
StopBtn.Text="■ STOP";StopBtn.TextColor3=RD
StopBtn.Font=Enum.Font.GothamBold;StopBtn.TextSize=10;StopBtn.BorderSizePixel=0;StopBtn.ZIndex=12
do Instance.new("UICorner",StopBtn).CornerRadius=UDim.new(0,7) end
do local s=Instance.new("UIStroke",StopBtn);s.Color=Color3.fromRGB(70,18,18) end
StopBtn.MouseButton1Click:Connect(function()
    stopped=true;StopBtn.Text="✓ OK";StopBtn.TextColor3=YL
    task.delay(1.5,function() StopBtn.Text="■ STOP";StopBtn.TextColor3=RD end)
end)

-- AUTO CLAIM (skip CP) y=174 h=42  (tengah)
local ClaimBtn=Instance.new("TextButton",F)
ClaimBtn.Size=UDim2.new(0,88,0,42);ClaimBtn.Position=UDim2.new(0,88,0,174)
ClaimBtn.BackgroundColor3=Color3.fromRGB(10,35,55)
ClaimBtn.Text="⚡ CLAIM";ClaimBtn.TextColor3=Color3.fromRGB(100,200,255)
ClaimBtn.Font=Enum.Font.GothamBold;ClaimBtn.TextSize=10;ClaimBtn.BorderSizePixel=0;ClaimBtn.ZIndex=12
do Instance.new("UICorner",ClaimBtn).CornerRadius=UDim.new(0,7) end
do local s=Instance.new("UIStroke",ClaimBtn);s.Color=Color3.fromRGB(30,80,120) end

-- AUTO CP+CLAIM y=174 h=42  (kanan)
local StartBtn=Instance.new("TextButton",F)
StartBtn.Size=UDim2.new(0,88,0,42);StartBtn.Position=UDim2.new(1,-100,0,174)
StartBtn.BackgroundColor3=WHT;StartBtn.Text="▶ AUTO CP"
StartBtn.TextColor3=DEEP;StartBtn.Font=Enum.Font.GothamBold
StartBtn.TextSize=10;StartBtn.BorderSizePixel=0;StartBtn.ZIndex=12
do Instance.new("UICorner",StartBtn).CornerRadius=UDim.new(0,7) end
do Instance.new("UIStroke",StartBtn).Color=BRD2 end

-- label info di bawah tombol
do
    local info=Instance.new("TextLabel",F)
    info.Size=UDim2.new(1,-24,0,12);info.Position=UDim2.new(0,12,0,222)
    info.BackgroundTransparency=1;info.ZIndex=12
    info.Text="⚡ CLAIM = skip CP langsung claim  |  F9 toggle"
    info.TextColor3=Color3.fromRGB(45,45,55);info.Font=Enum.Font.Gotham
    info.TextSize=7;info.TextXAlignment=Enum.TextXAlignment.Center
end

-- pulse START
local pulsing=true
task.spawn(function()
    while sg and sg.Parent do
        if pulsing then
            TweenSvc:Create(StartBtn,TweenInfo.new(1.2,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),
                {BackgroundColor3=Color3.fromRGB(190,190,190)}):Play()
            task.wait(1.2)
            if pulsing then
                TweenSvc:Create(StartBtn,TweenInfo.new(1.2,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),
                    {BackgroundColor3=WHT}):Play()
                task.wait(1.2)
            end
        else task.wait(0.3) end
    end
end)

-- AUTO CP handler
StartBtn.MouseButton1Click:Connect(function()
    if running then return end
    pulsing=false
    StartBtn.BackgroundColor3=MID;StartBtn.TextColor3=YL;StartBtn.Text="▶ RUNNING"
    local from=math.clamp(tonumber(IBox.Text) or 1,1,#CP)
    runAutoCP(from)
    task.spawn(function()
        while running do task.wait(0.1) end
        task.wait(0.4)
        StartBtn.BackgroundColor3=WHT;StartBtn.TextColor3=DEEP
        StartBtn.Text="▶ AUTO CP";pulsing=true
    end)
end)

-- CLAIM ONLY handler
ClaimBtn.MouseButton1Click:Connect(function()
    if running then return end
    ClaimBtn.BackgroundColor3=Color3.fromRGB(8,25,40)
    ClaimBtn.Text="⏳ ...";ClaimBtn.TextColor3=YL
    runClaimOnly()
    task.spawn(function()
        while running do task.wait(0.1) end
        task.wait(0.4)
        ClaimBtn.BackgroundColor3=Color3.fromRGB(10,35,55)
        ClaimBtn.Text="⚡ CLAIM";ClaimBtn.TextColor3=Color3.fromRGB(100,200,255)
    end)
end)

UIS.InputBegan:Connect(function(inp,gpe)
    if gpe then return end
    if inp.KeyCode==Enum.KeyCode.F9 then F.Visible=not F.Visible end
end)

task.spawn(function() task.wait(0.5);applyAntiLag() end)

print("Mount Zihan v4 | By Alfian | F9 toggle")
