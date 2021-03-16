
//メモ追加のクラス

import UIKit

class AddMemoController : UIViewController {
    
    var categoryName : String?
    
    private var viewModel: ViewModel!
    
    //日付の一時保管
    var nowDate : String = ""
    
    //日付の欄
    @IBOutlet weak var addDate: UILabel!
    //カテゴリーの欄
    @IBOutlet weak var ChoseCategory: UILabel!
    //タイトルの欄
    @IBOutlet weak var addTitle: UITextField!
    //テキストの欄
    @IBOutlet weak var addText: UITextView!
    
    //カテゴリーの欄をタップしたときの処理
    @IBAction func tapLabel(_ sender: Any) {
       
    }
    
    
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
        viewModel = ViewModel()
        
        //開いたときの日付の取得
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_JP")
        dateFormatter.dateFormat = "yyyy/MM/dd(EEE)"
        dateFormatter.string(from: now)
        addDate.text = dateFormatter.string(from: now)
        
        
        //keybordの上のカスタムバー宣言
        let custombar = UIView(frame: CGRect(x:0, y:0,width:(UIScreen.main.bounds.size.width),height:40))
        
                addText.inputAccessoryView = custombar
                addText.keyboardType = .default
                addText.delegate = self

        
        ChoseCategory.layer.cornerRadius = 15
        ChoseCategory.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        addText.layer.cornerRadius = 15
        addText.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
                
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
    
    func modalDidFinished(){
            
            ChoseCategory.text = categoryName
            
        }
   
    
    
}


//TextViewのデリゲート宣言
extension AddMemoController: UITextViewDelegate{
    
}



