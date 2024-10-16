//
//  TextToSpeechView.swift
//  TextToSpeech
//
//  Created by Jesus Cruz Suárez on 14/10/24.
//

import SwiftUI

private enum Layout {
    enum Container {
        static let background: Color = .black
        static let spacing: CGFloat = 20.0
    }
    enum TextField {
        static let borderWidth: CGFloat = 1.0
        static let borderColor: Color = .blue
    }
    enum Button {
        static let padding: CGFloat = 12.0
        static let cornerRadius: CGFloat = 8.0
        static let backgroundSpeak: Color = .blue
        static let backgroundStop: Color = .red
        static let backgroundDisabled: Color = .gray
        static let foreground: Color = .white
    }
}

struct TextToSpeechView: View {
    @StateObject private var viewModel = TextToSpeechViewModel(textToSpeechService: TextToSpeechService())
    
    var body: some View {
        VStack(spacing: Layout.Container.spacing) {
            TextField("Enter text to speech", text: $viewModel.inputText, axis: .vertical)
                .lineLimit(4, reservesSpace: true)
                .padding()
                .border(Layout.TextField.borderColor, width: Layout.TextField.borderWidth)
                

            HStack {
                Button(action: viewModel.speak) {
                    Text("Speak")
                        .frame(maxWidth: .infinity)
                        .padding(Layout.Button.padding)
                        .background(viewModel.isSpeaking ? Layout.Button.backgroundDisabled : Layout.Button.backgroundSpeak)
                        .foregroundColor(Layout.Button.foreground)
                        .cornerRadius(Layout.Button.cornerRadius)
                }
                .disabled(viewModel.isSpeaking || viewModel.inputText.isEmpty)
                
                Button(action: viewModel.stopSpeaking) {
                    Text("Stop")
                        .frame(maxWidth: .infinity)
                        .padding(Layout.Button.padding)
                        .background(viewModel.isSpeaking ? Layout.Button.backgroundStop : Layout.Button.backgroundDisabled)
                        .foregroundColor(Layout.Button.foreground)
                        .cornerRadius(Layout.Button.cornerRadius)
                }
                .disabled(!viewModel.isSpeaking)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Layout.Container.background)
        .onTapGesture {
            hideKeyboard()
        }
    }
}

#Preview {
    TextToSpeechView()
}

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
