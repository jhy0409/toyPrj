//
//  CsXibVC.swift
//  CustomAlert
//
//  Created by inooph on 2023/08/24.
//

import UIKit

class CsXibVC: useDimBgVC {
    
    // MARK: ------------------- IBOutlets -------------------
    
    @IBOutlet weak var colV: UICollectionView!
    @IBOutlet weak var cvHeight: NSLayoutConstraint!
    var btnTitleArr: [String] = []
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMsg: UILabel!
    
    @IBOutlet weak var containerView: UIStackView!
    @IBOutlet weak var ctTop: NSLayoutConstraint!
    @IBOutlet weak var ctBtm: NSLayoutConstraint!
    
    @IBOutlet weak var contV_titMsgHeight: NSLayoutConstraint!
    @IBOutlet weak var contV_WidthRatio: NSLayoutConstraint!
    
    var defCellHgt: CGFloat = 50
    lazy var tblHeightVal: CGFloat = CGFloat(btnTitleArr.count) * defCellHgt
    
    var titMsgViewFull: CGFloat = 1.0
    var titMsgViewMax: CGFloat = 0.6
    
    // MARK: ------------------- Variables -------------------
    lazy var csXViewNums: CsViewNums = .init(csWidthRatio: 0.8,
                                             defMrgVerti: view.frame.height * 0.05,
                                             tblDefRatio: tblHeightVal == 0 ? titMsgViewFull : titMsgViewMax)
    
    var artTp: (title: String, msg: String) = ("", "")
    
    var lblTitleHeight: CGFloat = 20 {
        didSet {
            let defMrgVerti: CGFloat    = csXViewNums.defMrgVerti * 2
            
            cvHeight.constant          = tblHeightVal
            
            let mxHeight: CGFloat       = (view.frame.height - defMrgVerti) * csXViewNums.tblDefRatio
            let height: CGFloat         = lblMsg.frame.maxY + 16
            
            contV_titMsgHeight.constant = height > mxHeight ? mxHeight : height
        }
    }
    
    
    // MARK: ------------------- View Life Cycle -------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 뷰 나타나고 나서 줄바꿈 된 높이 나와서 didAppear에서 세팅
        lblTitleHeight = lblTitle.frame.height
    }
    
    override func setView(fcn: String = #function, lne: Int = #line, spot: String = #fileID) {
        super.setView(fcn: fcn, lne: lne, spot: spot)
        
        let newConst = contV_WidthRatio.setConstMultiplier(csXViewNums.csWidthRatio)
        view.removeConstraint(contV_WidthRatio)
        view.addConstraint(newConst)
        view.layoutIfNeeded()
        contV_WidthRatio = newConst
        
        ctTop.constant = csXViewNums.defMrgVerti
        ctBtm.constant = csXViewNums.defMrgVerti
        
        lblTitle.text   = artTp.title
        lblMsg.text     = artTp.msg
        
    }
    
    
    // MARK: ------------------- IBAction functions -------------------
    
    
    // MARK: ------------------- function -------------------
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: ------------------- collectionView -------------------
extension CsXibVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return btnTitleArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat  = collectionView.frame.size.width / 2
        let height: CGFloat = defCellHgt
        
        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CsXibCvc", for: indexPath) as! CsXibCvc
        cell.tag = indexPath.item
        
        cell.backgroundColor = .getRainb(idx: indexPath.item)
        
        return cell
    }
    
}

class CsXibCvc: UICollectionViewCell {
    @IBOutlet weak var lbl_title: UILabel!
}

struct CsViewNums {
    /// superView 대비 뷰 너비 비율
    var csWidthRatio: CGFloat
    
    /// 기본 컨테이너 뷰 상하 마진
    var defMrgVerti: CGFloat
    
    var tblDefRatio: CGFloat
}

