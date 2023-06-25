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
    
    let CONV＿TEXT = [
        "a": "ア",
        "i": "イ",
        "u": "ウ",
        "e": "エ",
        "o": "オ",
        "ka": "カ",
        "ki": "キ",
        "ku": "ク",
        "ke": "ケ",
        "ko": "コ",
        "kya": "キャ",
        "kyi": "キィ",
        "kyu": "キュ",
        "kye": "キェ",
        "kyo": "キョ",
        "kwa": "クヮ",
        "kwi": "クィ",
        "kwu": "クゥ",
        "kwe": "クェ",
        "kwo": "クォ",
        "sa": "サ",
        "si": "シ",
        "su": "ス",
        "se": "セ",
        "so": "ソ",
        "sya": "シャ",
        "syi": "シ",
        "syu": "シュ",
        "sye": "シェ",
        "syo": "ショ",
        "sha": "シャ",
        "shi": "シ",
        "shu": "シュ",
        "she": "シェ",
        "sho": "ショ",
        "swa": "スヮ",
        "swi": "スィ",
        "swu": "スゥ",
        "swe": "スェ",
        "swo": "スォ",
        "ta": "タ",
        "ti": "チ",
        "tu": "ツ",
        "te": "テ",
        "to": "ト",
        "tya": "チャ",
        "tyi": "チィ",
        "tyu": "チュ",
        "tye": "チェ",
        "tyo": "チョ",
        "tha": "テャ",
        "thi": "ティ",
        "thu": "テュ",
        "the": "テェ",
        "tho": "テョ",
        "tsa": "ツァ",
        "tsi": "ツィ",
        "tsu": "ツ",
        "tse": "ツェ",
        "tso": "ツォ",
        "ca": "カ",
        "ci": "シ",
        "cu": "ク",
        "ce": "セ",
        "co": "コ",
        "cha": "チャ",
        "chi": "チ",
        "chu": "チュ",
        "che": "チェ",
        "cho": "チョ",
        "cya": "チャ",
        "cyi": "チィ",
        "cyu": "チュ",
        "cye": "チェ",
        "cyo": "チョ",
        "qa": "クァ",
        "qi": "クィ",
        "qu": "ク",
        "qe": "クェ",
        "qo": "クォ",
        "na": "ナ",
        "ni": "ニ",
        "nu": "ヌ",
        "ne": "ネ",
        "no": "ノ",
        "nya": "ニャ",
        "nyi": "ニィ",
        "nyu": "ニュ",
        "nye": "ニェ",
        "nyo": "ニョ",
        "nwa": "ヌヮ",
        "nwi": "ヌィ",
        "nwu": "ヌゥ",
        "nwe": "ヌェ",
        "nwo": "ヌォ",
        "ha": "ハ",
        "hi": "ヒ",
        "hu": "フ",
        "he": "ヘ",
        "ho": "ホ",
        "hya": "ヒャ",
        "hyi": "ヒィ",
        "hyu": "ヒュ",
        "hye": "ヒェ",
        "hyo": "ヒョ",
        "fa": "ファ",
        "fi": "フィ",
        "fu": "フ",
        "fe": "フェ",
        "fo": "フォ",
        "fya": "フャ",
        "fyi": "フィ",
        "fyu": "フュ",
        "fye": "フェ",
        "fyo": "フョ",
        "ma": "マ",
        "mi": "ミ",
        "mu": "ム",
        "me": "メ",
        "mo": "モ",
        "mya": "ミャ",
        "myi": "ミィ",
        "myu": "ミュ",
        "mye": "ミェ",
        "myo": "ミョ",
        "ya": "ヤ",
        "yi": "イ",
        "yu": "ユ",
        "ye": "イェ",
        "yo": "ヨ",
        "ra": "ラ",
        "ri": "リ",
        "ru": "ル",
        "re": "レ",
        "ro": "ロ",
        "rya": "リャ",
        "ryi": "リィ",
        "ryu": "リュ",
        "rye": "リェ",
        "ryo": "リョ",
        "wa": "ワ",
        "wi": "ウィ",
        "wu": "ウ",
        "we": "ウェ",
        "wo": "ウォ",
        "ga": "ガ",
        "gi": "ギ",
        "gu": "グ",
        "ge": "ゲ",
        "go": "ゴ",
        "gya": "ギャ",
        "gyi": "ギィ",
        "gyu": "ギュ",
        "gye": "ギェ",
        "gyo": "ギョ",
        "za": "ザ",
        "zi": "ジ",
        "zu": "ズ",
        "ze": "ゼ",
        "zo": "ゾ",
        "zya": "ジャ",
        "zyi": "ジィ",
        "zyu": "ジュ",
        "zye": "ジェ",
        "zyo": "ジョ",
        "ja": "ジャ",
        "ji": "ジ",
        "ju": "ジュ",
        "je": "ジェ",
        "jo": "ジョ",
        "jya": "ジャ",
        "jyi": "ジィ",
        "jyu": "ジュ",
        "jye": "ジェ",
        "jyo": "ジョ",
        "da": "ダ",
        "di": "ヂ",
        "du": "ヅ",
        "de": "デ",
        "do": "ド",
        "dha": "デャ",
        "dhi": "ディ",
        "dhu": "デュ",
        "dhe": "デェ",
        "dho": "デョ",
        "dya": "ヂャ",
        "dyi": "ヂィ",
        "dyu": "ヂュ",
        "dye": "ヂェ",
        "dyo": "ヂョ",
        "ba": "バ",
        "bi": "ビ",
        "bu": "ブ",
        "be": "ベ",
        "bo": "ボ",
        "bya": "ビャ",
        "byi": "ビィ",
        "byu": "ビュ",
        "bye": "ビェ",
        "byo": "ビョ",
        "va": "ヴァ",
        "vi": "ヴィ",
        "vu": "ヴ",
        "ve": "ヴェ",
        "vo": "ヴォ",
        "vya": "ヴャ",
        "vyi": "ヴィ",
        "vyu": "ヴュ",
        "vye": "ヴェ",
        "vyo": "ヴョ",
        "pa": "パ",
        "pi": "ピ",
        "pu": "プ",
        "pe": "ペ",
        "po": "ポ",
        "pya": "ピャ",
        "pyi": "ピィ",
        "pyu": "ピュ",
        "pye": "ピェ",
        "pyo": "ピョ",
        "xa": "ァ",
        "xi": "ィ",
        "xu": "ゥ",
        "xe": "ェ",
        "xo": "ォ",
        "xya": "ャ",
        "xyi": "ィ",
        "xyu": "ュ",
        "xye": "ェ",
        "xyo": "ョ",
        "la": "ァ",
        "li": "ィ",
        "lu": "ゥ",
        "le": "ェ",
        "lo": "ォ",
        "lya": "ャ",
        "lyi": "ィ",
        "lyu": "ュ",
        "lye": "ェ",
        "lyo": "ョ",
        "ltu": "ッ",
        "xtu": "ッ",
        "ltsu": "ッ",
        "xtsu": "ッ"
    ]
    
    var body: some View {
        VStack {
            ZStack{
                Spacer()
                    .frame(height: keyHeight)
                TextField("", text: $inputText)
                    .onChange(of: inputText) { _ in
                        convertText()
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
                ZStack{
                    Spacer()
                        .frame(width: keyWidth * 4.5 + keySpacing * 5)
                    Text("大西配列")
                        .font(.system(size: keyHeight / 3))
                }
                Group {
                    ForEach(keys[2], id: \.self) { key in
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
                        if inputText.count <= 0{
                            
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
        let conversions = CONV＿TEXT.sorted { $0.value.count < $1.value.count }.reversed()
        for conv in conversions{
            inputText = inputText.replacingOccurrences(of: conv.key, with: conv.value)
        }
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

