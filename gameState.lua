local gameState = {
    players = {
        {
            name = "Player 1",
            tileIndex = 48,
            color = {0.7, 0.2, 0.2},
            health = 100,
            isAI = false
        },
        {
            name = "Player 2",
            tileIndex = 51,
            color = {0.3, 0.6, 0.3},
            health = 100,
            isAI = true
        },
        {
            name = "Player 3",
            tileIndex = 55,
            color = {0.3, 0.4, 0.6},
            health = 100,
            isAI = true
        },
        {
            name = "Player 4",
            tileIndex = 58,
            color = {0.4, 0.3, 0.5},
            health = 100,
            isAI = true
        },
    },
    gamePhase = "playing"
}

return gameState
