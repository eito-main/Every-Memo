
//メモ内容変更画面

import UIKit

class MemoCheckController: UIViewController {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    // 編集ボタン
    var editBarButtonItem: UIBarButtonItem!
    var categoryName : String?
    private var viewModel: ViewModel!
    var editCheck = false
    var memoData: MemoData!
    
    //viewが読み込まれた後の処理
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //viewModelの初期化
        viewModel = ViewModel()
        self.navigationItem.title = "メモ"
        categoryLabel.text = memoData.category
        titleLabel.text = memoData.title
        dateLabel.text = memoData.date
        textView.text = memoData.text
        
        categoryLabel.layer.cornerRadius = 15
        categoryLabel.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        textView.layer.cornerRadius = 15
        textView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        editBarButtonItem = UIBarButtonItem(title: "編集", style: .done, target: self, action: #selector(editBarButtonTapped(_:)))
        
        self.navigationItem.rightBarButtonItems = [editBarButtonItem]
        
        if (UITraitCollection.current.userInterfaceStyle == .dark) {
            /* ダークモード時の処理 */
            categoryLabel.backgroundColor = .black
            dateLabel.backgroundColor = .black
            titleLabel.backgroundColor = .black
        }
    

    }
    
    // "編集"ボタンが押された時の処理
    @objc func editBarButtonTapped(_ sender: UIBarButtonItem) {
        
        if editCheck == false {
            
            editCheck = true
            editBarButtonItem.title = "完了"
            titleLabel.isEnabled = true
            textView.isEditable = true
            self.navigationItem.hidesBackButton = true
            isModalInPresentation = true
            
        } else {
            
            guard categoryLabel.text != nil && textView.text != nil && titleLabel.text != nil else {return}
            
            isModalInPresentation = false
            editCheck = false
            editBarButtonItem.title = "編集"
            titleLabel.isEnabled = false
            textView.isEditable = false
            memoData.category = categoryLabel.text!
            memoData.title = titleLabel.text!
            memoData.text = textView.text!
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
        if touchedLabel(touches: touches,view: categoryLabel){
            
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
        
        categoryLabel.text = categoryName
    }
    
    func updateMemo(Memo: MemoData) {
        viewModel.updateMemo(for: Memo.id, to: Memo )
    }
  
}
