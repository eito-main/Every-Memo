
//メモ内容変更画面

import UIKit

class MemoCheckController: UIViewController {
    
    // 編集ボタン
    var editBarButtonItem: UIBarButtonItem!
    var categoryName : String?
    
    private var viewModel: ViewModel!

    
    @IBOutlet weak var thirdCategoryLabel: UILabel!
    @IBOutlet weak var thirdTitleLabel: UITextField!
    @IBOutlet weak var thirdDateLabel: UILabel!
    @IBOutlet weak var thirdText: UITextView!
    
    var editCheck = false
    var memoData: MemoData!
    //viewが読み込まれた後の処理
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //viewModelの初期化
        viewModel = ViewModel()
        self.navigationItem.title = "メモ"
        thirdCategoryLabel.text = memoData.category
        thirdTitleLabel.text = memoData.title
        thirdDateLabel.text = memoData.date
        thirdText.text = memoData.text
        
        thirdCategoryLabel.layer.cornerRadius = 15
        thirdCategoryLabel.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        thirdText.layer.cornerRadius = 15
        thirdText.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        editBarButtonItem = UIBarButtonItem(title: "編集", style: .done, target: self, action: #selector(editBarButtonTapped(_:)))
        
        self.navigationItem.rightBarButtonItems = [editBarButtonItem]
        
       
    }
    
    // "編集"ボタンが押された時の処理
        @objc func editBarButtonTapped(_ sender: UIBarButtonItem) {
            
            if editCheck == false {
                print("【編集】ボタンが押された!")
                editCheck = true
                editBarButtonItem.title = "完了"
                thirdTitleLabel.isEnabled = true
                thirdText.isEditable = true
                self.navigationItem.hidesBackButton = true
            } else {
                print("【完了】ボタンが押された!")
                guard thirdCategoryLabel.text != nil && thirdText.text != nil && thirdTitleLabel.text != nil else {return}
                editCheck = false
                editBarButtonItem.title = "編集"
                thirdTitleLabel.isEnabled = false
                thirdText.isEditable = false
                memoData.category = thirdCategoryLabel.text!
                memoData.title = thirdTitleLabel.text!
                memoData.text = thirdText.text!
                updateMemo(Memo: memoData)
                
                if let preNC = navigationController as? CategoryListNavigationController{
                let preVC = preNC.viewControllers[preNC.viewControllers.count - 2] as! TitleListController
                preVC.editCheck(checkMemo: memoData)
                    self.navigationItem.hidesBackButton = false
                }
                
                
            }
            
            
            
        }
    override func touchesBegan(_ touches: Set<UITouch>,with event: UIEvent?){
        
        //myLabelはタッチ判定をしたいUILabel
        if touchedLabel(touches: touches,view: thirdCategoryLabel){
            
            // ①storyboardのインスタンス取得
            let storyboard: UIStoryboard = self.storyboard!
            
            if editCheck == true {
            // ②遷移先ViewControllerのインスタンス取得
            let nextView = storyboard.instantiateViewController(withIdentifier: "AddMemoChoseCategory") as! AddMemoChoseCategoryController
            
            // ③画面遷移
            self.present(nextView, animated: true, completion: nil)
                
            }
            return
        }
    }
    func touchedLabel(touches: Set<UITouch>, view:UILabel)->Bool{
       
        //全指のタッチについて処理
        for touch: AnyObject in touches {
            let t: UITouch = touch as! UITouch
            if t.view?.tag == view.tag {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    func modalDidFinished(){
            
        thirdCategoryLabel.text = categoryName
       
        }
    
    func updateMemo(Memo: MemoData) {
        viewModel.updateMemo(for: Memo.id, to: Memo )
        }

    
}
