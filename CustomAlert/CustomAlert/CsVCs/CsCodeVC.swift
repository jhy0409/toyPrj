//
//  CsXibVC.swift
//  CustomAlert
//
//  Created by inooph on 2023/08/24.
//

import UIKit
import SnapKit

class CsCodeVC: useDimBgVC, PrBtnLayout {

    // MARK: ------------------- IBOutlets -------------------
    var scrWithTitleMsg: UIScrollView = .init()
    var lblTitle: UILabel = .init()
    var lblMsg: UILabel = .init()
    
    var containerView: UIStackView = .init()
    var contV_WidthRatio: CGFloat = 0.85
    var ctTopBtm: Constraint?
    
    var contTitMstView: UIView = .init()
    var contTitMstViewHeight: Constraint?
    
    var contV_titMsgHeight: CGFloat = 89
    
    var tblView: UITableView = {
      let view = UITableView()
        view.register(CsCodeTVC.self, forCellReuseIdentifier: "CsCodeTVC")
        
        return view
    }()
    
    var tvHeight: Constraint?
    var defCellHgt: CGFloat = 50
    
    var titMsgViewFull: CGFloat = 1.0
    var titMsgViewMax: CGFloat = 0.6
    
    var artTp: (title: String, msg: String) = ("", "")
    
    var isTblHide: Bool {
        return tblHeightVal <= 0
    }
    
    /// 상하 마진
    var defMrgVti: CGFloat {
        return (csXViewNums.defMrgVerti * 2) * view.frame.height
    }
    
    var viewHeight: CGFloat {
        return view.frame.height - defMrgVti
    }
    
    var mxHeight: CGFloat {
        return viewHeight * csXViewNums.tblDefRatio
    }
    
    var mnHeight: CGFloat {
        return viewHeight * (1.0 - csXViewNums.tblDefRatio)
    }
    
    var lblTitleHeight: CGFloat = 20 {
        willSet {
            let height: CGFloat         = lblMsg.frame.maxY
            let resHeight: CGFloat      = height > mxHeight ? mxHeight : height
            contTitMstViewHeight?.update(inset: resHeight)
            
            let remainHgt: CGFloat      = viewHeight - resHeight
            tvHeight?.update(offset: remainHgt - tblHeightVal < 0 ? remainHgt : tblHeightVal)
            
            view.layoutIfNeeded()
            
        }
    }
    
    
    
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
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lblTitleHeight = lblMsg.frame.maxY
        
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
        
        containerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(view.frame.width * contV_WidthRatio)
            make.centerY.equalTo(view.snp.centerY)
            make.top.bottom.greaterThanOrEqualTo(view).inset(defMrgVti / 2)
        }
        
        contTitMstView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(containerView)
            make.top.equalTo(containerView).inset(16)
            
            self.contTitMstViewHeight = make.height.equalTo(isTblHide ? viewHeight : mxHeight).priority(.high).constraint
        }
        
        scrWithTitleMsg.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contTitMstView).inset(16)
            make.top.bottom.equalTo(contTitMstView)
        }
        
        lblTitle.snp.makeConstraints { make in
            make.centerX.width.equalTo(scrFL)
            make.top.equalTo(scrCL)
        }
        
        lblMsg.snp.makeConstraints { make in
            make.leading.trailing.equalTo(lblTitle)
            make.top.equalTo(lblTitle.snp.bottom).offset(16)
            make.bottom.equalTo(scrWithTitleMsg).offset(0)
        }
        
        tblView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(containerView)
            make.top.equalTo(contTitMstView.snp.bottom).offset(isTblHide ? 0 : 16)
            make.bottom.equalTo(containerView.snp.bottom).inset(isTblHide ? 16 : 0)
            
            self.tvHeight = make.height.equalTo(tblHeightVal).priority(.required).constraint
            make.height.lessThanOrEqualTo(mnHeight).priority(.required)
        }
        
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
