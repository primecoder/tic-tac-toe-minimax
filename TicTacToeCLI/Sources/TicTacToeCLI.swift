// The Swift Programming Language
// https://docs.swift.org/swift-book
// 
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser
import TicTacToeMinimax

@main
struct TicTacToeCLI: ParsableCommand {
    mutating func run() throws {
        let game = TicTacToeGame()
        print("Hello, world!")
    }
}
