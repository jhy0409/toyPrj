//
//  ViewController.swift
//  CustomAlert
//
//  Created by inooph on 2023/08/22.
//

import UIKit

class ViewController: UIViewController {

    // MARK: ------------------- IBOutlets -------------------
    
    
    @IBOutlet var btnAlrtArr: [UIButton]!
    @IBOutlet var btnPmArr: [UIButton]!
    
    @IBOutlet weak var tblView: UITableView!
    var tblArr: [Int] = []
    
    
    
    // MARK: ------------------- Variables -------------------
    var artTp: (title: String, msg: String) = ("", "")
    
    var artActs: [UIAlertAction] = []
    
    // MARK: ------------------- View Life Cycle -------------------
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setView()
    }

    
    // MARK: ------------------- IBAction functions -------------------
    @objc func btnAlrtAction(_ sender: UIButton) {
        guard let title = sender.configuration?.title, let style = alrtStyle(rawValue: title) else { return }
        print("--> \(title) tag = \(sender.tag) / in btnAlrtAction\n")
        artActs.removeAll()
        
        switch style {
        case .basic:
            artTp = (String(describing: title.split(separator: ".").first ?? ""), title)
            
            for (i, _) in tblArr.enumerated() {
                artActs.append(.init(title: "sys \(i)",
                                     style: .default,
                                     handler: { act in print("--> sys \(i)") }) )
            }
            
            showAlertVC()
        
        case .custom:
            break
        }
    }
    
    func showAlertVC(useDef: Bool = false) {
        guard artActs.count > 0 || useDef else { return }
        
        let artVC: UIAlertController = .init(title: artTp.title, message: artTp.msg, preferredStyle: .alert)
        
        if useDef {
            artVC.addAction(.init(title: "확인", style: .default))
            
        } else {
            artActs.forEach { act in
                artVC.addAction(act)
            }
        }
        
        
        present(artVC, animated: true)
    }
    
    
    @IBAction func chngeTblArrAct(_ sender: UIButton) {
        guard let title = sender.configuration?.title else { return }
        switch title {
        case "+":
            tblArr.append(0)
            
        case "-":
            guard tblArr.count > 0 else { return }
            tblArr.removeLast()
            
        default:
            break
        }
        
        tblView.reloadData()
    }
    
    
    // MARK: ------------------- function -------------------
    func setView() {
        for (i, btn) in btnAlrtArr.enumerated() {
            btn.tag = i
            btn.addTarget(self, action: #selector(btnAlrtAction), for: .touchUpInside)
        }
    }
    
    
    @IBAction func btnInfoAct(_ sender: UIButton) {
        artTp.msg = """
1. 버튼 설명
+ : 알림창 버튼 개수 추가
- : 알림창 버튼 추가된 개수에서 제거

2. 알림창 스타일
\(alrtStyle.basic.rawValue)
\(alrtStyle.custom.rawValue)
"""
        showAlertVC(useDef: true)
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tblArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! tvcCell
        cell.lbl.text = String(describing: indexPath.row)
        
        return cell
    }
    
    
}

class tvcCell: UITableViewCell {
    @IBOutlet weak var lbl: UILabel!
}

enum alrtStyle: String {
    case basic  = "알림1. 시스템 기본스타일"
    case custom = "알림2. 커스텀 스타일"
    
    init?(rawValue: String) {
        switch rawValue {
        case alrtStyle.basic.rawValue:
            self = .basic
            
        case alrtStyle.custom.rawValue:
            self = .custom
            
        default:
            return nil
            
        }
    }
}

extension UIView {
    @IBInspectable var cornerRadi: CGFloat {
        get {
            layer.cornerRadius
        }
        
        set {
            clipsToBounds = true
            layer.cornerRadius = newValue
            layoutSubviews()
        }
    }
    
    @IBInspectable var brdWidth: CGFloat {
        get {
            layer.borderWidth
        }
        
        set {
            layer.borderWidth = newValue
            layoutSubviews()
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
            layoutSubviews()
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
