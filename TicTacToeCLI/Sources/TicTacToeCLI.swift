// The Swift Programming Language
// https://docs.swift.org/swift-book
// 
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser
import Tic_Tac_Toe_Minimax

@main
struct TicTacToeCLI: ParsableCommand {
    mutating func run() throws {
        print("Hello, world!")
    }
}
