local class = require(game.ReplicatedStorage.middleclass)

local Tile = class("Tile")

local FINAL_STAGE = 2

local growthStages = {
    game.ReplicatedStorage.Prefabs.Stage1,
    game.ReplicatedStorage.Prefabs.Stage2
}

function Tile:initialize(part)
    self.stage = 0
    self.position = part.Position
    self.model = nil
end

function Tile:isFullyGrown()
    return self.stage >= FINAL_STAGE
end

function Tile:updateStage(newStage)
    self.stage = newStage

    -- Remover o modelo antigo
    if self.model then
        self.model:Destroy()
        self.model = nil
    end

    -- Gerenciar novo modelo visual
    if self.stage > 0 then
        local prefab = growthStages[self.stage]
        local clone = prefab:Clone()
        clone.Parent = workspace
        clone:TranslateBy(self.position - clone:GetPrimaryPartCFrame().p)
        self.model = clone

        -- Sistema de colheita ao clicar
        if self.stage == FINAL_STAGE then
            local detector = clone:FindFirstChildWhichIsA("ClickDetector")
            if detector then
                detector.MouseClick:Connect(function()
                    self:updateStage(0)
                    _G.gameData.coins += 10
                    print("Você colheu uma planta! Moedas totais: " .. _G.gameData.coins)
                end)
            else
                warn("ClickDetector não encontrado no modelo.")
            end
        end
    end
end

return Tile
