import NestKit
import Logging

public struct ExecutableBinaryPreparer {
    private let artifactBundleFetcher: ArtifactBundleFetcher
    private let swiftPackageBuilder: SwiftPackageBuilder
    private let logger: Logger

    public init(
        artifactBundleFetcher: ArtifactBundleFetcher,
        swiftPackageBuilder: SwiftPackageBuilder,
        logger: Logger
    ) {
        self.artifactBundleFetcher = artifactBundleFetcher
        self.swiftPackageBuilder = swiftPackageBuilder
        self.logger = logger
    }

    public func fetchOrBuildBinaries(at gitURL: GitURL, version: GitVersion) async throws -> [ExecutableBinary] {
        switch gitURL {
        case .url(let url):
            do {
                return try await artifactBundleFetcher.fetchArtifactBundle(for: url, version: version)
            } catch ArtifactBundleFetcherError.noCandidates {
                logger.info("🪹 No artifact bundles in the repository.")
            } catch GitRepositoryClientError.notFound {
                logger.info("🪹 No releases in the repository.")
            } catch {
                logger.error(error)
            }
        case .ssh:
            logger.info("Specify a https url if you want to download an artifact bundle.")
        }
        return try await swiftPackageBuilder.build(gitURL: gitURL, version: version)
    }
}
