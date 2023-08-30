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
    
    var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        
        return view
    }()
    
    var tblView: UITableView = {
      let view = UITableView()
        view.register(CsCodeTVC.self, forCellReuseIdentifier: "CsCodeTVC")
        view.separatorInset = .zero
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
    
    var lblMsgMaxY: CGFloat {
        return lblMsg.frame.maxY
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
        
        let resHeight: CGFloat  = lblMsgMaxY > mxHeight ? mxHeight : lblMsgMaxY
        contTitMstViewHeight?.update(inset: resHeight)
        
        let exceptTitlMsg: CGFloat  = viewHeight - resHeight - 32
        let remainHgt: CGFloat      = exceptTitlMsg - tblHeightVal < 0 ? mnHeight : tblHeightVal
        tvHeight?.update(offset: remainHgt)
        
        ctTopBtm?.update(inset: ((view.frame.height - resHeight - remainHgt) / 2) - 16 )
        
        view.layoutIfNeeded()
    }
    
    deinit {
        print("--> \(self.description.flName) deinit\n")
    }
    
    override func setView(fcn: String = #function, lne: Int = #line, spot: String = #fileID) {
        super.setView(fcn: fcn, lne: lne, spot: spot)
        
        view.addSubview(containerView)
        containerView.addSubview(contTitMstView)
        containerView.addSubview(lineView)
        containerView.addSubview(tblView)
        
        contTitMstView.addSubview(scrWithTitleMsg)
        scrWithTitleMsg.addSubview(lblTitle)
        scrWithTitleMsg.addSubview(lblMsg)
        
        tblView.dataSource  = self
        tblView.delegate    = self
        
        for (i, obj) in [containerView, contTitMstView, tblView, scrWithTitleMsg, scrWithTitleMsg, lblTitle, lblMsg].enumerated() {
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.tag = i
        }
        
        containerView.alignment     = .fill
        containerView.distribution  = .fill
        containerView.axis          = .vertical
        containerView.spacing       = 0
        containerView.cornerRadi    = 15
        containerView.backgroundColor = .white
        
        lblTitle.text   = artTp.title
        lblMsg.text     = artTp.msg
        
        for (i, lbl) in [lblTitle, lblMsg].enumerated() {
            lbl.textAlignment = .center
            lbl.numberOfLines = 0
            lbl.frame.size = lbl.sizeThatFits(scrWithTitleMsg.frame.size)
            
            lbl.setContentHuggingPriority( i < 1 ? .defaultHigh : .defaultLow, for: .vertical)
        }
        
        let scrCL = scrWithTitleMsg.contentLayoutGuide
        let scrFL = scrWithTitleMsg.frameLayoutGuide
        
        containerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(view.frame.width * contV_WidthRatio)
            make.centerY.equalTo(view.snp_centerYWithinMargins)
            self.ctTopBtm = make.top.bottom.greaterThanOrEqualTo(view).inset(defMrgVti / 2).constraint
        }
        
        contTitMstView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(containerView)
            make.top.equalTo(containerView).inset(16)
            
            self.contTitMstViewHeight = make.height.equalTo(isTblHide ? viewHeight : mxHeight).priority(.required).constraint
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
        
        lineView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(containerView)
            make.bottom.equalTo(tblView.snp.top)
            make.height.equalTo(1)
        }
        
        lineView.isHidden = calcCnt < 1
        
        tblView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(containerView)
            make.top.equalTo(contTitMstView.snp.bottom).offset(isTblHide ? 0 : 16)
            make.bottom.equalTo(containerView.snp.bottom).inset(isTblHide ? 16 : 0)
            
            self.tvHeight = make.height.equalTo(tblHeightVal).priority(.required).constraint
            make.height.lessThanOrEqualTo(mnHeight).priority(.required)
        }
        
    }
    
    
    // MARK: ------------------- IBAction functions -------------------
    @objc func cellTabAct(_ sender: UIButton) {
        print("--> cellTabAct tag = \(sender.tag) / CsCodeVC\n")
        dismiss(animated: true)
    }
    
    // MARK: ------------------- function -------------------

}

// MARK: ------------------- tableView -------------------
extension CsCodeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calcCnt
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return defCellHgt
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CsCodeTVC") as! CsCodeTVC
        cell.tag = indexPath.row + 2
        cell.isDefPair = isDefPair
        cell.csCodeVC = self
        
        let idxArr = getBtnIdxs(row: indexPath.row, calc: calcCnt, total: btnTitleArr.count)
        cell.setView(btnIdxs: idxArr)
        
        return cell
    }
}


class CsCodeTVC: CommonTvc {
    weak var csCodeVC: CsCodeVC?
    
    var stvHrz: UIStackView = {
        let view = UIStackView()
        view.distribution   = .fillEqually
        view.alignment      = .center
        view.spacing        = 0
        view.axis           = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var btn0: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel?.numberOfLines = 0
        view.setTitleColor(.black, for: .normal)
        
        return view
    }()
    
    var btn1: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel?.numberOfLines = 0
        view.setTitleColor(.black, for: .normal)
        
        return view
    }()
    
    var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        
        return view
    }()
    
    var isDefPair: btnLayout = .withinZroIdx
    
    var btnTitles: [UIButton] = []
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        csCodeVC = nil
    }
    
    deinit {
        csCodeVC = nil
    }
    
    func setView(btnIdxs: (prv: Int?, nxt: Int?)?) {
        setView()
        
        btnTitles = [btn0, btn1]
        for (i, btn) in btnTitles.enumerated() {
            btn.tag = i
        }
        
        contentView.addSubview(stvHrz)
        stvHrz.addSubview(btn0)
        stvHrz.addSubview(lineView)
        stvHrz.addSubview(btn1)
        
        stvHrz.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
        }
        
        btn0.snp.makeConstraints { make in
            make.leading.top.bottom.equalTo(stvHrz)
            if btnIdxs?.nxt == nil {
                make.trailing.equalTo(stvHrz.snp.trailing)
            }
        }
        
        lineView.snp.makeConstraints { make in
            make.centerX.equalTo(stvHrz.snp.centerX)
            make.width.equalTo(1)
            make.top.bottom.equalTo(stvHrz)
        }
        
        btn1.snp.makeConstraints { make in
            make.top.bottom.equalTo(stvHrz)
            make.leading.equalTo(btn0.snp.trailing)
            make.trailing.equalTo(stvHrz.snp.trailing)
            if btnIdxs?.nxt != nil {
                make.width.equalTo(btn0.snp.width).multipliedBy(1)
            }
        }
        
        let btnBgCol: UIColor   = .clear
        let prevCol: UIColor    = .clear, nxtCol: UIColor = .clear
        
        for i in 0..<btnTitles.count {
            // 초기화
            btnTitles[i].setTitle("", for: .normal)
            
            // 버튼 정렬 분기
            switch isDefPair {
                
            case .withinZroIdx, .evenRng:
                if let idxs = btnIdxs {
                    switch i {
                    case 0:
                        if let first = idxs.prv {
                            btnTitles[i].tag = first
                            btnTitles[i].backgroundColor = prevCol
                            
                            btnTitles[i].setTitle(String(describing: first), for: .normal)
                        }
                        
                    case 1:
                        if let second = idxs.nxt {
                            btnTitles[i].tag = second
                            btnTitles[i].backgroundColor = nxtCol
                            
                            btnTitles[i].setTitle(String(describing: second), for: .normal)
                        }
                        
                        btnTitles[i].isHidden = idxs.nxt == nil
                        
                    default: break
                    }
                }
                
            case .fullSize:
                btnTitles[i].setTitle(String(describing: tag), for: .normal)
                btnTitles[i].backgroundColor = btnBgCol
                btnTitles[i].isHidden = i > 0
            }
            
            btnTitles[i].addTarget(csCodeVC, action: #selector(csCodeVC?.cellTabAct(_:)), for: .touchUpInside)
            
            lineView.isHidden = btnTitles[1].isHidden
        }
    }
}
