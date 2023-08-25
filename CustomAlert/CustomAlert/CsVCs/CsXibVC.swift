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
    
    @IBOutlet weak var containerView: UIStackView!
    @IBOutlet weak var ctTop: NSLayoutConstraint!
    @IBOutlet weak var ctBtm: NSLayoutConstraint!
    
    @IBOutlet weak var contV_titMsgHeight: NSLayoutConstraint!
    @IBOutlet weak var contV_WidthRatio: NSLayoutConstraint!
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
    // MARK: ------------------- Variables -------------------
    var isDefPair: btnLayout = .withinZroIdx
    var btnTitleArr: [String] = []
    
    var calcCnt: Int {
        let cnt = btnTitleArr.count
        switch isDefPair {

        case .withinZroIdx:
            switch btnTitleArr.count {
            case 0: return 0
            case 1...2: return 1
            default: return cnt
            }
            
        case .evenRng:
            return (btnTitleArr.count / 2) + (cnt % 2 == 0 ? 0 : 1)
            
        case .fullSize:
            return cnt
        }
    }
    
    var defCellHgt: CGFloat = 50
    lazy var tblHeightVal: CGFloat = CGFloat(calcCnt) * defCellHgt
    
    var titMsgViewFull: CGFloat = 1.0
    var titMsgViewMax: CGFloat = 0.6
    
    lazy var csXViewNums: CsViewNums = .init(csWidthRatio: 0.8,
                                             defMrgVerti: view.frame.height * 0.05,
                                             tblDefRatio: tblHeightVal == 0 ? titMsgViewFull : titMsgViewMax)
    
    var artTp: (title: String, msg: String) = ("", "")
    
    var lblTitleHeight: CGFloat = 20 {
        willSet {
            let defMrgVerti: CGFloat    = csXViewNums.defMrgVerti * 2
            let viewHeight: CGFloat     = view.frame.height - defMrgVerti
            
            let mxHeight: CGFloat       = viewHeight * csXViewNums.tblDefRatio
            let height: CGFloat         = lblMsg.frame.maxY + 16
            
            contV_titMsgHeight.constant = height > mxHeight ? mxHeight : height
            
            let remainHgt: CGFloat      = viewHeight - contV_titMsgHeight.constant
            tvHeight.constant           = remainHgt - tblHeightVal < 0 ? remainHgt : tblHeightVal
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
    /**
     - total    : 0, 1, 2
     - calc     : 0, 1
     - row      : 0, 1
  
     1. withinZroIdx
        1. 2개까지는 0번째 [0, 1] 정렬
        2. 2개 초과시 fullSize 사용
     
     2. evenRange : 버튼개수가 짝수일 때는 [n, n+1], 홀수인 줄에서는 [n]으로 표시
         - 0 - 0, 1
         - 1 - 2, 3
         - 2 - 4, 5
         - 3 - 6
     
     3. fullSize : 버튼영역 전체 채우기
     */
    func getBtnIdxs(row: Int, calc: Int, total: Int) -> (prv: Int?, nxt: Int?)? {
        print("\n--> row = \(row) /  calc = \(calc) /  total = \(total)")
        
        var res: (prv: Int?, nxt: Int?) = (nil, nil)
        
        switch isDefPair {
        case .withinZroIdx:
            switch total {
            case 0: break
                
            case 1: // 0
                res = (prv: total - 1, nxt: nil)
                
            case 2: // 0, 1
                res = (prv: total - 2, nxt: total - 1)
                
            default:
                switch total {
                case 0: break
                case 1: res = (total - 1, nil)
                case 2: res = (total - 2, total - 1)
                default: res = (row, nil)
                }
            }
       
        case .evenRng:
            switch total {
            case 0: break
            case 1:
                res = (total - 1, nil)
                
            default:
                let prvIx: Int  = 2 * row
                let nxtIx: Int? = (prvIx + 1) > (total - 1) ? nil : (prvIx + 1)
                res = (prvIx, nxtIx)
            }
            
        case .fullSize: return nil
        }
        
        print("\(res)")
        
        return res
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: ------------------- tableView -------------------
extension CsXibVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return calcCnt
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CsXibTvc", for: indexPath) as! CsXibTvc
        cell.backgroundColor    = .getRainb(idx: indexPath.row)
        cell.tag                = indexPath.row
        cell.isLast             = cell.tag == (btnTitleArr.count - 1)
        cell.isDefPair          = isDefPair
        
        let idxArr = getBtnIdxs(row: indexPath.row, calc: calcCnt, total: btnTitleArr.count)
        
        cell.setView(btnIdxs: idxArr)
        
        return cell
    }
}

// MARK: ------------------- cell class -------------------
class CsXibTvc: CommonTvc {
    @IBOutlet var btnTitles: [UIButton]!
    
    var isDefPair: btnLayout = .withinZroIdx
    var isLast: Bool = false
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setView(fcn: String = #function, lne: Int = #line, spot: String = #fileID) {
        super.setView(fcn: fcn, lne: lne, spot: spot)
    }
    
    func setView(btnIdxs: (prv: Int?, nxt: Int?)?) {
        setView()
        
        var btnBgCol: UIColor   = .clear
        let prevCol: UIColor    = .red.withAlphaComponent(0.3)
        let nxtCol: UIColor     = .blue.withAlphaComponent(0.3)
        
        
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
        }
        
        
    }
    
}


// MARK: ------------------- struct & enum -------------------
struct CsViewNums {
    /// superView 대비 뷰 너비 비율
    var csWidthRatio: CGFloat
    
    /// 기본 컨테이너 뷰 상하 마진
    var defMrgVerti: CGFloat
    
    var tblDefRatio: CGFloat
}

enum btnLayout: String {
    /**
     index 0번째만 두 칸 사용
     
     1. 0, 1, 2
     
     2. index
     - 0 : 0, 1
     - 1 : 2 ...
     */
    case withinZroIdx = "iOS기본 스타일"
    
    /// 짝수는 두 칸, 남은 인덱스가 홀수일 경우 한 칸
    case evenRng = "바둑판 배열"
    
    /// 셀 가득 채우기
    case fullSize = "채우기"
}
