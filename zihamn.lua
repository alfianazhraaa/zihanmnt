--[[
  MOUNT ZIHAN v5 — CP NAVIGATOR + AUTO CLAIM
  BY ALFIAN
]]

local Players  = game:GetService("Players")
local UIS      = game:GetService("UserInputService")
local TweenSvc = game:GetService("TweenService")
local player   = Players.LocalPlayer

pcall(function()
    for _,g in ipairs(player.PlayerGui:GetChildren()) do
        if g.Name=="ZihanV5" then g:Destroy() end
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

local CP={
    Vector3.new(3.718,    9.096,    -814.067),
    Vector3.new(15.466,   0.587,    -1582.924),
    Vector3.new(53.692,   -2.904,   -2587.625),
    Vector3.new(698.164,  -2.904,   -3374.121),
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

local CLAIM=Vector3.new(10284.1,3013.4,-21465.0)

-- ══════════════════════════════
-- COLORS
-- ══════════════════════════════
local GR =Color3.fromRGB(150,255,170)
local RD =Color3.fromRGB(255,100,100)
local YL =Color3.fromRGB(230,200,100)
local CY =Color3.fromRGB(100,210,255)
local WHT=Color3.fromRGB(230,230,230)
local DIM=Color3.fromRGB(100,100,100)
local PNL=Color3.fromRGB(14,14,14)
local MID=Color3.fromRGB(22,22,22)
local BRD=Color3.fromRGB(34,34,34)
local BRD2=Color3.fromRGB(50,50,50)
local SIL=Color3.fromRGB(153,153,153)
local DEEP=Color3.fromRGB(8,8,8)

-- ══════════════════════════════
-- STATE
-- ══════════════════════════════
local running   = false
local stopped   = false
local currentCP = 0
local SVl,SDot,PFill,PPct
local cpBtnRefs = {} -- referensi tombol CP untuk highlight

local function setStatus(msg,col)
    if not SVl then return end
    SVl.Text=msg
    local c=col=="done" and GR or col=="err" and RD or col=="wait" and YL or col=="cyan" and CY or WHT
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

local function highlightCP(idx)
    for i,ref in ipairs(cpBtnRefs) do
        if i==idx then
            ref.BackgroundColor3=Color3.fromRGB(30,30,30)
            ref.TextColor3=WHT
            local sk=ref:FindFirstChildOfClass("UIStroke")
            if sk then sk.Color=SIL end
        else
            ref.BackgroundColor3=MID
            ref.TextColor3=DIM
            local sk=ref:FindFirstChildOfClass("UIStroke")
            if sk then sk.Color=BRD end
        end
    end
end

-- ══════════════════════════════
-- SCAN GOPAY DEKAT CP
-- ══════════════════════════════
local KEYWORDS={"claim","voucher","gopay","redemption","klaim","reward"}

local function containsKW(s)
    if not s or s=="" then return false end
    local sl=s:lower()
    for _,kw in ipairs(KEYWORDS) do
        if sl:match(kw) then return true end
    end
    return false
end

local function scanGopayNear(pos, radius)
    radius = radius or 120
    local results={}
    local seen={}
    -- scan ProximityPrompt
    for _,v in ipairs(workspace:GetDescendants()) do
        if v:IsA("ProximityPrompt") and not seen[v] then
            local at=(v.ActionText or "")
            local ot=(v.ObjectText or "")
            local pn=(v.Parent and v.Parent.Name or "")
            if containsKW(at) or containsKW(ot) or containsKW(pn) then
                local par=v.Parent
                if par then
                    local opos
                    if par:IsA("BasePart") then opos=par.Position
                    elseif par:IsA("Model") then
                        local pp=par.PrimaryPart or par:FindFirstChildWhichIsA("BasePart")
                        opos=pp and pp.Position
                    end
                    if opos and (opos-pos).Magnitude<=radius then
                        seen[v]=true
                        table.insert(results,{prompt=v,pos=opos,label=at~="" and at or pn})
                    end
                end
            end
        end
    end
    -- scan nama objek
    local knownNames={"RedemptionPointBasepart","Gopay","GopayPoint","Primary","VoucherPoint","ClaimPoint"}
    for _,v in ipairs(workspace:GetDescendants()) do
        if (v:IsA("BasePart") or v:IsA("Model")) then
            local isKnown=false
            for _,n in ipairs(knownNames) do
                if v.Name==n then isKnown=true;break end
            end
            if not isKnown then isKnown=containsKW(v.Name) end
            if isKnown then
                local opos
                if v:IsA("BasePart") then opos=v.Position
                elseif v:IsA("Model") then
                    local pp=v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart")
                    opos=pp and pp.Position
                end
                if opos and (opos-pos).Magnitude<=radius then
                    local pr=v:FindFirstChildOfClass("ProximityPrompt")
                    if pr and not seen[pr] then
                        seen[pr]=true
                        table.insert(results,{prompt=pr,pos=opos,label=v.Name})
                    end
                end
            end
        end
    end
    return results
end

local function firePrompts(results, hrp, hum)
    if not results or #results==0 then return 0 end
    local fired=0
    for _,r in ipairs(results) do
        -- TP dekat objek
        local dir=(hrp.Position-r.pos)
        local safe=r.pos+(dir.Magnitude>0.1 and dir.Unit*7 or Vector3.new(0,0,7))
        hrp.CFrame=CFrame.new(safe+Vector3.new(0,3,0))
        task.wait(0.2)
        for _=1,3 do
            local ok=pcall(function() fireproximityprompt(r.prompt) end)
            if ok then fired=fired+1;break end
            task.wait(0.08)
        end
        -- nudge retry
        if fired==0 then
            local d=(r.pos-hrp.Position)
            if d.Magnitude>0 then hrp.CFrame=CFrame.new(hrp.Position+d.Unit*3) end
            task.wait(0.12)
            pcall(function() fireproximityprompt(r.prompt) end)
        end
    end
    return fired
end

-- ══════════════════════════════
-- GOTO CP (teleport + scan)
-- ══════════════════════════════
local function gotoCP(idx, hrp, hum, autoScan)
    if not CP[idx] then return false end
    local pt=CP[idx]
    currentCP=idx
    highlightCP(idx)
    setStatus("CP "..idx.."/"..#CP,"wait")
    setProgress(idx,#CP)

    -- TP dengan retry
    for r=1,3 do
        hrp.CFrame=CFrame.new(pt+Vector3.new(0,5,0))
        task.wait(0.18)
        if (hrp.Position-pt).Magnitude<15 then break end
        hrp.CFrame=CFrame.new(pt+Vector3.new(0,3,0))
        task.wait(0.15)
    end

    if not autoScan then return true end

    -- scan gopay dekat CP ini
    local results=scanGopayNear(pt, 120)
    if #results>0 then
        setStatus("GOPAY FOUND CP"..idx.." — CLAIMING","cyan")
        if hum then hum.WalkSpeed=16 end
        task.wait(0.1)
        local fired=firePrompts(results,hrp,hum)
        if fired>0 then
            setStatus("CLAIMED AT CP"..idx,"done")
            pcall(function()
                game:GetService("StarterGui"):SetCore("SendNotification",
                    {Title="Zihan v5",Text="GoPay ditemukan di CP"..idx.."! Claim sekarang.",Duration=4})
            end)
            return true, true -- (success, found gopay)
        end
    end
    return true, false
end

-- ══════════════════════════════
-- FINAL CLAIM SEQUENCE
-- ══════════════════════════════
local function runFinalClaim(hrp, hum)
    setStatus("MENUJU CLAIM POINT","wait")
    if hum then hum.WalkSpeed=0 end

    hrp.CFrame=CFrame.new(9874.0,2960.8,-21571.6);task.wait(0.3)
    if stopped then return end
    hrp.CFrame=CFrame.new(9233.1,5064.2,-21332.8);task.wait(0.3)
    if stopped then return end
    hrp.CFrame=CFrame.new(9814.0,2956.7,-21591.3);task.wait(0.25)
    if stopped then return end
    hrp.CFrame=CFrame.new(CLAIM+Vector3.new(0,5,0));task.wait(0.3)

    if hum then hum.WalkSpeed=16 end
    task.wait(0.1)

    -- scan dari CLAIM point juga
    local results=scanGopayNear(CLAIM,150)
    if #results>0 then
        local fired=firePrompts(results,hrp,hum)
        if fired>0 then
            setStatus("CLAIMED","done");return
        end
    end

    -- jump + fire Primary fallback
    local function findPrimary()
        local best,bd=nil,math.huge
        for _,v in ipairs(workspace:GetDescendants()) do
            if v:IsA("ProximityPrompt") then
                local at=(v.ActionText or ""):lower()
                local pn=(v.Parent and v.Parent.Name or ""):lower()
                if at:match("claim") or at:match("voucher") or pn=="primary" then
                    local par=v.Parent;if par then
                        local pos
                        if par:IsA("BasePart") then pos=par.Position
                        elseif par:IsA("Model") then
                            local pp=par.PrimaryPart or par:FindFirstChildWhichIsA("BasePart")
                            pos=pp and pp.Position
                        end
                        if pos then
                            local d=(pos-CLAIM).Magnitude
                            if d<bd then bd=d;best={prompt=v,pos=pos} end
                        end
                    end
                end
            end
        end
        return best
    end
    local r=findPrimary()
    if r then
        local dir=(hrp.Position-r.pos)
        local safe=r.pos+(dir.Magnitude>0.1 and dir.Unit*6 or Vector3.new(0,0,6))
        hrp.CFrame=CFrame.new(safe+Vector3.new(0,3,0));task.wait(0.2)
        if hum then hum.Jump=true end;task.wait(0.1)
        pcall(function() fireproximityprompt(r.prompt) end)
    end

    setStatus("DONE — CLAIM MANUAL","done")
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification",
            {Title="Zihan v5",Text="Selesai! Claim voucher sekarang.",Duration=3})
    end)
end

-- ══════════════════════════════
-- AUTO CP SEQUENCE
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
            local ok,foundGopay=gotoCP(i,hrp,hum,true)
            if foundGopay then
                -- gopay ditemukan dan di-claim, stop auto CP
                running=false;return
            end
            task.wait(i>=50 and 0.3 or 0.16)
        end

        -- semua CP selesai, coba claim point akhir
        runFinalClaim(hrp,hum)
        running=false
    end)
end

-- CLAIM ONLY
local function runClaimOnly()
    if running then return end
    running=true;stopped=false
    task.spawn(function()
        local char=player.Character or player.CharacterAdded:Wait()
        local hrp=char:WaitForChild("HumanoidRootPart",5)
        if not hrp then setStatus("ERROR","err");running=false;return end
        local hum=char:FindFirstChildOfClass("Humanoid")
        runFinalClaim(hrp,hum)
        running=false
    end)
end

-- GOTO CP MANUAL (single cp)
local function runGotoCP(idx)
    if running then return end
    running=true;stopped=false
    task.spawn(function()
        local char=player.Character or player.CharacterAdded:Wait()
        local hrp=char:WaitForChild("HumanoidRootPart",5)
        if not hrp then setStatus("ERROR","err");running=false;return end
        local hum=char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed=0 end
        local ok,foundGopay=gotoCP(idx,hrp,hum,true)
        if foundGopay then
            -- sudah claim
        else
            setStatus("CP "..idx.." — READY","done")
        end
        if hum then hum.WalkSpeed=16 end
        running=false
    end)
end

-- ══════════════════════════════
-- GUI
-- ══════════════════════════════
local sg=Instance.new("ScreenGui")
sg.Name="ZihanV5";sg.ResetOnSpawn=false
sg.DisplayOrder=9999;sg.IgnoreGuiInset=false
sg.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
sg.Parent=player.PlayerGui

-- PANEL 300 × 380
local F=Instance.new("Frame",sg)
F.Size=UDim2.new(0,300,0,380)
F.Position=UDim2.new(0.5,-150,0.5,-190)
F.BackgroundColor3=PNL;F.BorderSizePixel=0
F.Active=true;F.Draggable=true;F.ZIndex=10
do Instance.new("UICorner",F).CornerRadius=UDim.new(0,8) end
do Instance.new("UIStroke",F).Color=BRD end

local ac=Instance.new("Frame",F)
ac.Size=UDim2.new(1,-4,0,1);ac.Position=UDim2.new(0,2,0,0)
ac.BackgroundColor3=SIL;ac.BorderSizePixel=0;ac.ZIndex=15
do Instance.new("UICorner",ac).CornerRadius=UDim.new(0,1) end

-- TOPBAR y=0 h=38
local TB=Instance.new("Frame",F)
TB.Size=UDim2.new(1,0,0,38);TB.Position=UDim2.new(0,0,0,0)
TB.BackgroundColor3=DEEP;TB.BorderSizePixel=0;TB.ZIndex=11
do Instance.new("UICorner",TB).CornerRadius=UDim.new(0,8) end
do local fx=Instance.new("Frame",TB);fx.Size=UDim2.new(1,0,0,8);fx.Position=UDim2.new(0,0,1,-8);fx.BackgroundColor3=DEEP;fx.BorderSizePixel=0;fx.ZIndex=11 end
do local bx=Instance.new("Frame",TB);bx.Size=UDim2.new(1,0,0,1);bx.Position=UDim2.new(0,0,1,-1);bx.BackgroundColor3=BRD;bx.BorderSizePixel=0;bx.ZIndex=12 end

do local l=Instance.new("TextLabel",TB);l.Size=UDim2.new(1,-44,0,16);l.Position=UDim2.new(0,10,0,5);l.BackgroundTransparency=1;l.Text="MOUNT ZIHAN v5";l.TextColor3=WHT;l.Font=Enum.Font.GothamBold;l.TextSize=11;l.TextXAlignment=Enum.TextXAlignment.Left;l.ZIndex=13 end
do local l=Instance.new("TextLabel",TB);l.Size=UDim2.new(1,-44,0,12);l.Position=UDim2.new(0,10,0,22);l.BackgroundTransparency=1;l.Text="BY ALFIAN  ·  CP NAVIGATOR + AUTO SCAN GOPAY";l.TextColor3=DIM;l.Font=Enum.Font.Gotham;l.TextSize=7;l.TextXAlignment=Enum.TextXAlignment.Left;l.ZIndex=13 end

local XB=Instance.new("TextButton",TB)
XB.Size=UDim2.new(0,22,0,22);XB.Position=UDim2.new(1,-26,0.5,-11)
XB.BackgroundColor3=MID;XB.Text="✕";XB.TextColor3=DIM
XB.Font=Enum.Font.GothamBold;XB.TextSize=9;XB.BorderSizePixel=0;XB.ZIndex=14
do Instance.new("UICorner",XB).CornerRadius=UDim.new(0,5) end
do Instance.new("UIStroke",XB).Color=BRD2 end
XB.MouseEnter:Connect(function() XB.TextColor3=WHT end)
XB.MouseLeave:Connect(function() XB.TextColor3=DIM end)
XB.MouseButton1Click:Connect(function()
    TweenSvc:Create(F,TweenInfo.new(0.15),{Size=UDim2.new(0,300,0,0)}):Play()
    task.delay(0.15,function() sg:Destroy() end)
end)

-- STATUS y=46 h=22
local sr=Instance.new("Frame",F)
sr.Size=UDim2.new(1,-24,0,22);sr.Position=UDim2.new(0,12,0,46)
sr.BackgroundColor3=MID;sr.BorderSizePixel=0;sr.ZIndex=12
do Instance.new("UICorner",sr).CornerRadius=UDim.new(0,5) end
do Instance.new("UIStroke",sr).Color=BRD end
SDot=Instance.new("Frame",sr);SDot.Size=UDim2.new(0,5,0,5);SDot.Position=UDim2.new(0,8,0.5,-2);SDot.BackgroundColor3=GR;SDot.BorderSizePixel=0;SDot.ZIndex=13
do Instance.new("UICorner",SDot).CornerRadius=UDim.new(1,0) end
SVl=Instance.new("TextLabel",sr);SVl.Size=UDim2.new(1,-22,1,0);SVl.Position=UDim2.new(0,18,0,0);SVl.BackgroundTransparency=1;SVl.Text="READY";SVl.TextColor3=GR;SVl.Font=Enum.Font.GothamBold;SVl.TextSize=10;SVl.TextXAlignment=Enum.TextXAlignment.Left;SVl.TextTruncate=Enum.TextTruncate.AtEnd;SVl.ZIndex=13

-- PROGRESS y=76 h=16
local pb=Instance.new("Frame",F)
pb.Size=UDim2.new(1,-24,0,16);pb.Position=UDim2.new(0,12,0,76)
pb.BackgroundColor3=MID;pb.BorderSizePixel=0;pb.ZIndex=12
do Instance.new("UICorner",pb).CornerRadius=UDim.new(0,5) end
do Instance.new("UIStroke",pb).Color=BRD end
PFill=Instance.new("Frame",pb);PFill.Size=UDim2.new(0,0,1,0);PFill.BackgroundColor3=GR;PFill.BorderSizePixel=0;PFill.ZIndex=13
do Instance.new("UICorner",PFill).CornerRadius=UDim.new(0,5) end
PPct=Instance.new("TextLabel",pb);PPct.Size=UDim2.new(1,0,1,0);PPct.BackgroundTransparency=1;PPct.Text="0 / 52";PPct.TextColor3=DIM;PPct.Font=Enum.Font.GothamBold;PPct.TextSize=8;PPct.TextXAlignment=Enum.TextXAlignment.Center;PPct.ZIndex=14

-- CP GRID LABEL y=100
do local l=Instance.new("TextLabel",F);l.Size=UDim2.new(1,-24,0,12);l.Position=UDim2.new(0,12,0,100);l.BackgroundTransparency=1;l.Text="PILIH CP MANUAL — klik untuk teleport + scan gopay";l.TextColor3=Color3.fromRGB(50,50,65);l.Font=Enum.Font.GothamBold;l.TextSize=7;l.TextXAlignment=Enum.TextXAlignment.Left;l.ZIndex=12 end

-- CP SCROLL y=114 h=166
local cpScroll=Instance.new("ScrollingFrame",F)
cpScroll.Size=UDim2.new(1,-24,0,166);cpScroll.Position=UDim2.new(0,12,0,114)
cpScroll.BackgroundColor3=DEEP;cpScroll.BorderSizePixel=0
cpScroll.ScrollBarThickness=2;cpScroll.ScrollBarImageColor3=BRD2
cpScroll.CanvasSize=UDim2.new(0,0,0,0);cpScroll.ZIndex=12
do Instance.new("UICorner",cpScroll).CornerRadius=UDim.new(0,6) end
do Instance.new("UIStroke",cpScroll).Color=BRD end

local cpGrid=Instance.new("UIGridLayout",cpScroll)
cpGrid.CellSize=UDim2.new(0,42,0,28)
cpGrid.CellPadding=UDim2.new(0,3,0,3)
cpGrid.SortOrder=Enum.SortOrder.LayoutOrder

local cpPad=Instance.new("UIPadding",cpScroll)
cpPad.PaddingLeft=UDim.new(0,4);cpPad.PaddingRight=UDim.new(0,4)
cpPad.PaddingTop=UDim.new(0,4);cpPad.PaddingBottom=UDim.new(0,4)

-- generate CP buttons
for i=1,#CP do
    local btn=Instance.new("TextButton",cpScroll)
    btn.LayoutOrder=i;btn.BackgroundColor3=MID;btn.BorderSizePixel=0
    btn.Text="CP"..i;btn.TextColor3=DIM
    btn.Font=Enum.Font.GothamBold;btn.TextSize=8;btn.ZIndex=13
    do Instance.new("UICorner",btn).CornerRadius=UDim.new(0,5) end
    do local s=Instance.new("UIStroke",btn);s.Color=BRD end
    table.insert(cpBtnRefs,btn)
    local ci=i
    btn.MouseButton1Click:Connect(function()
        if running then return end
        runGotoCP(ci)
    end)
end

-- update canvas size
cpGrid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    cpScroll.CanvasSize=UDim2.new(0,0,0,cpGrid.AbsoluteContentSize.Y+8)
end)

-- SEP y=288
local sep=Instance.new("Frame",F)
sep.Size=UDim2.new(1,-24,0,1);sep.Position=UDim2.new(0,12,0,288)
sep.BackgroundColor3=BRD;sep.BorderSizePixel=0;sep.ZIndex=12

-- ANTI-LAG y=296 h=24
local al=Instance.new("Frame",F)
al.Size=UDim2.new(1,-24,0,24);al.Position=UDim2.new(0,12,0,296)
al.BackgroundColor3=MID;al.BorderSizePixel=0;al.ZIndex=12
do Instance.new("UICorner",al).CornerRadius=UDim.new(0,5) end
do Instance.new("UIStroke",al).Color=BRD end
do local l=Instance.new("TextLabel",al);l.Size=UDim2.new(0.6,0,1,0);l.Position=UDim2.new(0,8,0,0);l.BackgroundTransparency=1;l.Text="ANTI-LAG";l.TextColor3=DIM;l.Font=Enum.Font.GothamBold;l.TextSize=8;l.TextXAlignment=Enum.TextXAlignment.Left;l.ZIndex=13 end
local ALB=Instance.new("TextButton",al);ALB.Size=UDim2.new(0,38,0,18);ALB.Position=UDim2.new(1,-42,0.5,-9);ALB.BackgroundColor3=MID;ALB.Text="ON";ALB.TextColor3=WHT;ALB.Font=Enum.Font.GothamBold;ALB.TextSize=9;ALB.BorderSizePixel=0;ALB.ZIndex=13
do Instance.new("UICorner",ALB).CornerRadius=UDim.new(0,4) end
local ALsk=Instance.new("UIStroke",ALB);ALsk.Color=SIL
ALB.MouseButton1Click:Connect(function()
    local on=ALB.Text=="ON";ALB.Text=on and "OFF" or "ON"
    ALB.TextColor3=on and DIM or WHT;ALsk.Color=on and BRD or SIL
    if not on then applyAntiLag() end
end)

-- 3 TOMBOL BAWAH y=328 h=40
-- STOP
local StopBtn=Instance.new("TextButton",F)
StopBtn.Size=UDim2.new(0,68,0,40);StopBtn.Position=UDim2.new(0,12,0,328)
StopBtn.BackgroundColor3=Color3.fromRGB(38,10,10);StopBtn.Text="■ STOP";StopBtn.TextColor3=RD
StopBtn.Font=Enum.Font.GothamBold;StopBtn.TextSize=10;StopBtn.BorderSizePixel=0;StopBtn.ZIndex=12
do Instance.new("UICorner",StopBtn).CornerRadius=UDim.new(0,7) end
do local s=Instance.new("UIStroke",StopBtn);s.Color=Color3.fromRGB(70,18,18) end
StopBtn.MouseButton1Click:Connect(function()
    stopped=true;StopBtn.Text="✓";StopBtn.TextColor3=YL
    task.delay(1.5,function() StopBtn.Text="■ STOP";StopBtn.TextColor3=RD end)
end)

-- CLAIM ONLY
local ClaimBtn=Instance.new("TextButton",F)
ClaimBtn.Size=UDim2.new(0,90,0,40);ClaimBtn.Position=UDim2.new(0,88,0,328)
ClaimBtn.BackgroundColor3=Color3.fromRGB(10,35,55);ClaimBtn.Text="⚡ CLAIM";ClaimBtn.TextColor3=CY
ClaimBtn.Font=Enum.Font.GothamBold;ClaimBtn.TextSize=10;ClaimBtn.BorderSizePixel=0;ClaimBtn.ZIndex=12
do Instance.new("UICorner",ClaimBtn).CornerRadius=UDim.new(0,7) end
do local s=Instance.new("UIStroke",ClaimBtn);s.Color=Color3.fromRGB(30,80,120) end
ClaimBtn.MouseButton1Click:Connect(function()
    if running then return end
    ClaimBtn.Text="⏳...";ClaimBtn.TextColor3=YL
    runClaimOnly()
    task.spawn(function()
        while running do task.wait(0.1) end
        task.wait(0.4)
        ClaimBtn.Text="⚡ CLAIM";ClaimBtn.TextColor3=CY
    end)
end)

-- AUTO CP
local StartBtn=Instance.new("TextButton",F)
StartBtn.Size=UDim2.new(1,-186,0,40);StartBtn.Position=UDim2.new(1,-114,0,328)
StartBtn.BackgroundColor3=WHT;StartBtn.Text="▶ AUTO CP"
StartBtn.TextColor3=DEEP;StartBtn.Font=Enum.Font.GothamBold
StartBtn.TextSize=10;StartBtn.BorderSizePixel=0;StartBtn.ZIndex=12
do Instance.new("UICorner",StartBtn).CornerRadius=UDim.new(0,7) end
do Instance.new("UIStroke",StartBtn).Color=BRD2 end

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

StartBtn.MouseButton1Click:Connect(function()
    if running then return end
    pulsing=false
    StartBtn.BackgroundColor3=MID;StartBtn.TextColor3=YL;StartBtn.Text="▶ RUNNING"
    runAutoCP(1)
    task.spawn(function()
        while running do task.wait(0.1) end
        task.wait(0.4)
        StartBtn.BackgroundColor3=WHT;StartBtn.TextColor3=DEEP
        StartBtn.Text="▶ AUTO CP";pulsing=true
    end)
end)

UIS.InputBegan:Connect(function(inp,gpe)
    if gpe then return end
    if inp.KeyCode==Enum.KeyCode.F9 then F.Visible=not F.Visible end
end)

task.spawn(function() task.wait(0.5);applyAntiLag() end)

print("Mount Zihan v5 | By Alfian | CP Navigator + Auto Scan GoPay | F9 toggle")
