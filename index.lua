```lua
--// PAINEL DE PLANTAS
--// Coloque este LocalScript dentro de StarterGui > PainelPlantas

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local ComprarPlanta = Remotes:WaitForChild("ComprarPlanta")
local DuplicarPlanta = Remotes:WaitForChild("DuplicarPlanta")


--==================================================
-- CONFIGURAÇÃO
--==================================================

local Plantas = {

	{
		Nome = "SrCarrot",
		Preco = 50000000
	},

	{
		Nome = "Tomatrio",
		Preco = 125000000
	},

	{
		Nome = "Shroombino",
		Preco = 200000000
	},

	{
		Nome = "Manga",
		Preco = 367000000
	},

	{
		Nome = "ReiLimone",
		Preco = 670000000
	},

	{
		Nome = "FrutaEstelar",
		Preco = 750000000
	},

	{
		Nome = "AtiradorKiwi",
		Preco = 1000000000
	}

}


--==================================================
-- GUI
--==================================================

local gui = script.Parent

gui.ResetOnSpawn = false


--==================================================
-- FUNÇÃO PARA FORMATAR DINHEIRO
--==================================================

local function formatarNumero(numero)

	if numero >= 1000000000 then

		return string.format("%.1fB", numero / 1000000000)

	elseif numero >= 1000000 then

		return string.format("%.1fM", numero / 1000000)

	elseif numero >= 1000 then

		return string.format("%.1fK", numero / 1000)

	else

		return tostring(numero)

	end

end


--==================================================
-- JANELA PRINCIPAL
--==================================================

local Main = Instance.new("Frame")

Main.Name = "Main"

Main.Size = UDim2.new(0, 650, 0, 550)

Main.Position = UDim2.new(0.5, -325, 0.5, -275)

Main.BackgroundColor3 = Color3.fromRGB(18, 18, 22)

Main.BorderSizePixel = 0

Main.Parent = gui


local MainCorner = Instance.new("UICorner")

MainCorner.CornerRadius = UDim.new(0, 16)

MainCorner.Parent = Main


--==================================================
-- TÍTULO
--==================================================

local Titulo = Instance.new("TextLabel")

Titulo.Size = UDim2.new(1, -40, 0, 60)

Titulo.Position = UDim2.new(0, 20, 0, 10)

Titulo.BackgroundTransparency = 1

Titulo.Text = "🌱 LOJA DE PLANTAS"

Titulo.TextColor3 = Color3.fromRGB(255, 255, 255)

Titulo.TextSize = 28

Titulo.Font = Enum.Font.GothamBold

Titulo.TextXAlignment = Enum.TextXAlignment.Left

Titulo.Parent = Main


--==================================================
-- SUBTÍTULO
--==================================================

local Subtitulo = Instance.new("TextLabel")

Subtitulo.Size = UDim2.new(1, -40, 0, 30)

Subtitulo.Position = UDim2.new(0, 20, 0, 60)

Subtitulo.BackgroundTransparency = 1

Subtitulo.Text = "Compre usando o dinheiro do jogo"

Subtitulo.TextColor3 = Color3.fromRGB(170, 170, 180)

Subtitulo.TextSize = 15

Subtitulo.Font = Enum.Font.Gotham

Subtitulo.TextXAlignment = Enum.TextXAlignment.Left

Subtitulo.Parent = Main


--==================================================
-- DINHEIRO
--==================================================

local DinheiroLabel = Instance.new("TextLabel")

DinheiroLabel.Size = UDim2.new(1, -40, 0, 35)

DinheiroLabel.Position = UDim2.new(0, 20, 0, 95)

DinheiroLabel.BackgroundTransparency = 1

DinheiroLabel.TextColor3 = Color3.fromRGB(100, 255, 130)

DinheiroLabel.TextSize = 18

DinheiroLabel.Font = Enum.Font.GothamBold

DinheiroLabel.TextXAlignment = Enum.TextXAlignment.Left

DinheiroLabel.Parent = Main


--==================================================
-- LISTA
--==================================================

local Lista = Instance.new("ScrollingFrame")

Lista.Name = "Lista"

Lista.Size = UDim2.new(1, -30, 1, -150)

Lista.Position = UDim2.new(0, 15, 0, 140)

Lista.BackgroundTransparency = 1

Lista.BorderSizePixel = 0

Lista.ScrollBarThickness = 7

Lista.CanvasSize = UDim2.new(0, 0, 0, 0)

Lista.Parent = Main


local Layout = Instance.new("UIListLayout")

Layout.Padding = UDim.new(0, 8)

Layout.Parent = Lista


Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()

	Lista.CanvasSize = UDim2.new(
		0,
		0,
		0,
		Layout.AbsoluteContentSize.Y + 10
	)

end)


--==================================================
-- ATUALIZAR DINHEIRO
--==================================================

local function atualizarDinheiro()

	local leaderstats = player:FindFirstChild("leaderstats")

	if not leaderstats then
		DinheiroLabel.Text = "💰 Dinheiro: carregando..."
		return
	end


	local dinheiro = leaderstats:FindFirstChild("Dinheiro")

	if not dinheiro then
		DinheiroLabel.Text = "💰 Dinheiro: 0"
		return
	end


	DinheiroLabel.Text =
		"💰 Dinheiro: " .. formatarNumero(dinheiro.Value)


	dinheiro:GetPropertyChangedSignal("Value"):Connect(function()

		DinheiroLabel.Text =
			"💰 Dinheiro: " .. formatarNumero(dinheiro.Value)

	end)

end


task.spawn(atualizarDinheiro)


--==================================================
-- CRIAR ITENS
--==================================================

for _, dados in ipairs(Plantas) do

	local Item = Instance.new("Frame")

	Item.Size = UDim2.new(1, -5, 0, 78)

	Item.BackgroundColor3 = Color3.fromRGB(29, 29, 36)

	Item.BorderSizePixel = 0

	Item.Parent = Lista


	local ItemCorner = Instance.new("UICorner")

	ItemCorner.CornerRadius = UDim.new(0, 10)

	ItemCorner.Parent = Item


	-- Nome
	local Nome = Instance.new("TextLabel")

	Nome.Size = UDim2.new(0, 200, 0, 30)

	Nome.Position = UDim2.new(0, 15, 0, 8)

	Nome.BackgroundTransparency = 1

	Nome.Text = "🌱 " .. dados.Nome

	Nome.TextColor3 = Color3.fromRGB(255, 255, 255)

	Nome.TextSize = 17

	Nome.Font = Enum.Font.GothamBold

	Nome.TextXAlignment = Enum.TextXAlignment.Left

	Nome.Parent = Item


	-- Preço
	local Preco = Instance.new("TextLabel")

	Preco.Size = UDim2.new(0, 200, 0, 25)

	Preco.Position = UDim2.new(0, 15, 0, 40)

	Preco.BackgroundTransparency = 1

	Preco.Text = "💰 $" .. formatarNumero(dados.Preco)

	Preco.TextColor3 = Color3.fromRGB(100, 255, 130)

	Preco.TextSize = 14

	Preco.Font = Enum.Font.Gotham

	Preco.TextXAlignment = Enum.TextXAlignment.Left

	Preco.Parent = Item


	--==================================================
	-- BOTÃO COMPRAR
	--==================================================

	local Comprar = Instance.new("TextButton")

	Comprar.Size = UDim2.new(0, 120, 0, 44)

	Comprar.Position = UDim2.new(1, -255, 0.5, -22)

	Comprar.BackgroundColor3 = Color3.fromRGB(40, 180, 90)

	Comprar.Text = "COMPRAR"

	Comprar.TextColor3 = Color3.fromRGB(255, 255, 255)

	Comprar.TextSize = 14

	Comprar.Font = Enum.Font.GothamBold

	Comprar.Parent = Item


	local ComprarCorner = Instance.new("UICorner")

	ComprarCorner.CornerRadius = UDim.new(0, 8)

	ComprarCorner.Parent = Comprar


	Comprar.MouseButton1Click:Connect(function()

		ComprarPlanta:FireServer(dados.Nome)

	end)


	--==================================================
	-- BOTÃO DUPLICAR
	--==================================================

	local Duplicar = Instance.new("TextButton")

	Duplicar.Size = UDim2.new(0, 120, 0, 44)

	Duplicar.Position = UDim2.new(1, -125, 0.5, -22)

	Duplicar.BackgroundColor3 = Color3.fromRGB(80, 100, 210)

	Duplicar.Text = "+100"

	Duplicar.TextColor3 = Color3.fromRGB(255, 255, 255)

	Duplicar.TextSize = 14

	Duplicar.Font = Enum.Font.GothamBold

	Duplicar.Parent = Item


	local DuplicarCorner = Instance.new("UICorner")

	DuplicarCorner.CornerRadius = UDim.new(0, 8)

	DuplicarCorner.Parent = Duplicar


	Duplicar.MouseButton1Click:Connect(function()

		-- Sempre adiciona exatamente 100
		DuplicarPlanta:FireServer(dados.Nome)

	end)

end
```
