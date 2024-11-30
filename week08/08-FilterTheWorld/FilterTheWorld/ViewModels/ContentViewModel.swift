import SwiftUI
import CoreImage
import CoreGraphics

class ContentViewModel: ObservableObject {
    @Published var error: Error?
    @Published var frame: CGImage?

    var comicFilter = false
    var monoFilter = false
    var crystalFilter = false
    var otherFilter = false
    var sepiaFilter = false  // New filter
    var pixellateFilter = false  // New filter
  var drawingFilter = false  // New Filter
  var vignetteFilter = false  // New Filter


    private let context = CIContext()
    private let cameraManager = CameraManager.shared
    private let frameManager = FrameManager.shared

    init() {
        setupSubscriptions()
    }

    func setupSubscriptions() {
        cameraManager.$error
            .receive(on: RunLoop.main)
            .map { $0 }
            .assign(to: &$error)

        frameManager.$current
            .receive(on: RunLoop.main)
            .compactMap { buffer in
                guard let image = CGImage.create(from: buffer) else {
                    return nil
                }

                var ciImage = CIImage(cgImage: image)

                // Apply filters in order
                if self.otherFilter {
                    ciImage = ciImage.applyingFilter("CIBloom", parameters: [
                        "inputRadius": 40.0,
                        "inputIntensity": 1.0
                    ])
                }
                if self.crystalFilter {
                    ciImage = ciImage.applyingFilter("CICrystallize")
                }
                if self.comicFilter {
                    ciImage = ciImage.applyingFilter("CIComicEffect")
                }
                if self.monoFilter {
                    ciImage = ciImage.applyingFilter("CIPhotoEffectNoir")
                }
                if self.sepiaFilter {
                    ciImage = ciImage.applyingFilter("CISepiaTone", parameters: [
                        "inputIntensity": 0.8
                    ])
                }
                if self.pixellateFilter {
                    ciImage = ciImage.applyingFilter("CIPixellate", parameters: [
                        "inputScale": 8.0
                    ])
                }
              if self.drawingFilter {
                  ciImage = ciImage.applyingFilter("CIEdgeWork", parameters: [
                      "inputRadius": 2.0
                  ])
                  ciImage = ciImage.applyingFilter("CIPhotoEffectMono")
              }

              if self.vignetteFilter {
                  ciImage = ciImage.applyingFilter("CIVignette", parameters: [
                      "inputIntensity": 1.0,
                      "inputRadius": 3.0
                  ])
              }


                return self.context.createCGImage(ciImage, from: ciImage.extent)
            }
            .assign(to: &$frame)
    }
}

