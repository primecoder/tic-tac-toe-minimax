//
//  TicTacToe-Minimax
//
//  Created by Ace on 9/7/2024.
//

import Foundation

struct TicTacToePlayer {

    static func main() {
        let game = TicTacToeGame()
        while game.status == .playing {
            print("Enter cell number 1..9: ")
            if let humanMove = readLine(),
               let cellNumber = Int(humanMove) {
                game.playMove(cell: cellNumber, player: .human)
                // Find and play the best move for the AI
                if let bestMove = game.findBestMove() {
                    game.playMove(cell: bestMove, player: .ai)
                }
                game.showBoard()
            } else {
                print("Invalid move!")
            }
        }
        print("Game over. Status: \(game.status)")
    }

}
