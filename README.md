# AuthenticityDetector iOS App

An iOS app that detects whether text or images are real (human-created) or AI-generated using OpenAI's API.

## Features

- **Text Analysis**: Analyze text to determine if it's written by humans or AI
- **Image Analysis**: Analyze images to detect if they're real photos or AI-generated
- **Confidence Scores**: Get confidence percentages for each analysis
- **Detailed Reasoning**: Understand why the AI made its determination
- **Clean UI**: Intuitive SwiftUI interface with tab-based navigation

## Setup Instructions

### 1. Prerequisites
- Xcode 15.0 or later
- iOS 17.0 or later
- OpenAI API key

### 2. Configuration

**IMPORTANT:** Do not commit your API key to Git!

1. Open the project in Xcode
2. Navigate to `AuthenticityDetector/Config.plist`
3. Replace `YOUR_OPENAI_API_KEY_HERE` with your actual OpenAI API key:
   ```xml
   <key>OPENAI_API_KEY</key>
   <string>sk-your-actual-api-key-here</string>
   ```
4. The `Config.plist` file is in `.gitignore` to prevent accidental commits

### 3. Build and Run
1. Select your target device or simulator
2. Press Cmd+R to build and run the app

## App Architecture

### Models
- `DetectionResult.swift`: Data model for analysis results
- `OpenAIModels.swift`: API request/response models

### Services
- `OpenAIService.swift`: Handles API communication with OpenAI
- `APIConfiguration.swift`: API configuration and key management

### Views
- `ContentView.swift`: Main tab view container
- `TextDetectionView.swift`: Text analysis interface
- `ImageDetectionView.swift`: Image analysis interface
- `ResultView.swift`: Analysis results display

### ViewModels
- `DetectionViewModel.swift`: Manages app state and API calls

### Utils
- `ImageProcessor.swift`: Image processing utilities

## Usage

### Text Analysis
1. Switch to the "Text" tab
2. Enter or paste text in the text editor
3. Tap "Analyze Text"
4. View the results showing authenticity, confidence, and reasoning

### Image Analysis
1. Switch to the "Image" tab
2. Tap "Select Image" to choose from photo library
3. Tap "Analyze Image"
4. View the results showing authenticity, confidence, and reasoning

## API Usage

The app uses OpenAI's GPT-4o model for both text and image analysis:
- Text analysis uses text-only prompts
- Image analysis uses vision capabilities with base64-encoded images
- Responses are parsed as JSON with structured output

## Error Handling

The app includes comprehensive error handling for:
- Network connectivity issues
- API key validation
- Invalid responses
- Image processing errors
- JSON parsing errors

## Security Notes

**IMPORTANT: Never commit your API key to version control!**

- The `Config.plist` file contains a placeholder for your API key
- You must replace `YOUR_OPENAI_API_KEY_HERE` with your actual OpenAI API key locally
- The `.gitignore` file is configured to ignore `Config.plist` to prevent accidental commits
- For production apps, consider using iOS Keychain for more secure key storage
- Images are processed and sent securely to OpenAI's API over HTTPS
- No data is stored locally after analysis

## Requirements

- iOS 17.0+
- Valid OpenAI API key with GPT-4o access
- Internet connection for API calls

## Future Enhancements

- Batch processing for multiple items
- History of previous analyses
- Export results functionality
- Offline detection capabilities
- Custom model integration