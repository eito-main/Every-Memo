


import UIKit

class MemoViewController: UIViewController {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textTextView: UITextView!
    
    
    static func makeFromStoryboard() -> MemoViewController {
      let vc = UIStoryboard.memoViewController
      return vc
    }
    
    var addButtonItem: UIBarButtonItem?
    var num = 1
    
    override func viewDidLoad() {
            super.viewDidLoad()

        if num == 1 {
            addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
            self.navigationItem.rightBarButtonItem = addButtonItem
        }
//           // 初期設定パターン① (アイコンを使うパターン)
//          addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed(_:)))
//
//          // 初期設定パターン② （任意の名前にするパターン）
//          deleteButtonItem = UIBarButtonItem(title: "削除", style: .done, target: self, action: #selector(deleteButtonPressed(_:)))
//
//         // ナビゲーションバー にボタンを追加
//          self.navigationItem.rightBarButtonItem = addButtonItem
//          self.navigationItem.leftBarButtonItem = deleteButtonItem
      }
}

extension MemoViewController: UITextViewDelegate {
    
}
