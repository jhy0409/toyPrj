//
//  CsXibVC.swift
//  CustomAlert
//
//  Created by inooph on 2023/08/24.
//

import UIKit

class CsXibVC: useDimBgVC {
    
    // MARK: ------------------- IBOutlets -------------------
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    var btnTitleArr: [String] = []
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var contV_titMsgHeight: NSLayoutConstraint!
    
    
    // MARK: ------------------- Variables -------------------
    var artTp: (title: String, msg: String) = ("", "")
    
    var lblTitleHeight: CGFloat = 20 {
        didSet {
            let mxHeight: CGFloat       = (view.frame.height - 20) * 0.6
            let height: CGFloat         = lblMsg.frame.maxY + 16
            
            contV_titMsgHeight.constant = height > mxHeight ? mxHeight : height
            tblHeight.constant          = CGFloat(btnTitleArr.count * 50)
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
        
        lblTitle.text = artTp.title
        lblMsg.text = artTp.msg
        
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
