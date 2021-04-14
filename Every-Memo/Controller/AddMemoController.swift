
//メモ追加のクラス

import UIKit

final class AddMemoController : UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var memoTitle: UITextField!
    @IBOutlet weak var memoText: UITextView!
    
    var categoryName : String?
    private var operationMemo: OperationMemo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        operationMemo = OperationMemo()
        
        darkMode()
        getDate()
        
        memoTitle.placeholder = "タイトルを入力"
        category.text = "カテゴリー未指定"
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //keyboardの外を押したら、キーボードを閉じる処理
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if (memoText.isFirstResponder) {
            memoText.resignFirstResponder()
        }
    }
    
    @IBAction func saveMemo(_ sender: Any) {
        
        guard memoTitle.text != nil && memoText.text != nil && date.text != nil else { return }
        
        let inputTitle = memoTitle.text!.trimmingCharacters(in: .whitespaces)
        let inputText = memoText.text!.trimmingCharacters(in: .whitespaces)
        
        guard !inputText.isEmpty && !inputTitle.isEmpty else { return }
        
        operationMemo.add(memo: MemoData(category: category.text!, date: date.text!, title: inputTitle, text: inputText))
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelEdit(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //ダークモード対応
    func darkMode(){
        
        if (UITraitCollection.current.userInterfaceStyle == .dark) {
            
            category.backgroundColor = .black
            date.backgroundColor = .black
            memoTitle.backgroundColor = .black
        }
    }
    
    func getDate() {
        
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_JP")
        dateFormatter.dateFormat = "yyyy/MM/dd(EEE)"
        dateFormatter.string(from: now)
        date.text = dateFormatter.string(from: now)
    }
}
