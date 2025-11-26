import Foundation
import UIKit

/// Utility class for processing images before sending to the API
class ImageProcessor {
    /// Processes an image by resizing and compressing it
    /// - Parameter image: The UIImage to process
    /// - Returns: JPEG data of the processed image, or nil if processing fails
    static func processImage(_ image: UIImage) -> Data? {
        let targetSize = CGSize(width: 1024, height: 1024)
        let resizedImage = resizeImage(image, to: targetSize)
        return resizedImage.jpegData(compressionQuality: 0.8)
    }
    
    private static func resizeImage(_ image: UIImage, to size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}