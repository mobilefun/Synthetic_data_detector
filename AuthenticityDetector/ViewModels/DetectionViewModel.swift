import Foundation
import SwiftUI

@MainActor
class DetectionViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var currentResult: DetectionResult?
    @Published var errorMessage: String?
    
    private let openAIService = OpenAIService()
    
    func analyzeText(_ text: String) async {
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Please enter some text to analyze"
            return
        }
        
        isLoading = true
        errorMessage = nil
        currentResult = nil
        
        do {
            let result = try await openAIService.analyzeText(text)
            currentResult = result
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func analyzeImage(_ imageData: Data) async {
        isLoading = true
        errorMessage = nil
        currentResult = nil
        
        do {
            let result = try await openAIService.analyzeImage(imageData)
            currentResult = result
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func reset() {
        currentResult = nil
        errorMessage = nil
        isLoading = false
    }
}