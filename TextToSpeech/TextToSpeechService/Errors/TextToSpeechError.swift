//
//  TextToSpeechError.swift
//  TextToSpeech
//
//  Created by Jesus Cruz Suárez on 14/10/24.
//

import Foundation

enum TextToSpeechError: Error {
    case audioSessionSetupFailed
    case speechSynthesisFailed
    
    var message: String {
        switch self {
        case .audioSessionSetupFailed:
            return "Failed to set up the audio session. Please check the audio settings and try again."
        case .speechSynthesisFailed:
            return "Speech synthesis failed. Please check if the text or voice parameters are correct."
        }
    }
}
