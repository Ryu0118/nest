import Foundation
import Logging

public struct SwiftCommand {
    private let executor: ProcessExecutor

    public init(currentDirectoryURL: URL? = nil, logger: Logger) {
        self.executor = ProcessExecutor(currentDirectory: currentDirectoryURL, logger: logger)
    }

    public func buildForRelease() async throws {
        _ = try await run("build", "-c", "release")
    }

    func run(_ argument: String...) async throws -> String {
        let swift = try await executor.which("swift")
        return try await executor.executeAndWait(command: swift, argument)
    }
}
