//
//  CsXibVC.swift
//  CustomAlert
//
//  Created by inooph on 2023/08/24.
//

import SwiftUI
import UIKit

struct CsSfUiVC: View, PrBtnLayout {
    var isDefPair: btnLayout = .withinZroIdx
    
    var btnTitleArr: [String] = []
    var btnTitArr: [btnTitle] = []
    
    var titMsgViewFull: CGFloat = 1.0
    var titMsgViewMax: CGFloat  = 0.6
    
    @Environment(\.dismiss) var dismiss
    
    @State var didAppear: Bool = false {
        willSet { print("--> didAppear = \(newValue)\n")}
    }
    
    var nxtBgCol: Color {
        didAppear ? .primary.opacity(0.35) : .clear
    }
    
    var artTp: (title: String, msg: String) = ("title title title ", "desc desc desc")
    
    var tblMxHeight: CGFloat {
        return viewSize.height * (1.0 - titMsgViewMax)
    }
    
    var totalCellHgt: CGFloat {
        return CGFloat(btnTitArr.count) * defCellHgt
    }
    
    
    var body: some View {
        
        ZStackLayout(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
            VStack(spacing: 16) {
                
                ScrollView(.vertical, showsIndicators: true) {
                    Text("\(artTp.title)")
                        .fontWeight(.bold)
                        .foregroundColor(.pink)
                        .multilineTextAlignment(.center)
                        .padding(.top, 40)
                    
                    Text("\(artTp.msg)")
                        .foregroundColor(.black)
                        .fontWeight(.regular)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 25)
                }.frame(maxHeight: viewSize.height * ( totalCellHgt > 0  ? titMsgViewMax : 0.2) )
                
                List(btnTitArr) { item in
                    rowView(str: String(describing: item.idx))
                }
                // MARK: - [🔴] todo /// gdlk49
                .frame(height: viewSize.height - titMsgViewMax - totalCellHgt > 0 ? tblMxHeight : totalCellHgt)
                .background(.red)
                .listStyle(.plain)
                
            }
            .frame(width: (viewSize.width * 0.65))
            .padding(.vertical, 25)
            .padding(.horizontal, 30)
            .background(BlurView())
            .cornerRadius(25)
            
            Button(action: {
                withAnimation {
                    didAppear.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        dismiss()
                    }
                }
                
            }) {
                Image(systemName: "xmark.circle")
                    .font(.system(size: 28, weight: .regular))
                    .foregroundColor(.purple)
            }.padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(nxtBgCol)
        .animation(.linear(duration: 0.3), value: nxtBgCol)

        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                didAppear.toggle()
            }
        }
        
    }

    
}

struct rowView: View {
    var str: String
    var body: some View {
        HStack(alignment: .center) {
            Button(str) {
                print("--> tapped \(str)")
            }.frame(maxWidth: .infinity)
            
            Button(str) {
                print("--> tapped \(str)")
            }.frame(maxWidth: .infinity)
        }
    }
}

struct BlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CsSfUiVC()
    }
}

struct btnTitle: Identifiable {
    var id = UUID()
    var idx: String
}

extension View {
    var viewSize: CGSize {
        return .init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}
