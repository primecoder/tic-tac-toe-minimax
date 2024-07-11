import Testing
@testable import TicTacToeMinimax

struct TicTacToeGameTests {
    static let MAX_ROW = 3
    static let MAX_COL = 3

    let game = TicTacToeGame()

    @Test("Create new game")
    func createNewGame() async throws {
        #expect(game.status == .playing)
        #expect(game.isBoardFull() == false)
        #expect(!game.availableMoves().isEmpty)

        #expect(game.availableMoves().count == Self.MAX_ROW * Self.MAX_COL)
    }

    @Test("Play first move")
    func playFirstMove() async throws {
        let preMoveAvailableMoves = game.availableMoves().count
        let randomMove = Int.random(in: 1...9)
        print("First move: \(randomMove)")
        try game.playMove(cell: randomMove, player: .human)
        #expect(preMoveAvailableMoves > game.availableMoves().count)
    }

    @Test("Cannot play into occupied cell")
    func playRepeatMove() async throws {
        let randomMove = Int.random(in: 1...9)
        print("First move: \(randomMove)")
        #expect(throws: TicTacToeGame.GameError.invalidMove) {
            try game.playMove(cell: randomMove, player: .human)
            try game.playMove(cell: randomMove, player: .human)
        }
    }

    @Test("Cannot play into invalid cells", arguments: [-1, 0, Self.MAX_ROW * Self.MAX_COL + 1])
    func playInvalidCells(cellNumber: Int) async throws {
        try game.playMove(cell: 1, player: .human)
        try game.playMove(cell: Self.MAX_ROW * Self.MAX_COL, player: .human)
        #expect(throws: TicTacToeGame.GameError.invalidCell) {
            print("Trying invalide cell number: \(cellNumber)")
            try game.playMove(cell: cellNumber, player: .human)
        }
    }

    @Test("AI won the game", arguments: [[
        (1, Player.human),
        (5, Player.ai),
        (2, Player.human),
        (3, Player.ai),
        (4, Player.human),
        (7, Player.ai),
    ]])
    func aiWin(turns: [(Int, Player)]) async throws {
        try turns.forEach { cell, player in
            print("Player: \(player), cell: \(cell)")
            try game.playMove(cell: cell, player: player)
        }
        #expect(game.status == .aiWon)
    }

    @Test("Human won the game", arguments: [[
        (1, Player.human),
        (9, Player.ai),
        (2, Player.human),
        (8, Player.ai),
        (3, Player.human),
    ]])
    func humanWin(turns: [(Int, Player)]) async throws {
        try turns.forEach { cell, player in
            print("Player: \(player), cell: \(cell)")
            try game.playMove(cell: cell, player: player)
        }
        #expect(game.status == .humanWon)
    }

    @Test("No move allowed after game finished", arguments: [[
        (1, Player.human),
        (9, Player.ai),
        (2, Player.human),
        (8, Player.ai),
        (3, Player.human),
        (7, Player.ai),     // Invalid move
    ]])
    func moveAfterGameFinished(turns: [(Int, Player)]) async throws {
        #expect(throws: TicTacToeGame.GameError.invalidMove) {
            try turns.forEach { cell, player in
                print("Player: \(player), cell: \(cell), status: \(game.status)")
                try game.playMove(cell: cell, player: player)
            }
        }
    }

    @Test("Always find best moves for AI", arguments: [[
        // These are dumb moves by human.
        (1, Player.human),
        (2, Player.human),
        (4, Player.human),
    ]])
    func findBestMovesForAi(turns: [(Int, Player)]) async throws {
        try turns.forEach { cell, player in
            print("Player: \(player), cell: \(cell)")
            try game.playMove(cell: cell, player: player)

            if let bestMoveForAi = game.findBestMove() {
                print("Player: ai, cell: \(bestMoveForAi)")
                try game.playMove(cell: bestMoveForAi, player: .ai)
            } else {
                #expect(Bool(false))
            }
        }
        #expect(game.status == .aiWon)
    }

    @Test("Reset the game", arguments: [[
        (1, Player.human),
        (5, Player.ai),
        (2, Player.human),
        (3, Player.ai),
        (4, Player.human),
        (7, Player.ai),
    ]])
    func resetBoardAfterWinning(turns: [(Int, Player)]) async throws {
        try turns.forEach { cell, player in
            print("Player: \(player), cell: \(cell)")
            try game.playMove(cell: cell, player: player)
        }
        #expect(game.status == .aiWon)
        game.resetBoard()
        #expect(game.status == .playing)
    }

    /// Just to improve test coverage here.
    @Test func otherTests() async throws {
        game.showBoard()
        #expect(!game.boardString().isEmpty)
    }
}
