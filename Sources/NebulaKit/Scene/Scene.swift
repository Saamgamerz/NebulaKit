import simd

public final class Scene {
    public var rootNode = SceneNode(name: "root")
    public var activeCamera: Camera?

    public init() {}
}

public final class SceneNode {
    public let name: String
    public var children: [SceneNode] = []
    public weak var parent: SceneNode?

    public var position: SIMD3<Float> = .zero
    public var rotation: SIMD3<Float> = .zero
    public var scale: SIMD3<Float> = SIMD3(repeating: 1)

    public var mesh: MeshResource?

    public init(name: String) {
        self.name = name
    }

    public func addChild(_ node: SceneNode) {
        children.append(node)
        node.parent = self
    }

    public func removeFromParent() {
        parent?.children.removeAll { $0 === self }
        parent = nil
    }

    public func worldTransform() -> float4x4 {
        var transform = float4x4.identity()
        transform = transform * .translation(position)
        transform = transform * .rotationXYZ(rotation)
        transform = transform * .scale(scale)
        if let p = parent {
            transform = p.worldTransform() * transform
        }
        return transform
    }
}
