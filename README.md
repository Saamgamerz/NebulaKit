NebulaKit 是一个基于 Metal 的 iOS 3D 场景与地形渲染库，用于快速搭建可交互的 3D 浏览器、地形可视化和简单的游戏原型。它提供从 GPU 封装、场景管理到地形与模型加载的一整套基础能力，帮助你专注于构建内容而不是打底层渲染框架。

## 特性

- **Metal 渲染封装**：统一的 `GPUContext` 与可复用渲染视图 `MetalView`，简化设备与命令队列管理。  
- **场景/节点体系**：`Scene` + `SceneNode` 管理层级变换和 Mesh，方便组织复杂场景结构。  
- **相机与交互**：内置 `Camera` 和 `OrbitCameraController`，支持轨道相机、缩放与旋转等交互逻辑。  
- **地形高度图支持**：通过 `HeightfieldTerrain` 将高度数据转换为可渲染网格，用于地图、地形或科学数据可视化。  
- **3D 模型加载**：使用 Model I/O 加载常见 3D 模型格式，输出统一的 `MeshResource` 供场景使用。  

NebulaKit 不依赖 SceneKit 或第三方渲染引擎，直接使用 Metal API 实现，可作为学习 Metal 或搭建自定义引擎的基础。

## 环境要求

- iOS 15 及以上  
- Xcode 15 及以上  
- 支持 Metal 的 iOS 设备  

## 快速开始

### 使用 Swift Package Manager 集成

在 Xcode 中：

1. 打开 **Project Settings → Package Dependencies**。  
2. 点击 `+` 新增依赖，填入本仓库地址。  
3. 选择 `NebulaKit` 作为依赖库添加到你的 App Target。

### 创建一个最小场景

import SwiftUI
import NebulaKit

struct ContentView: UIViewRepresentable {
func makeUIView(context: Context) -> MetalView {
guard let gpu = GPUContext() else { fatalError("Metal not supported") }
let metalView = MetalView(context: gpu)
let renderer = SimpleSceneRenderer(context: gpu, size: metalView.drawableSize)
metalView.renderDelegate = renderer
context.coordinator.renderer = renderer
return metalView
}

text
func updateUIView(_ uiView: MetalView, context: Context) {}

func makeCoordinator() -> Coordinator { Coordinator() }

final class Coordinator {
    var renderer: SimpleSceneRenderer?
}
}

text

你只需要实现一个自定义的 `SimpleSceneRenderer`，在其中创建 `Scene`、配置相机，并在每帧回调中完成渲染即可。

## 示例项目：TerrainExplorer

仓库内包含一个示例 App：`Examples/TerrainExplorer`，演示以下场景：

- 使用高度图生成地形网格并渲染  
- 通过轨道相机浏览场景（拖动旋转、双指缩放）  
- 点击地形高亮指定位置  

示例代码结构清晰，可作为你按需裁剪或扩展的参考。

## 设计理念

NebulaKit 重点关注以下几点：

- **清晰的分层**：Core（Metal 封装）、Scene（场景与相机）、Terrain（地形）、ModelIOBridge（模型加载）分层明确，便于替换和扩展。  
- **可读性优先**：API 命名倾向于自解释而非简写，方便团队协作和后续维护。  
- **可扩展性**：你可以在现有基础上添加光照、阴影、后处理等高级效果，而不需要重构整体框架。  

## 许可证

你可以为 NebulaKit 选择合适的开源许可证（例如 MIT 或 Apache-2.0），以满足你的项目需求。
