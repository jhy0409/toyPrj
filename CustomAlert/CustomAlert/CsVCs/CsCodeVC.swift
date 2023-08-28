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
    var ctTopBtm: CGFloat = 10
    
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
    
    var lblTitleHeight: CGFloat = 20 {
        willSet {
            let defMrgVerti: CGFloat    = csXViewNums.defMrgVerti * 2
            //let viewHeight: CGFloat     = view.frame.height - (defMrgVerti * view.frame.height)
            let viewHeight: CGFloat     = containerView.frame.height
            
            let mxHeight: CGFloat       = viewHeight * csXViewNums.tblDefRatio
            let height: CGFloat         = lblMsg.frame.maxY
            let resHeight: CGFloat      = height > mxHeight ? mxHeight : height
            //contV_titMsgHeight.constant = height > mxHeight ? mxHeight : height
            contTitMstViewHeight?.update(offset: resHeight)
            
            let remainHgt: CGFloat      = viewHeight - resHeight
            //tvHeight.constant           = remainHgt - tblHeightVal < 0 ? remainHgt : tblHeightVal
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
    //    super.viewDidAppear(animated)
    //    contTitMstView.snp.updateConstraints { make in
    //        make.height.equalTo(lblMsg.frame.maxY)
    //    }
    //    super.updateViewConstraints()
        
        
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
        
        //NSLayoutConstraint.activate([
        //    containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        //    containerView.widthAnchor.constraint(equalToConstant: view.frame.width * contV_WidthRatio),
        //    containerView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        //    containerView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: ctTopBtm),
        //    containerView.bottomAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: ctTopBtm),
        //
        //    contTitMstView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
        //    contTitMstView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        //    contTitMstView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
        //    contTitMstView.heightAnchor.constraint(equalToConstant: contV_titMsgHeight),
        //
        //    scrWithTitleMsg.leadingAnchor.constraint(equalTo: contTitMstView.leadingAnchor, constant: 16),
        //    scrWithTitleMsg.trailingAnchor.constraint(equalTo: contTitMstView.trailingAnchor, constant: -16),
        //    scrWithTitleMsg.topAnchor.constraint(equalTo: contTitMstView.topAnchor),
        //    scrWithTitleMsg.bottomAnchor.constraint(equalTo: contTitMstView.bottomAnchor),
        //
        //    lblTitle.leadingAnchor.constraint(equalTo: scrWithTitleMsg.leadingAnchor),
        //    lblTitle.trailingAnchor.constraint(equalTo: scrWithTitleMsg.trailingAnchor),
        //    lblTitle.widthAnchor.constraint(equalTo: scrFL.widthAnchor, multiplier: 1.0),
        //    lblTitle.topAnchor.constraint(equalTo: scrWithTitleMsg.topAnchor),
        //
        //    lblMsg.leadingAnchor.constraint(equalTo: scrWithTitleMsg.leadingAnchor),
        //    lblMsg.trailingAnchor.constraint(equalTo: scrWithTitleMsg.trailingAnchor),
        //    lblMsg.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 16),
        //    lblMsg.bottomAnchor.constraint(equalTo: scrCL.bottomAnchor, constant: -16),
        //
        //    tblView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
        //    tblView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        //    tblView.topAnchor.constraint(equalTo: contTitMstView.bottomAnchor, constant: 16),
        //    tblView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        //    tblView.heightAnchor.constraint(equalToConstant: tvHeight)
        //])
        
        
        
        
        let defMrgVerti: CGFloat    = csXViewNums.defMrgVerti * 2 * view.frame.height
        //let viewHeight: CGFloat     = view.frame.height - defMrgVerti
        let viewHeight: CGFloat     = view.frame.height - defMrgVerti
        let mxHeight: CGFloat       = viewHeight * csXViewNums.tblDefRatio
        
        let defHeight: CGFloat      = mxHeight
        let isTblHide: Bool         = tblHeightVal <= 0
        
        containerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(view.frame.width * contV_WidthRatio)
            make.centerY.equalTo(view.snp_centerYWithinMargins)
            make.top.bottom.greaterThanOrEqualTo(view).inset(defMrgVerti)
        }
        
        contTitMstView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(containerView)
            make.top.equalTo(containerView).inset(16)
            
            self.contTitMstViewHeight = make.height.equalTo(isTblHide ? viewHeight : viewHeight * 0.6).priority(.high).constraint
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
            make.bottom.equalTo(scrWithTitleMsg).offset(isTblHide ? 0 : -16)
        }
        
        tblView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(containerView)
            make.top.equalTo(contTitMstView.snp.bottom).offset(0)
            make.bottom.equalTo(containerView.snp.bottom).inset(16)
            
            self.tvHeight = make.height.equalTo(tblHeightVal).priority(.low).constraint
            make.height.lessThanOrEqualTo(defHeight * 0.4)
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
