import Foundation

/// Configuration for OpenAI API endpoints and authentication
struct APIConfiguration {
    static let baseURL = "https://api.openai.com/v1"
    static let chatCompletionsEndpoint = "/chat/completions"

    /// Retrieves the OpenAI API key from Config.plist
    /// - Returns: The API key for authenticating with OpenAI
    /// - Note: Make sure to add your API key to Config.plist before running the app
    static var apiKey: String {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: path),
              let key = plist["OPENAI_API_KEY"] as? String,
              !key.isEmpty && key != "YOUR_OPENAI_API_KEY_HERE" else {
            fatalError("OpenAI API key not found. Please add your API key to Config.plist")
        }
        return key
    }
}