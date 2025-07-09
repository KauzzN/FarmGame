-- Dados globais do jogo
_G.gameData = require(game.ReplicatedStorage.gameData)

-- Importações de módulos
local Tile = require(game.ReplicatedStorage.Tile)
local PlantGrowth = require(game.ReplicatedStorage.GrowthManager)

-- Serviço para loop de atualização
local RunService = game:GetService("RunService")

-- Criar os objetos Tile com base nas partes no Workspace
local farmTiles = workspace:WaitForChild("Tiles"):GetChildren()

for _, part in pairs(farmTiles) do
    local newTile = Tile:new(part)
    table.insert(_G.gameData.tiles, newTile)
    print("Nova plantação criada na posição:", newTile.position)
end

-- Loop contínuo de crescimento
RunService.Heartbeat:Connect(function(deltaTime)
    PlantGrowth:processGrowth(deltaTime)
end)
