// The Swift Programming Language
// https://docs.swift.org/swift-book
// 
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser
import TicTacToeMinimax

@main
struct TicTacToeCLI: ParsableCommand {
    func run() throws {
//        let game = TicTacToeGame()
//        while game.status == .playing {
//            print("Enter cell number 1..9: ")
//            if let humanMove = readLine(),
//               let cellNumber = Int(humanMove) {
//                game.playMove(cell: cellNumber, player: .human)
//                // Find and play the best move for the AI
//                if let bestMove = game.findBestMove() {
//                    game.playMove(cell: bestMove, player: .ai)
//                }
//                game.showBoard()
//            } else {
//                print("Invalid move!")
//            }
//        }
//        print("Game over. Status: \(game.status)")
        TicTacToePlayer.main()
    }
}
