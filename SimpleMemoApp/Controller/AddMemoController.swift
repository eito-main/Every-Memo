
//メモ追加のクラス

import UIKit

final class AddMemoController : UIViewController {
    
    //日付の欄
    @IBOutlet weak var addDate: UILabel!
    //カテゴリーの欄
    @IBOutlet weak var ChoseCategory: UILabel!
    //タイトルの欄
    @IBOutlet weak var addTitle: UITextField!
    //テキストの欄
    @IBOutlet weak var addText: UITextView!
    
    var categoryName : String?
    private var viewModel: OperationMemo!
    //日付の一時保管
    var nowDate : String = ""
    
    //保存ボタンを押したときの処理
    @IBAction func addSaveText(_ sender: Any) {
        
        //
        guard ChoseCategory.text != nil && addTitle.text != nil && addText.text != nil && addDate.text != nil else { return }
        
        //
        if let title = addTitle.text, let text = addText.text, let category = ChoseCategory.text, let date = addDate.text {
            
            //カテゴリーの代入
            let inputCategory = category
            //タイトルの代入
            let inputTitle = title.trimmingCharacters(in: .whitespaces)
            //テキストの代入
            let inputText = text.trimmingCharacters(in: .whitespaces)
            //日付の代入
            let inputDate = date
            
            //inputTextとinputTitleが空白じゃない時以下を実行
            guard !inputText.isEmpty && !inputTitle.isEmpty else { return }
            
            viewModel.add(memo: MemoData(category: inputCategory, date: inputDate, title: inputTitle, text: inputText))
            
            //モーダル画面を閉じるメソッド
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    //×を押したときの処理
    @IBAction func addMemoCancel(_ sender: Any) {
        
        //画面を閉じるメソッド
        self.dismiss(animated: true, completion: nil)
    }
    
    //完了ボタンをタップしたときの動き
    @objc func onClickCommitButton3 (sender: UIButton) {
            if(addText.isFirstResponder){
                addText.resignFirstResponder()
               
            }
        }
    
    //viewが読み込まれた後の処理
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //プレースホルダー
        addTitle.placeholder = "タイトルを入力"
        
        //viewModelの初期化
        viewModel = OperationMemo()
        
        //開いたときの日付の取得
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_JP")
        dateFormatter.dateFormat = "yyyy/MM/dd(EEE)"
        dateFormatter.string(from: now)
        addDate.text = dateFormatter.string(from: now)
        
        
        if (UITraitCollection.current.userInterfaceStyle == .dark) {
            /* ダークモード時の処理 */
            ChoseCategory.backgroundColor = .black
            addDate.backgroundColor = .black
            addTitle.backgroundColor = .black
        }
        
                
    }
    
    //viewを表示する前に呼ばれるメソッド
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
        
        ChoseCategory.text = "カテゴリー未指定"
        if let ddd = categoryName {
            
            ChoseCategory.text = ddd
        }
        
        //navigationBarを隠すメソッド
           hideNavigationBar()
       }

    //viewを消す前に呼ばれるメソッド
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
        
        //navigationBarを表示するメソッド
           showNavigationBar()
       }
    
    //入力画面ないしkeyboardの外を押したら、キーボードを閉じる処理
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            if (addText.isFirstResponder) {
                addText.resignFirstResponder()
            }
        }
    
    func modalDidFinished(){
            
            ChoseCategory.text = categoryName
            
        }
    
}

//TextViewのデリゲート宣言
extension AddMemoController: UITextViewDelegate{
    
}



