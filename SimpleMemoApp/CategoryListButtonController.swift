
//カテゴリーListのボタンのクラス（最初の画面）

import UIKit

class CategoryListButtonController: UIViewController {
    
    //メモ追加画面を表示するボタン
    @IBOutlet weak var memoButton: UIButton!
    //検索画面を表示するボタン
    @IBOutlet weak var searchButton: UIButton!
    //カレンダー画面を表示するボタン
    @IBOutlet weak var calendarButton: UIButton!
    
    
    //viewが読み込まれた後の処理
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //各ボタンのレイアウト
        memoButton.layer.cornerRadius = 25.0
        memoButton.layer.borderWidth = 0.5
        memoButton.layer.borderColor = UIColor.black.cgColor
        searchButton.layer.cornerRadius = 25.0
        searchButton.layer.borderWidth = 0.5
        searchButton.layer.borderColor = UIColor.black.cgColor
        calendarButton.layer.cornerRadius = 25.0
        calendarButton.layer.borderWidth = 0.5
        calendarButton.layer.borderColor = UIColor.black.cgColor
        
        self.navigationItem.title = "カテゴリー"
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
       }
    

}
