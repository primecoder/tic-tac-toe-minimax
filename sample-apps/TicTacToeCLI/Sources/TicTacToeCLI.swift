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
        TicTacToeCLIPlayer.main()
    }
}
