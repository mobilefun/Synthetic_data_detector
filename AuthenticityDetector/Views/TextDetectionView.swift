import SwiftUI

struct TextDetectionView: View {
    @ObservedObject var viewModel: DetectionViewModel
    @State private var inputText = ""
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            // Custom header
            VStack(spacing: 0) {
                Text("Text Analysis")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 8)
                    .padding(.bottom, 16)
            }
            .background(Color(.systemBackground))
            
            // Content
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Enter text to analyze:")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(.horizontal)
                    
                    TextEditor(text: $inputText)
                        .focused($isTextFieldFocused)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .frame(minHeight: 120)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        )
                        .padding(.horizontal)
                }
                
                Button(action: {
                    isTextFieldFocused = false
                    Task {
                        await viewModel.analyzeText(inputText)
                    }
                }) {
                    HStack {
                        if viewModel.isLoading {
                            ProgressView()
                                .scaleEffect(0.8)
                                .foregroundColor(.white)
                        } else {
                            Image(systemName: "magnifyingglass")
                        }
                        Text(viewModel.isLoading ? "Analyzing..." : "Analyze Text")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || viewModel.isLoading
                        ? Color.gray
                        : Color.blue
                    )
                    .cornerRadius(12)
                }
                .disabled(inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || viewModel.isLoading)
                .padding(.horizontal)
                
                if let result = viewModel.currentResult {
                    ResultView(result: result)
                        .padding(.horizontal)
                } else if let errorMessage = viewModel.errorMessage {
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(.red)
                            .font(.largeTitle)
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .padding(.top)
        }
    }
}

#Preview {
    TextDetectionView(viewModel: DetectionViewModel())
}