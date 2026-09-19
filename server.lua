```lua
-- PLANTA VC BRAIROT
-- Sistema de teste de compra automática
-- Coloque este código no seu Roblox Studio em ServerScriptService

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Remote
local Remotes = ReplicatedStorage:FindFirstChild("Remotes")

if not Remotes then
	Remotes = Instance.new("Folder")
	Remotes.Name = "Remotes"
	Remotes.Parent = ReplicatedStorage
end

local ComprarPlanta = Remotes:FindFirstChild("ComprarPlanta")

if not ComprarPlanta then
	ComprarPlanta = Instance.new("RemoteEvent")
	ComprarPlanta.Name = "ComprarPlanta"
	ComprarPlanta.Parent = Remotes
end

-- Plantas e preços
local Plantas = {
	SrCarrot = 50000000,
	Tomatrio = 125000000,
	Shroombino = 200000000,
	Manga = 367000000,
	ReiLimone = 670000000,
	FrutaEstelar = 750000000,
	AtiradorKiwi = 1000000000
}

-- Inventário
local function pegarInventario(player)

	local inventario = player:FindFirstChild("Inventario")

	if not inventario then
		inventario = Instance.new("Folder")
		inventario.Name = "Inventario"
		inventario.Parent = player
	end

	return inventario
end

-- Compra
ComprarPlanta.OnServerEvent:Connect(function(player, nomePlanta)

	if typeof(nomePlanta) ~= "string" then
		return
	end

	local preco = Plantas[nomePlanta]

	if not preco then
		return
	end

	local leaderstats = player:FindFirstChild("leaderstats")

	if not leaderstats then
		return
	end

	local dinheiro = leaderstats:FindFirstChild("Dinheiro")

	if not dinheiro then
		return
	end

	-- Não compra sem dinheiro suficiente
	if dinheiro.Value < preco then
		return
	end

	-- Retira o dinheiro
	dinheiro.Value -= preco

	-- Adiciona a planta
	local inventario = pegarInventario(player)

	local planta = inventario:FindFirstChild(nomePlanta)

	if not planta then
		planta = Instance.new("IntValue")
		planta.Name = nomePlanta
		planta.Value = 0
		planta.Parent = inventario
	end

	planta.Value += 1

end)
```
