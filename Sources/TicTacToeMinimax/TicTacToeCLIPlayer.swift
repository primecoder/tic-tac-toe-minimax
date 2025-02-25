//
//  TicTacToe-Minimax
//
//  Created by Ace on 9/7/2024.
//

import Foundation

public struct TicTacToeCLIPlayer {

    public static func main() {
        let game = TicTacToeGame()
        while game.status == .playing {
            print("Enter cell number 1..9: ")
            if let humanMove = readLine(),
               let cellNumber = Int(humanMove) {
                do {
                    try game.playMove(cell: cellNumber, player: .human)
                    // Find and play the best move for the AI
                    if let bestMove = game.findBestMove() {
                        try game.playMove(cell: bestMove, player: .ai)
                    }
                    // game.showBoard()
                    print(game.boardString())
                } catch {
                    print("Invalid move: \(error)")
                }
            } else {
                print("Invalid move!")
            }
        }
        print("Game over. Status: \(game.status)")
    }

}
