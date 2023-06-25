//
//  KeyboardView.swift
//  OonishiLayout
//
//  Created by 高橋直希 on 2023/06/26.
//

import SwiftUI

struct KeyboardView: View {
    let needsInputModeSwitchKey: Bool
    let nextKeyboardAction: Selector
    let inputTextAction: (String) -> Void
    let deleteTextAction: () -> Void
    
    let keyWidth: CGFloat = UIScreen.main.bounds.width / 12
    let keyHeight: CGFloat = 45
    let keySpacing: CGFloat = 4
    
    @State private var inputText: String = ""
    @State private var convertedText: String = ""
    
    let keys = [
        ["l", "u", ",", ".", "f", "w", "r", "y", "/"],
        ["e", "i", "a", "o", "-", "k", "t", "n", "s", "h"],
        [";", "g", "d", "m", "j", "b"]
    ]
    var body: some View {
        VStack {
            HStack(spacing: keySpacing) {
                Spacer()
                    .frame(width: keyWidth * 0.5 + keySpacing * 1)
                Group {
                    ForEach(keys[0], id: \.self) { key in
                        Button(key){
                            inputTextAction(key)
                        }.frame(width: keyWidth, height: keyHeight)
                    }
                }
                .background(Color(uiColor: .systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 8)
                Spacer()
            }
            HStack(spacing: keySpacing) {
                Spacer()
                    .frame(width: keyWidth * 0)
                Group {
                    ForEach(keys[1], id: \.self) { key in
                        Button(key){
                            inputTextAction(key)
                        }.frame(width: keyWidth, height: keyHeight)
                    }
                }
                .background(Color(uiColor: .systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 1)
                Spacer()
            }
            HStack(spacing: keySpacing) {
                ZStack{
                    Spacer()
                        .frame(width: keyWidth * 4.5 + keySpacing * 5)
                    Text("大西配列")
//                        .fontWeight(.semibold)
                        .font(.system(size: keyHeight / 2))
                        .padding(0)
                }
                Group {
                    ForEach(keys[2], id: \.self) { key in
                        Button(key){
                            inputTextAction(key)
                        }.frame(width: keyWidth, height: keyHeight)
                    }
                }
                .background(Color(uiColor: .systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 8)
                Spacer()
            }
            HStack(spacing: keySpacing) {
                Group {
                    // Next Keybaord
                    if needsInputModeSwitchKey {
                        NextKeyboardButton(systemName: "globe",
                                           action: nextKeyboardAction)
                        .frame(width: keyHeight, height: keyHeight)
                    }
                    // Shift
                    Button {
                        deleteTextAction()
                    } label: {
                        Image(systemName: "shift")
                            .frame(width: keyHeight, height: keyHeight)
                    }
                    Spacer()
                    Button("") {
                        inputTextAction(" ")
                    }
                    .frame(maxWidth: keyWidth * 5)
                    .frame(height: keyHeight)
                    .padding(.horizontal)
                    Spacer()
                    
                    // Delete Text
                    Button {
                        deleteTextAction()
                    } label: {
                        Image(systemName: "delete.left")
                            .frame(width: keyHeight, height: keyHeight)
                    }
                }
                .background(Color(uiColor: .systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 8)
            }
            
        }
        .padding(keySpacing)
            .foregroundColor(Color(uiColor: .label))
    }
}

struct NextKeyboardButton: View {
    let systemName: String
    let action: Selector
    
    var body: some View {
        Image(systemName: systemName)
            .overlay {
                NextKeyboardButtonOverlay(action: action)
            }
    }
}

struct NextKeyboardButtonOverlay: UIViewRepresentable {
    let action: Selector
    
    func makeUIView(context: Context) -> UIButton {
        // UIButtonを生成し、セレクターをactionに設定
        let button = UIButton()
        button.addTarget(nil,
                         action: action,
                         for: .allTouchEvents)
        return button
    }
    
    func updateUIView(_ button: UIButton, context: Context) {}
}

