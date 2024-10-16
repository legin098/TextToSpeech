# Speech-to-Text in iOS with SwiftUI and Swift Concurrency

This project implements text-to-speech functionality using **SwiftUI** and iOS's **AVSpeechSynthesizer**.

## Features

- **Text-to-Speech Conversion**: Converts text to spoken words using `AVSpeechSynthesizer`.
- **Modular Design**: The logic is decoupled for easy maintenance and scalability.
- **Audio Session Management**: Handles audio priorities and interactions using `AVAudioSession` to ensure proper session control.
- **Custom Error Handling**: Utilizes a custom error enum to manage failures clearly and efficiently, making it easier to debug and maintain.

## Requirements

- iOS 16.0+
- Xcode 15.4+
- Swift 5.5+

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/legin098/TextToSpeech.git
   ```
2. Open the project in Xcode:
   ```bash
   cd TextToSpeech
   open TextToSpeech.xcodeproj
   ```
3. Run the project on a simulator or physical device.

## Usage

1. Type the text you want to convert to speech.
2. Press the "Speak" button to start the speech synthesis.
3. Press "Stop" to halt the speech.

## Project Structure

- **TextToSpeechService**: Manages text-to-speech conversion.
- **TextToSpeechViewModel**: Acts as a bridge between the UI and the service.
- **TextToSpeechView**: SwiftUI interface for interacting with the user.

## Key Highlights

- **Modularity**: The logic is neatly separated into specific functions (`speak`, `stopSpeaking`, `restoreAudioSession`).
- **Audio Session Management**: Uses `AVAudioSession` to ensure proper handling and prioritization of audio.
- **Delegate Usage**: Implements `AVSpeechSynthesizerDelegate` to manage the speech synthesizer's state.
- **Error Handling**: Uses a custom error enum to handle failures clearly and efficiently.

## Contributions

Contributions are welcome. Fork the repository, create a new branch, and open a pull request with your improvements.

## Contact

- [LinkedIn: Jesus Cruz Suárez](https://www.linkedin.com/in/jesusantoniocruzsuarez-desarrollador/)
- [GitHub: legin098](https://github.com/legin098)
