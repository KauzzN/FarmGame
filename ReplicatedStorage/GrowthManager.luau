local plantManager = {}

local chancePerSecond = 0.03

function plantManager:processGrowth(deltaTime: number)
    local allTiles = _G.gameData.tiles

    for _, plot in allTiles do

        -- Ignorar plantações completas
        if plot:isFullyGrown() then
            continue
        end

        -- Calcular chance de crescimento com base no tempo
        local growthChance = chancePerSecond * deltaTime
        if math.random() > growthChance then
            continue
        end

        -- Aplicar crescimento
        plot:updateStage(plot.stage + 1)
    end
end

return plantManager
