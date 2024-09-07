import Foundation

/// A data structure corresponding to info.json in artifact bundle.
public struct ArtifactBundleInfo: Codable, Hashable, Sendable {
    public var schemaVersion: String
    public var artifacts: [String: Artifact]

    public init(schemaVersion: String, artifacts: [String : Artifact]) {
        self.schemaVersion = schemaVersion
        self.artifacts = artifacts
    }
}

public struct Artifact: Codable, Hashable, Sendable {
    public var version: String
    public var type: String
    public var variants: Set<ArtifactVariant>

    public init(version: String, type: String, variants: Set<ArtifactVariant>) {
        self.version = version
        self.type = type
        self.variants = variants
    }
}

public struct ArtifactVariant: Codable, Hashable, Sendable {
    public var path: String
    public var supportedTriples: [String]

    public init(path: String, supportedTriples: [String]) {
        self.path = path
        self.supportedTriples = supportedTriples
    }
}
