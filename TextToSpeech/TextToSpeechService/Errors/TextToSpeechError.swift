//
//  TextToSpeechError.swift
//  TextToSpeech
//
//  Created by Jesus Cruz Suárez on 14/10/24.
//

import Foundation

enum TextToSpeechError: Error {
    case audioSessionSetupFailed
    case audioSessionDeactivationFailed(String)
    case speechSynthesisFailed

    var message: String {
        switch self {
        case .audioSessionSetupFailed:
            return "Failed to set up the audio session. Please check the audio settings and try again."
        case .audioSessionDeactivationFailed(let details):
            return "Failed to deactivate the audio session: \(details)"
        case .speechSynthesisFailed:
            return "Speech synthesis failed. Please check if the text or voice parameters are correct."
        }
    }
}
