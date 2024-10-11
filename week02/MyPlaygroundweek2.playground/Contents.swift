import UIKit
import PlaygroundSupport

let imageSize = CGSize(width: 1024, height: 1024)
let renderer = UIGraphicsImageRenderer(size: imageSize)

let image = renderer.image { context in
    UIColor.lightGray.setFill()
    context.fill(renderer.format.bounds)
    
    UIColor.blue.setFill()
    let circleRect = CGRect(x: 180, y: 100, width: 200, height: 200)
    context.cgContext.fillEllipse(in: circleRect)
    
    UIColor.blue.setFill()
    let circleRect2 = CGRect(x: 420, y: 100, width: 200, height: 200)
    context.cgContext.fillEllipse(in: circleRect2)
    
    UIColor.green.setFill()
    context.fill(CGRect(x: 200, y: 400, width: 400, height: 100))
    
    UIColor.black.setStroke()
    context.stroke(renderer.format.bounds)
}

PlaygroundPage.current.liveView = UIImageView(image: image)

if let imageData = image.pngData() {
    let documentsFolder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let filePath = documentsFolder.appendingPathComponent("gImag.png")
    
    do {
        try imageData.write(to: filePath)
        print("Image saved at \(filePath)")
    } catch {
        print("Error: \(error)")
    }
}

