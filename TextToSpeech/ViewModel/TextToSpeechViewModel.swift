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
            try textToSpeechService.speak(text: inputText) {
                self.isSpeaking = false
            }
        } catch {
            isSpeaking = false
        }
    }
    
    /// Stops the speech if it's in progress.
    @MainActor
    func stopSpeaking() {
        textToSpeechService.stopSpeaking()
        isSpeaking = false
    }
}
