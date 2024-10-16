//
//  TextToSpeechViewModel.swift
//  TextToSpeech
//
//  Created by Jesus Cruz Suárez on 14/10/24.
//

import Foundation

final class TextToSpeechViewModel: ObservableObject {
    private let textToSpeechService: TextToSpeechService
    
    @Published var isSpeaking: Bool = false
    @Published var inputText: String = ""
    @Published var errorMessage: String?
    
    init(textToSpeechService: TextToSpeechService) {
        self.textToSpeechService = textToSpeechService
    }
    
    /// Triggers the TextToSpeech service to speak the input text.
    @MainActor
    func speak() {
        guard !inputText.isEmpty else {
            return
        }
        
        isSpeaking = true
        
        do {
            try textToSpeechService.speak(text: inputText, withVoice: "com.apple.ttsbundle.siri_male_en-US_compact") {
                self.isSpeaking = false
            }
        } catch {
            errorMessage = error.localizedDescription
            isSpeaking = false
        }
    }
    
    /// Stops the speech if it's in progress.
    @MainActor
    func stopSpeaking() {
        do {
            try textToSpeechService.stopSpeaking()
            isSpeaking = false
        } catch  {
            errorMessage = error.localizedDescription
            isSpeaking = false
        }
    }
}
