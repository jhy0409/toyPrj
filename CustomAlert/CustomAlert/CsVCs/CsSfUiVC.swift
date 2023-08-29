//
//  CsXibVC.swift
//  CustomAlert
//
//  Created by inooph on 2023/08/24.
//

import SwiftUI
import UIKit

struct CsSfUiVC: View {
    @Environment(\.dismiss) var dismiss
    
    @State var didAppear: Bool = false {
        willSet { print("--> didAppear = \(newValue)\n")}
    }
    
    var nxtBgCol: Color {
        didAppear ? .primary.opacity(0.35) : .clear
    }
    
    @State private var theCol: Color = .clear
    
    var body: some View {
        
        ZStackLayout(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
            VStack(spacing: 25) {
                Text("Congr")
                    .fontWeight(.bold)
                    .foregroundColor(.pink)
                
                Button(action: {}) {
                    Text("Back to Home")
                        .foregroundColor(.black)
                        .fontWeight(.regular)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 25)
                }
            }
            .padding(.vertical, 25)
            .padding(.horizontal, 30)
            .background(BlurView())
            .cornerRadius(25)
            
            
            Button(action: {
                withAnimation {
                    didAppear.toggle()
                    dismiss()
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
