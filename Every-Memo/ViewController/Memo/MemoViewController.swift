


import UIKit

class MemoViewController: UIViewController {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textTextView: UITextView!
    
    
    static func makeFromStoryboard(flag: Bool, memo: MemoData?) -> MemoViewController {
        let vc = UIStoryboard.memoViewController
        vc.flag = flag
        vc.memo = memo
        return vc
    }
    
    var saveButton: UIBarButtonItem?
    var cancelButton: UIBarButtonItem?
    private var operationMemo: OperationMemo!
    var flag: Bool = false
    var memo: MemoData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        operationMemo = OperationMemo()
        
        if flag {
            
            let myTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MemoViewController.printA(_ :)))
            self.categoryLabel.isUserInteractionEnabled = true
            self.categoryLabel.addGestureRecognizer(myTap)
            
            getDate()
            
            titleTextField.placeholder = "タイトルを入力"
            categoryLabel.text = "カテゴリー未指定"
            
            saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonPressed(_:)))
            cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonPressed(_:)))
            self.navigationItem.rightBarButtonItem = saveButton
            self.navigationItem.leftBarButtonItem = cancelButton
        } else {
            categoryLabel.text = memo?.category
            titleTextField.text = memo?.title
            dateLabel.text = memo?.date
            textTextView.text = memo?.text
        }
    }
}

extension MemoViewController {
    
    @objc func printA(_ sender: UITapGestureRecognizer) {
        
        Router.shared.showAddCategory(from: self)
        
    }
    
    private func getDate() {
    
            let now = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_JP")
            dateFormatter.dateFormat = "yyyy/MM/dd(EEE)"
            dateFormatter.string(from: now)
            dateLabel.text = dateFormatter.string(from: now)
        }
    
    private func settingAlert(message: String) {
        
        let alert = UIAlertController(title: "Check", message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func saveButtonPressed(_ sender: UIBarButtonItem) {
        
        let inputTitle = titleTextField.text!.trimmingCharacters(in: .whitespaces)
        let inputText = textTextView.text!.trimmingCharacters(in: .whitespaces)
        
        switch (inputTitle, inputText) {
        
        case (let title, let text) where title == "" && text != "":
            settingAlert(message: "タイトルを入力してください")
            return
        case (let title, let text) where title != "" && text == "":
            settingAlert(message: "テキストを入力してください")
            return
        case (let title, let text) where title == "" && text == "":
            settingAlert(message: "タイトルとテキストを入力してください")
            return
        default:
            break
        }
        
        
        operationMemo.add(memo: MemoData(category: categoryLabel.text!, date: dateLabel.text!, title: inputTitle, text: inputText))
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelButtonPressed(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension MemoViewController: UITextViewDelegate {
}

extension MemoViewController: AddCategoryViewControllerDelegate {
    func getCategoryName(category: String) {
        categoryLabel.text = category
    }
}
