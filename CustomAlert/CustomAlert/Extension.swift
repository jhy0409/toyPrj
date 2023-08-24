//
//  Extension.swift
//  CustomAlert
//
//  Created by inooph on 2023/08/24.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var cornerRadi: CGFloat {
        get {
            layer.cornerRadius
        }
        
        set {
            clipsToBounds = true
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var brdWidth: CGFloat {
        get {
            layer.borderWidth
        }
        
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var brdCol: UIColor {
        get {
            if let col = layer.borderColor {
                return UIColor(cgColor: col)

            } else {
                return .clear
            }
        }
        
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    func setBorder(width: CGFloat = 1, radi: CGFloat = 10, col: UIColor) {
        layer.borderWidth   = width
        layer.borderColor   = col.cgColor
        layer.cornerRadius  = radi
    }
    
    @IBInspectable var isCircle: Bool {
        get {
            layoutSubviews()
            return layer.cornerRadius == layer.frame.height / 2
        }
        
        set {
            clipsToBounds = newValue
            layer.cornerRadius = newValue ? layer.frame.height / 2 : 0
            layoutSubviews()
        }
    }
    
   
}

class useDimBgVC: UIViewController {
    
    func setDimBg(_ isAppear: Bool = true) {
        UIView.animate(withDuration: isAppear ? 0.3 : 0, delay: isAppear ? 0.3 : 0) {
            self.view.backgroundColor = isAppear ? .black.withAlphaComponent(0.3) : .clear
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setDimBg()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        setDimBg(false)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if let view = touches.first?.view, view == self.view {
            dismiss(animated: true)
        }
    }
}
