//
//  CsXibVC.swift
//  CustomAlert
//
//  Created by inooph on 2023/08/24.
//

import UIKit

class CsCodeVC: useDimBgVC {
    
    // MARK: ------------------- IBOutlets -------------------
    var scrWithTitleMsg: UIScrollView = .init()
    var lblTitle: UILabel = .init()
    var lblMsg: UILabel = .init()
    
    var containerView: UIStackView = .init()
    var contV_WidthRatio: CGFloat = 0.85
    var ctTopBtm: CGFloat = 10
    
    var contTitMstView: UIView = .init()
    var contV_titMsgHeight: CGFloat = 89
    
    var tblView: UITableView = {
      let view = UITableView()
        view.register(CsCodeTVC.self, forCellReuseIdentifier: "CsCodeTVC")
        
        return view
    }()
    
    var tvHeight: CGFloat = 100
    var defCellHgt: CGFloat = 50
    
    
    var artTp: (title: String, msg: String) = ("", "")
    
    // MARK: ------------------- Variables -------------------
    var isDefPair: btnLayout = .withinZroIdx
    var btnTitleArr: [String] = []
    
    // MARK: ------------------- View Life Cycle -------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setView()
        view.backgroundColor = .clear
    }
    
    override func setView(fcn: String = #function, lne: Int = #line, spot: String = #fileID) {
        super.setView(fcn: fcn, lne: lne, spot: spot)
        
        view.addSubview(containerView)
        containerView.addSubview(contTitMstView)
        containerView.addSubview(tblView)
        
        contTitMstView.addSubview(scrWithTitleMsg)
        scrWithTitleMsg.addSubview(lblTitle)
        scrWithTitleMsg.addSubview(lblMsg)
        
        tblView.dataSource  = self
        tblView.delegate    = self
        
        for (i, obj) in [containerView, contTitMstView, tblView, scrWithTitleMsg, scrWithTitleMsg, lblTitle, lblMsg].enumerated() {
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.tag = i
            
            obj.backgroundColor = .getRainb(idx: i)
        }
        
        containerView.alignment     = .fill
        containerView.distribution  = .fill
        containerView.axis          = .vertical
        containerView.spacing       = 0
        containerView.cornerRadi    = 15
        
        lblTitle.text   = artTp.title
        lblMsg.text     = artTp.msg
        
        for (i, lbl) in [lblTitle, lblMsg].enumerated() {
            lbl.textAlignment = .center
            lbl.numberOfLines = 0
            
            lbl.setContentHuggingPriority( i < 1 ? .defaultHigh : .defaultLow, for: .vertical)
        }
        
        let scrCL = scrWithTitleMsg.contentLayoutGuide
        let scrFL = scrWithTitleMsg.frameLayoutGuide
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: view.frame.width * contV_WidthRatio),
            containerView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            containerView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: ctTopBtm),
            containerView.bottomAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: ctTopBtm),
            
            contTitMstView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            contTitMstView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            contTitMstView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            contTitMstView.heightAnchor.constraint(equalToConstant: contV_titMsgHeight),
            
            scrWithTitleMsg.leadingAnchor.constraint(equalTo: contTitMstView.leadingAnchor, constant: 16),
            scrWithTitleMsg.trailingAnchor.constraint(equalTo: contTitMstView.trailingAnchor, constant: -16),
            scrWithTitleMsg.topAnchor.constraint(equalTo: contTitMstView.topAnchor),
            scrWithTitleMsg.bottomAnchor.constraint(equalTo: contTitMstView.bottomAnchor),
            
            lblTitle.leadingAnchor.constraint(equalTo: scrWithTitleMsg.leadingAnchor),
            lblTitle.trailingAnchor.constraint(equalTo: scrWithTitleMsg.trailingAnchor),
            lblTitle.widthAnchor.constraint(equalTo: scrFL.widthAnchor, multiplier: 1.0),
            lblTitle.topAnchor.constraint(equalTo: scrWithTitleMsg.topAnchor),
            
            lblMsg.leadingAnchor.constraint(equalTo: scrWithTitleMsg.leadingAnchor),
            lblMsg.trailingAnchor.constraint(equalTo: scrWithTitleMsg.trailingAnchor),
            lblMsg.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 16),
            lblMsg.bottomAnchor.constraint(equalTo: scrCL.bottomAnchor, constant: -16),
            
            tblView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tblView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tblView.topAnchor.constraint(equalTo: contTitMstView.bottomAnchor, constant: 16),
            tblView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            tblView.heightAnchor.constraint(equalToConstant: tvHeight)
        ])
        
        
    }
    
    
    // MARK: ------------------- IBAction functions -------------------
    
    
    // MARK: ------------------- function -------------------

}

// MARK: ------------------- tableView -------------------
extension CsCodeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return btnTitleArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return defCellHgt
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CsCodeTVC") as! CsCodeTVC
        cell.backgroundColor = .getRainb(idx: indexPath.row + 2)
        
        return cell
    }
}


class CsCodeTVC: UITableViewCell {
    
}
