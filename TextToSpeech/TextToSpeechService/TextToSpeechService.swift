//
//  TextToSpeechService.swift
//  TextToSpeech
//
//  Created by Jesus Cruz Suárez on 14/10/24.
//

import AVFAudio
import Foundation

class TextToSpeechService: NSObject, AVSpeechSynthesizerDelegate, TextToSpeechServiceProtocol {
    private var synthesizer: AVSpeechSynthesizer
    private var onFinishSpeaking: (() throws -> Void)?
    private var currentUtterance: AVSpeechUtterance?
    
    override init() {
        synthesizer = AVSpeechSynthesizer()
        super.init()
        synthesizer.delegate = self
    }
    
    /// Speaks the given text using a specified voice, if provided.
    /// - Parameters:
    ///   - text: The text to be converted into speech.
    ///   - voiceIdentifier: The identifier for the voice to use. If `nil`, the device’s default language will be used.
    ///   - completion: A closure that is executed when the speech finishes.
    /// - Throws: `TextToSpeechError.audioSessionSetupFailed` if audio session setup fails.
    @MainActor
    func speak(text: String, withVoice voiceIdentifier: String? = nil, completion: @escaping () -> Void) throws {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playback, mode: .voicePrompt, options: [.duckOthers])
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            throw TextToSpeechError.audioSessionSetupFailed
        }
        
        let utterance = AVSpeechUtterance(string: text)
        
        if let voiceId = voiceIdentifier, let selectedVoice = AVSpeechSynthesisVoice(identifier: voiceId) {
            utterance.voice = selectedVoice
        } else {
            let defaultLanguage = Locale.current.language.languageCode?.identifier ?? "en-US"
            utterance.voice = AVSpeechSynthesisVoice(language: defaultLanguage)
        }
        
        if currentUtterance != nil, synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
        
        self.currentUtterance = utterance
        onFinishSpeaking = {
            completion()
            try self.restoreAudioSession()
        }
        
        synthesizer.speak(utterance)
    }
    
    /// Stops the current speech if it is in progress.
    @MainActor
    func stopSpeaking() throws {
        if synthesizer.isSpeaking, currentUtterance != nil {
            synthesizer.stopSpeaking(at: .immediate)
            currentUtterance = nil
            try restoreAudioSession()
        }
    }
    
    /// Restores the audio session to its inactive state.
    ///
    /// This method attempts to deactivate the `AVAudioSession` and release control of the audio output.
    /// It ensures that other apps can regain audio priority if the session was blocking them.
    ///
    /// - Throws: `TextToSpeechError.audioSessionDeactivationFailed` if the deactivation process fails.
    private func restoreAudioSession() throws {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            throw TextToSpeechError.audioSessionDeactivationFailed(error.localizedDescription)
        }
    }
    
    /// Delegate method called when the synthesizer finishes speaking an utterance.
    /// - Parameters:
    ///   - synthesizer: The synthesizer responsible for the speech.
    ///   - utterance: The utterance that has finished.
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        if utterance == currentUtterance {
            try? onFinishSpeaking?()
            self.currentUtterance = nil
        }
    }
    
    /// Delegate method called when the synthesizer cancels an utterance.
    /// - Parameters:
    ///   - synthesizer: The synthesizer responsible for the speech.
    ///   - utterance: The utterance that was cancelled.
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        if utterance == currentUtterance {
            self.currentUtterance = nil
        }
    }
}
