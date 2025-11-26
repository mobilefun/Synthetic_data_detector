import SwiftUI

struct ResultView: View {
    let result: DetectionResult
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 8) {
                HStack {
                    Image(systemName: result.isAuthentic ? "checkmark.seal.fill" : "exclamationmark.triangle.fill")
                        .foregroundColor(result.isAuthentic ? .green : .orange)
                        .font(.title2)
                    
                    Text(result.authenticityLabel)
                        .font(.headline)
                        .foregroundColor(result.isAuthentic ? .green : .orange)
                    
                    Spacer()
                    
                    Text(result.confidencePercentage)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
                
                ProgressView(value: result.confidence)
                    .progressViewStyle(LinearProgressViewStyle(tint: result.isAuthentic ? .green : .orange))
                    .scaleEffect(x: 1, y: 2, anchor: .center)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Analysis:")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Spacer()
                }
                
                Text(result.reasoning)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(result.isAuthentic ? Color.green.opacity(0.3) : Color.orange.opacity(0.3), lineWidth: 2)
        )
    }
}

#Preview {
    ResultView(result: DetectionResult(
        isAuthentic: false,
        confidence: 0.85,
        reasoning: "This text shows several indicators of AI generation, including repetitive phrasing patterns and overly formal structure that is common in language model outputs.",
        contentType: .text
    ))
    .padding()
}