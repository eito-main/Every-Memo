
//メモ内容変更画面

import UIKit

class MemoCheckController: UIViewController {
    
    @IBOutlet weak var thirdCategoryLabel: UILabel!
    @IBOutlet weak var thirdTitleLabel: UILabel!
    @IBOutlet weak var thirdDateLabel: UILabel!
    @IBOutlet weak var thirdText: UITextView!
    
    var memoData: MemoData!
    //viewが読み込まれた後の処理
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "メモ"
        thirdCategoryLabel.text = memoData.category
        thirdTitleLabel.text = memoData.title
        thirdDateLabel.text = memoData.date
        thirdText.text = memoData.text
        
        thirdCategoryLabel.layer.cornerRadius = 15
        thirdCategoryLabel.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        thirdText.layer.cornerRadius = 15
        thirdText.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        
    }
    
}
