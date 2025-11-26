import SwiftUI
import PhotosUI

struct ImageDetectionView: View {
    @ObservedObject var viewModel: DetectionViewModel
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    
    var body: some View {
        VStack(spacing: 0) {
            // Custom header
            VStack(spacing: 0) {
                Text("Image Analysis")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 8)
                    .padding(.bottom, 16)
            }
            .background(Color(.systemBackground))
            
            // Content
            VStack(spacing: 20) {
                VStack(spacing: 16) {
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 300)
                            .cornerRadius(12)
                            .shadow(radius: 4)
                    } else {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                            .frame(height: 200)
                            .overlay(
                                VStack {
                                    Image(systemName: "photo")
                                        .font(.largeTitle)
                                        .foregroundColor(.gray)
                                    Text("No image selected")
                                        .foregroundColor(.gray)
                                }
                            )
                    }
                    
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        HStack {
                            Image(systemName: "photo.on.rectangle.angled")
                            Text(selectedImage == nil ? "Select Image" : "Change Image")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                
                Button(action: {
                    Task {
                        if let image = selectedImage,
                           let imageData = ImageProcessor.processImage(image) {
                            await viewModel.analyzeImage(imageData)
                        }
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
                        Text(viewModel.isLoading ? "Analyzing..." : "Analyze Image")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        selectedImage == nil || viewModel.isLoading
                        ? Color.gray
                        : Color.blue
                    )
                    .cornerRadius(12)
                }
                .disabled(selectedImage == nil || viewModel.isLoading)
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
            .onChange(of: selectedItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        selectedImage = image
                        viewModel.reset()
                    }
                }
            }
        }
    }
}

#Preview {
    ImageDetectionView(viewModel: DetectionViewModel())
}