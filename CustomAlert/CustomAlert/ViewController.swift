//
//  ViewController.swift
//  CustomAlert
//
//  Created by inooph on 2023/08/22.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    // MARK: ------------------- IBOutlets -------------------
    
    @IBOutlet weak var btnPupMenu: UIButton!
    
    @IBOutlet var btnAlrtArr: [UIButton]!
    @IBOutlet var btnPmArr: [UIButton]!
    
    @IBOutlet weak var tblView: UITableView!
    var tblArr: [Int] = []
    
    
    
    // MARK: ------------------- Variables -------------------
    var isDefPair: btnLayout = .withinZroIdx {
        willSet {
            print("--> isDefPair didSet = \(newValue) / in viewCont\n")
        }
    }
    
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
        guard let title = sender.configuration?.title,
              let ttSbtr = title.split(separator: ".").first,
              let style = alrtStyle(rawValue: title) else { return }
        
        print("--> \(title) tag = \(sender.tag) / in btnAlrtAction\n")
        artActs.removeAll()
        
        //// 여러줄 확인 / let > var 2ea : ttSbtr, title
        //for _ in 0...2 {
        //    ttSbtr.append(contentsOf: ttSbtr)
        //    ttSbtr.append(contentsOf: ttSbtr)
        //    ttSbtr.append(contentsOf: ttSbtr)
        //
        //    title.append(title)
        //    title.append(title)
        //}
        
        let ttStr   = String(describing: ttSbtr)
        artTp       = ("\(ttStr)", "\(title)")
        
        switch style {
        case .basic:
            for (i, _) in tblArr.enumerated() {
                artActs.append(.init(title: "sys \(i)",
                                     style: .default,
                                     handler: { act in print("--> sys \(i)") }) )
            }
            
            showAlertVC()
        
        case .csXib:
            let csXibVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CsXibVC") as! CsXibVC
            csXibVC.modalPresentationStyle = .overFullScreen
            csXibVC.artTp = artTp
            csXibVC.isDefPair = isDefPair

            for (i, _) in tblArr.enumerated() {
                csXibVC.btnTitleArr.append("cst 2-1. \(i)")
            }
            
            present(csXibVC, animated: true)
        
        case .csCode:
            let csCodeVC = CsCodeVC()
            csCodeVC.modalPresentationStyle = .overFullScreen
            csCodeVC.artTp = artTp
            csCodeVC.isDefPair = isDefPair
            
            csCodeVC.btnTitleArr = tblArr.map { "cst 2-2. \(String(describing: $0))" }
            
            present(csCodeVC, animated: true)
            
        case .csSfUi:
            var rootVC          = CsSfUiVC()
            rootVC.artTp        = artTp
            var tmpbtnTitArr: [btnTitle] = []
            for (i, _) in tblArr.enumerated() {
                let item = btnTitle(idx: "\(String(describing: i))")
                tmpbtnTitArr.append(item)
            }
            
            rootVC.btnTitArr = tmpbtnTitArr
            
            let hostVC = UIHostingController(rootView: rootVC)
            hostVC.sizingOptions          = .preferredContentSize
            hostVC.modalPresentationStyle = .overFullScreen
            hostVC.view.backgroundColor   = .clear
            
            present(hostVC, animated: true)
        }
    }
    
    func showAlertVC(useDef: Bool = false) {
        let artVC: UIAlertController = .init(title: artTp.title, message: artTp.msg, preferredStyle: .alert)
        
        guard artActs.count > 0 || useDef else {
            artVC.title     = ""
            artVC.message   = "+ 버튼을 눌러 요소를 추가하세요"
            
            artVC.addAction(.init(title: "확인", style: .default))
            present(artVC, animated: true)
            
            return
        }
        
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
        let btnTitles: [String] = [alrtStyle.basic, alrtStyle.csXib, alrtStyle.csCode, alrtStyle.csSfUi].map { $0.rawValue }
        
        for (i, btn) in btnAlrtArr.enumerated() {
            btn.tag = i
            btn.addTarget(self, action: #selector(btnAlrtAction), for: .touchUpInside)
            btn.setTitle(btnTitles[i], for: .normal)
        }
        
        let btnLayouts: [UIAction] = [btnLayout.withinZroIdx, btnLayout.evenRng, btnLayout.fullSize].map { val in
            let act: UIAction = .init(title: val.rawValue, image: nil) { [weak self] _ in
                guard let `self` = self else { return }
                self.isDefPair = val
            }
            return act
        }
        
        btnPupMenu.menu = UIMenu(children: btnLayouts)
    }
    
    
    @IBAction func btnInfoAct(_ sender: UIButton) {
        artTp.title.removeAll()
        artTp.msg = """
1. 버튼 설명
+ : 알림창 버튼 개수 추가
- : 알림창 버튼 추가된 개수에서 제거

2. 알림창 스타일
\(alrtStyle.basic.rawValue)
\(alrtStyle.csXib.rawValue)
\(alrtStyle.csCode.rawValue)
\(alrtStyle.csSfUi.rawValue)
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
    case csXib  = "알림2-1. 커스텀 스타일 / xib"
    case csCode = "알림2-2. 커스텀 스타일 / code"
    case csSfUi = "알림2-3. 커스텀 스타일 / SwiftUI"
    
    init?(rawValue: String) {
        switch rawValue {
        case alrtStyle.basic.rawValue:
            self = .basic
            
        case alrtStyle.csXib.rawValue:
            self = .csXib
            
        case alrtStyle.csCode.rawValue:
            self = .csCode
            
        case alrtStyle.csSfUi.rawValue:
            self = .csSfUi
            
        default:
            return nil
            
        }
    }
}


