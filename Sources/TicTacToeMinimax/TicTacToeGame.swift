import Foundation

enum Player {
    case human, ai
}

enum Cell {
    case empty, x, o
}

public class TicTacToeGame {
    private(set) var board: [[Cell]]

    /// Map cell numbers to (row, col)
    private static let cellNumberToRowCol = [
        1: (0, 0), 2: (0, 1), 3: (0, 2),
        4: (1, 0), 5: (1, 1), 6: (1, 2),
        7: (2, 0), 8: (2, 1), 9: (2, 2)
    ]

    public enum GameStatus {
        case playing
        case aiWon
        case humanWon
        case draw
    }

    public var status: GameStatus {
        guard availableMoves().count > 0 else { return .draw }
        guard !checkWin(player: .ai) else { return .aiWon }
        guard !checkWin(player: .human) else { return .humanWon }
        return .playing
    }

    public init() {
        self.board = Array(repeating: Array(repeating: .empty, count: 3), count: 3)
    }

    func playMove(cell: Int, player: Player) {
        guard let (row, col) = Self.cellNumberToRowCol[cell] else {
            print("Invalid move! Cell: \(cell)")
            return
        }
        guard row >= 0 && row < 3 && col >= 0 && col < 3, board[row][col] == .empty else {
            return // Invalid move
        }
        board[row][col] = player == .human ? .x : .o
    }

    func checkWin(player: Player) -> Bool {
        let target: Cell = player == .human ? .x : .o

        // Check rows
        for i in 0..<3 {
            if (0..<3).allSatisfy({ board[i][$0] == target }) {
                return true
            }
        }

        // Check columns
        for j in 0..<3 {
            if (0..<3).allSatisfy({ board[$0][j] == target }) {
                return true
            }
        }

        // Check diagonals
        if (0..<3).allSatisfy({ board[$0][$0] == target }) {
            return true
        }

        if (0..<3).allSatisfy({ board[$0][2 - $0] == target }) {
            return true
        }

        return false
    }

    func isBoardFull() -> Bool {
        return !board.flatMap { $0 }.contains(.empty)
    }

    func availableMoves() -> [(Int, Int)] {
        var moves: [(Int, Int)] = []
        for i in 0..<3 {
            for j in 0..<3 {
                if board[i][j] == .empty {
                    moves.append((i, j))
                }
            }
        }
        return moves
    }

    func showBoard() {
        print("")
        for row in board {
            print(row.map { cell -> String in
                switch cell {
                case .empty: return "-"
                case .x: return "X"
                case .o: return "O"
                }
            }.joined(separator: " "))
        }
    }
    
    func minimax(depth: Int, isMaximising: Bool) -> Int {
        if checkWin(player: .ai) {
            return 10 - depth // AI wins
        } else if checkWin(player: .human) {
            return depth - 10 // Human wins
        } else if isBoardFull() {
            return 0 // Draw
        }

        if isMaximising {
            var bestScore = -Int.max
            for move in availableMoves() {
                board[move.0][move.1] = .o
                let score = minimax(depth: depth + 1, isMaximising: false)
                board[move.0][move.1] = .empty
                bestScore = max(bestScore, score)
            }
            return bestScore
        } else {
            var bestScore = Int.max
            for move in availableMoves() {
                board[move.0][move.1] = .x
                let score = minimax(depth: depth + 1, isMaximising: true)
                board[move.0][move.1] = .empty
                bestScore = min(bestScore, score)
            }
            return bestScore
        }
    }

    func findBestMove() -> Int? {
        guard let bestMove: (Int, Int) = findBestMove() else {
            return nil
        }

        return bestMove.0 * 3 + bestMove.1 + 1
    }

    private func findBestMove() -> (Int, Int)? {
        var bestScore = -Int.max
        var bestMove: (Int, Int)? = nil

        for move in availableMoves() {
            board[move.0][move.1] = .o
            let moveScore = minimax(depth: 0, isMaximising: false)
            board[move.0][move.1] = .empty
            if moveScore > bestScore {
                bestScore = moveScore
                bestMove = move
            }
        }

        return bestMove
    }

}

