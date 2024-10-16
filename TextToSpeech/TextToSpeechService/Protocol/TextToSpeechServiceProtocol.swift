//
//  TextToSpeechServiceProtocol.swift
//  TextToSpeech
//
//  Created by Jesus Cruz Suárez on 14/10/24.
//

import Foundation

protocol TextToSpeechServiceProtocol {
    func speak(text: String, withVoice voiceIdentifier: String?, completion: @escaping () -> Void) throws
    func stopSpeaking() throws
}
