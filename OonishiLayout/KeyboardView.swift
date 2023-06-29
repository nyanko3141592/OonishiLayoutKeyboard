//
//  KeyboardView.swift
//  OonishiLayout
//
//  Created by 高橋直希 /Users/naoki/Desktop/AzooKeyCoreon 2023/06/26.
//

import SwiftUI
import KanaKanjiConverterModule

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
    @State private var suggestWords: [String] = []
    
    let keys : [[String]] = [
        ["l", "u", "、", "。", "f", "w", "r", "y", "/"],
        ["e", "i", "a", "o", "ー", "k", "t", "n", "s", "h"],
        ["z", "","", "v",";", "g", "d", "m", "j", "b"]
    ]
    
    let CONV_WORDS : [[String]] = [
        ["おおにし", "大西"],
        ["はいれつ", "配列"]
    ]
    let CONV_ROMA_HIRA: [[String]] = [
        ["ltsu", "っ"],
        ["xtsu", "っ"],
        ["kya", "きゃ"],
        ["kyi", "きぃ"],
        ["kyu", "きゅ"],
        ["kye", "きぇ"],
        ["kyo", "きょ"],
        ["kwa", "くゎ"],
        ["kwi", "くぃ"],
        ["kwu", "くぅ"],
        ["kwe", "くぇ"],
        ["kwo", "くぉ"],
        ["sya", "しゃ"],
        ["syi", "し"],
        ["syu", "しゅ"],
        ["sye", "しぇ"],
        ["syo", "しょ"],
        ["sha", "しゃ"],
        ["shi", "し"],
        ["shu", "しゅ"],
        ["she", "しぇ"],
        ["sho", "しょ"],
        ["swa", "すゎ"],
        ["swi", "すぃ"],
        ["swu", "すぅ"],
        ["swe", "すぇ"],
        ["swo", "すぉ"],
        ["tya", "ちゃ"],
        ["tyi", "ちぃ"],
        ["tyu", "ちゅ"],
        ["tye", "ちぇ"],
        ["tyo", "ちょ"],
        ["tha", "てゃ"],
        ["thi", "てぃ"],
        ["thu", "てゅ"],
        ["the", "てぇ"],
        ["tho", "てょ"],
        ["tsa", "つぁ"],
        ["tsi", "つぃ"],
        ["tsu", "つ"],
        ["tse", "つぇ"],
        ["tso", "つぉ"],
        ["cha", "ちゃ"],
        ["chi", "ち"],
        ["chu", "ちゅ"],
        ["che", "ちぇ"],
        ["cho", "ちょ"],
        ["cya", "ちゃ"],
        ["cyi", "ちぃ"],
        ["cyu", "ちゅ"],
        ["cye", "ちぇ"],
        ["cyo", "ちょ"],
        ["nya", "にゃ"],
        ["nyi", "にぃ"],
        ["nyu", "にゅ"],
        ["nye", "にぇ"],
        ["nyo", "にょ"],
        ["nwa", "ぬゎ"],
        ["nwi", "ぬぃ"],
        ["nwu", "ぬぅ"],
        ["nwe", "ぬぇ"],
        ["nwo", "ぬぉ"],
        ["hya", "ひゃ"],
        ["hyi", "ひぃ"],
        ["hyu", "ひゅ"],
        ["hye", "ひぇ"],
        ["hyo", "ひょ"],
        ["fya", "ふゃ"],
        ["fyi", "ふぃ"],
        ["fyu", "ふゅ"],
        ["fye", "ふぇ"],
        ["fyo", "ふょ"],
        ["mya", "みゃ"],
        ["myi", "みぃ"],
        ["myu", "みゅ"],
        ["mye", "みぇ"],
        ["myo", "みょ"],
        ["rya", "りゃ"],
        ["ryi", "りぃ"],
        ["ryu", "りゅ"],
        ["rye", "りぇ"],
        ["ryo", "りょ"],
        ["gya", "ぎゃ"],
        ["gyi", "ぎぃ"],
        ["gyu", "ぎゅ"],
        ["gye", "ぎぇ"],
        ["gyo", "ぎょ"],
        ["zya", "じゃ"],
        ["zyi", "じぃ"],
        ["zyu", "じゅ"],
        ["zye", "じぇ"],
        ["zyo", "じょ"],
        ["jya", "じゃ"],
        ["jyi", "じぃ"],
        ["jyu", "じゅ"],
        ["jye", "じぇ"],
        ["jyo", "じょ"],
        ["dha", "でゃ"],
        ["dhi", "でぃ"],
        ["dhu", "でゅ"],
        ["dhe", "でぇ"],
        ["dho", "でょ"],
        ["dya", "ぢゃ"],
        ["dyi", "ぢぃ"],
        ["dyu", "ぢゅ"],
        ["dye", "ぢぇ"],
        ["dyo", "ぢょ"],
        ["bya", "びゃ"],
        ["byi", "びぃ"],
        ["byu", "びゅ"],
        ["bye", "びぇ"],
        ["byo", "びょ"],
        ["vya", "う゛ゃ"],
        ["vyi", "う゛ぃ"],
        ["vyu", "う゛ゅ"],
        ["vye", "う゛ぇ"],
        ["vyo", "う゛ょ"],
        ["pya", "ぴゃ"],
        ["pyi", "ぴぃ"],
        ["pyu", "ぴゅ"],
        ["pye", "ぴぇ"],
        ["pyo", "ぴょ"],
        ["xya", "ゃ"],
        ["xyi", "ぃ"],
        ["xyu", "ゅ"],
        ["xye", "ぇ"],
        ["xyo", "ょ"],
        ["lya", "ゃ"],
        ["lyi", "ぃ"],
        ["lyu", "ゅ"],
        ["lye", "ぇ"],
        ["lyo", "ょ"],
        ["ltu", "っ"],
        ["xtu", "っ"],
        ["bb", "っb"],
        ["cc", "っc"],
        ["dd", "っd"],
        ["ff", "っf"],
        ["gg", "っg"],
        ["hh", "っh"],
        ["jj", "っj"],
        ["kk", "っk"],
        ["ll", "っl"],
        ["mm", "っm"],
        ["pp", "っp"],
        ["qq", "っq"],
        ["rr", "っr"],
        ["ss", "っs"],
        ["tt", "っt"],
        ["vv", "っv"],
        ["ww", "っw"],
        ["xx", "っx"],
        ["yy", "っy"],
        ["zz", "っz"],
        ["ka", "か"],
        ["ki", "き"],
        ["ku", "く"],
        ["ke", "け"],
        ["ko", "こ"],
        ["sa", "さ"],
        ["si", "し"],
        ["su", "す"],
        ["se", "せ"],
        ["so", "そ"],
        ["ta", "た"],
        ["ti", "ち"],
        ["tu", "つ"],
        ["te", "て"],
        ["to", "と"],
        ["ca", "か"],
        ["ci", "し"],
        ["cu", "く"],
        ["ce", "せ"],
        ["co", "こ"],
        ["qa", "くぁ"],
        ["qi", "くぃ"],
        ["qu", "く"],
        ["qe", "くぇ"],
        ["qo", "くぉ"],
        ["na", "な"],
        ["ni", "に"],
        ["nu", "ぬ"],
        ["ne", "ね"],
        ["no", "の"],
        ["ha", "は"],
        ["hi", "ひ"],
        ["hu", "ふ"],
        ["he", "へ"],
        ["ho", "ほ"],
        ["fa", "ふぁ"],
        ["fi", "ふぃ"],
        ["fu", "ふ"],
        ["fe", "ふぇ"],
        ["fo", "ふぉ"],
        ["ma", "ま"],
        ["mi", "み"],
        ["mu", "む"],
        ["me", "め"],
        ["mo", "も"],
        ["ya", "や"],
        ["yi", "い"],
        ["yu", "ゆ"],
        ["ye", "いぇ"],
        ["yo", "よ"],
        ["ra", "ら"],
        ["ri", "り"],
        ["ru", "る"],
        ["re", "れ"],
        ["ro", "ろ"],
        ["wa", "わ"],
        ["wi", "うぃ"],
        ["wu", "う"],
        ["we", "うぇ"],
        ["wo", "うぉ"],
        ["ga", "が"],
        ["gi", "ぎ"],
        ["gu", "ぐ"],
        ["ge", "げ"],
        ["go", "ご"],
        ["za", "ざ"],
        ["zi", "じ"],
        ["zu", "ず"],
        ["ze", "ぜ"],
        ["zo", "ぞ"],
        ["ja", "じゃ"],
        ["ji", "じ"],
        ["ju", "じゅ"],
        ["je", "じぇ"],
        ["jo", "じょ"],
        ["da", "だ"],
        ["di", "ぢ"],
        ["du", "づ"],
        ["de", "で"],
        ["do", "ど"],
        ["ba", "ば"],
        ["bi", "び"],
        ["bu", "ぶ"],
        ["be", "べ"],
        ["bo", "ぼ"],
        ["va", "う゛ぁ"],
        ["vi", "う゛ぃ"],
        ["vu", "う゛"],
        ["ve", "う゛ぇ"],
        ["vo", "う゛ぉ"],
        ["pa", "ぱ"],
        ["pi", "ぴ"],
        ["pu", "ぷ"],
        ["pe", "ぺ"],
        ["po", "ぽ"],
        ["xa", "ぁ"],
        ["xi", "ぃ"],
        ["xu", "ぅ"],
        ["xe", "ぇ"],
        ["xo", "ぉ"],
        ["la", "ぁ"],
        ["li", "ぃ"],
        ["lu", "ぅ"],
        ["le", "ぇ"],
        ["lo", "ぉ"],
        ["nn", "ん"],
        ["a", "あ"],
        ["i", "い"],
        ["u", "う"],
        ["e", "え"],
        ["o", "お"],
    ]
    
    var body: some View {
        VStack {
            ZStack{
                Spacer()
                    .frame(height: keyHeight)
                HStack{
                    Text(" ")
                    TextField("", text: $inputText)
                        .onChange(of: inputText) { _ in
                            convertText()
                            suggestWords = suggestConvWord()
                        }
                        .frame(maxWidth: keyWidth * 4.5)
                    Divider()
                    if suggestWords.count != 0{
                        ForEach(suggestWords,id: \.self) { key in
                            Button(action: {
                                inputTextAction(key)
                                enteredText()
                            }) {
                                Text(" " + key + " ")
                                    .frame(height: keyHeight)
                                    .background(Color(uiColor: .systemBackground))
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .shadow(radius: 8)
                            }
                        }
                    }
                    
                    Spacer()
                }
                
            }
            HStack(spacing: keySpacing) {
                Spacer()
                    .frame(width: keyWidth * 0.5 + keySpacing * 1)
                Group {
                    ForEach(keys[0], id: \.self) { key in
                        Button(action: {
                            inputText += key
                        }) {
                            Text(key)
                                .frame(width: keyWidth, height: keyHeight)
                                .background(Color(uiColor: .systemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .shadow(radius: 8)
                        }
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
                        Button(action: {
                            inputText += key
                        }) {
                            Text(key)
                                .frame(width: keyWidth, height: keyHeight)
                                .background(Color(uiColor: .systemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .shadow(radius: 8)
                        }
                    }
                }
                .background(Color(uiColor: .systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 1)
                Spacer()
            }
            HStack(spacing: keySpacing) {
                Spacer()
                    .frame(width: keyWidth * 0.5 + keySpacing * 0.5)
                Group {
                    ForEach(keys[2], id: \.self) { key in
                        if key == ""{
                            Spacer()
                                .frame(width: keyWidth, height: keyHeight)
                                .background(Color(uiColor: .systemGray))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .shadow(radius: 8)
                        }else{
                            Button(action: {
                                inputText += key
                            }) {
                                Text(key)
                                    .frame(width: keyWidth, height: keyHeight)
                                    .background(Color(uiColor: .systemBackground))
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .shadow(radius: 8)
                            }
                        }
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
                        if inputText == "" {
                            inputTextAction("　")
                        }else{
                            // 変換のsuggestを出す
                        }
                    }
                    .frame(maxWidth: keyWidth * 5)
                    .frame(height: keyHeight)
                    .padding(.horizontal)
                    Spacer()
                    // Delete Text
                    Button {
                        if inputText.count > 0{
                            inputText.removeLast()
                        }else{
                            deleteTextAction()
                        }
                    } label: {
                        Image(systemName: "delete.left")
                            .frame(width: keyHeight, height: keyHeight)
                    }
                    
                    // Enter Text
                    Button {
                        // enter text
                        inputTextAction(inputText)
                        enteredText()
                    } label: {
                        Image(systemName: "arrow.turn.down.left")
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
    
    private func convertText() {
        // inputTextをローマ字で置換
        for i in 0..<CONV_ROMA_HIRA.count{
            inputText = inputText.replacingOccurrences(of: CONV_ROMA_HIRA[i][0], with: CONV_ROMA_HIRA[i][1])
        }
    }
    
    func enteredText(){
        inputText = ""
        suggestWords = []
    }

    private func suggestConvWord() -> [String] {
        if inputText == "" {
            return []
        }
        
        // 変換器を初期化する
        let converter = KanaKanjiConverter()
        
        // 入力を初期化する
        var composingText = ComposingText()
        composingText.insertAtCursorPosition(inputText, inputStyle: .direct)
        
        // 変換のためのオプションを指定
        let options = ConvertRequestOptions.appDefault
        
        // 変換を要求し、結果を取得
        let results = converter.requestCandidates(composingText, options: options)
        
        if let firstResult = results.mainResults.first {
            // 変換結果の一番目を表示
            return [firstResult.text]
        }
        
        return []
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


extension ConvertRequestOptions {
    static var appDefault: Self {
        .init(requireJapanesePrediction: false, requireEnglishPrediction: false, keyboardLanguage: .ja_JP, englishCandidateInRoman2KanaInput: false, halfWidthKanaCandidate: false, learningType: .nothing, dictionaryResourceURL: Bundle.main.bundleURL.appending(path: "Dictionary", directoryHint: .isDirectory), memoryDirectoryURL: Bundle.main.bundleURL, sharedContainerURL: Bundle.main.bundleURL, metadata: .init(appVersionString: "DictionaryDebugger"))
    }
}
