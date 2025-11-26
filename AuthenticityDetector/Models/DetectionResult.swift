import Foundation

struct DetectionResult: Codable {
    let isAuthentic: Bool
    let confidence: Double
    let reasoning: String
    let contentType: ContentType
    
    enum ContentType: String, Codable, CaseIterable {
        case text = "text"
        case image = "image"
    }
}

extension DetectionResult {
    var authenticityLabel: String {
        isAuthentic ? "Real Content" : "AI-Generated"
    }
    
    var confidencePercentage: String {
        String(format: "%.1f%%", confidence * 100)
    }
}