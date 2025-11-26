import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = DetectionViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            TextDetectionView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "text.quote")
                    Text("Text")
                }
                .tag(0)
            
            ImageDetectionView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "photo")
                    Text("Image")
                }
                .tag(1)
        }
        .onChange(of: selectedTab) { _ in
            viewModel.reset()
        }
    }
}

#Preview {
    ContentView()
}