import ArgumentParser
import Foundation
import NestCLI
import NestKit
import Logging

struct ListCommand: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "list",
        abstract: "Show all installed binaries "
    )

    @Flag(name: .shortAndLong)
    var verbose: Bool = false

    mutating func run() async throws {
        LoggingSystem.bootstrap()
        Configuration.default.logger.logLevel = verbose ? .trace : .info

        let installedCommands = nestFileManager.list()
        for (name, commands) in installedCommands {
            logger.info("\(name)")
            for command in commands {
                logger.info("  \(command.version) \(command.isLinked ? "(Selected)".green : "")")
            }
        }
    }
}

extension ListCommand {
    var nestFileManager: NestFileManager { Configuration.default.nestFileManager }
    var logger: Logger { Configuration.default.logger }
}
