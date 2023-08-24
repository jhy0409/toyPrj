//
//  CsXibVC.swift
//  CustomAlert
//
//  Created by inooph on 2023/08/24.
//

import UIKit

class CsXibVC: useDimBgVC {
    
    // MARK: ------------------- IBOutlets -------------------
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMsg: UILabel!
    
    
    // MARK: ------------------- Variables -------------------
    var artTp: (title: String, msg: String) = ("", "")
    
    
    // MARK: ------------------- View Life Cycle -------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
