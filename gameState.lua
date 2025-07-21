local gameState = {
    players = {
        {
            name = "Player 1",
            tileIndex = 61,
            color = {1, 0, 0},
            health = 100
        },
    },
    gamePhase = "playing"  -- could be "waiting", "playing", "finished"
}

return gameState
