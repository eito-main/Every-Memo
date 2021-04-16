
//メモ

import UIKit

final class MemoViewController: UIViewController {
    
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var memoData: MemoData!
    var category: String?
    private var editButton: UIBarButtonItem!
    private var operationMemo: OperationMemo!
    private var edit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        operationMemo = OperationMemo()
        
        layout()
        setMemo()
        darkMode()
    }
    
    @objc func editButtonTapped(_ sender: UIBarButtonItem) {
        
        if edit == false {
            
            edit = true
            editButton.title = "完了"
            
            titleLabel.isEnabled = true
            textView.isEditable = true
            self.navigationItem.hidesBackButton = true
            isModalInPresentation = true
            
        } else {
            
            guard textView.text != nil && titleLabel.text != nil else {return}
            
            edit = false
            editButton.title = "編集"
            
            titleLabel.isEnabled = false
            textView.isEditable = false
            self.navigationItem.hidesBackButton = false
            isModalInPresentation = false
            
            memoData.category = categoryLabel.text!
            memoData.title = titleLabel.text!
            memoData.text = textView.text!
            operationMemo.updateMemo(for: memoData.id, to: memoData)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,with event: UIEvent?){
        
        if touchedLabel(touches: touches,view: categoryLabel){
            
            if edit == true {
                
                let storyboard: UIStoryboard = UIStoryboard(name: "AddMemoCategory", bundle: nil)
                let nextVC = storyboard.instantiateViewController(withIdentifier: "AddMemoChoseCategory") as! AddMemoCategoryViewController
                self.present(nextVC, animated: true, completion: nil)
                
            }
            return
        }
    }
    
    private func setMemo() {
        
        categoryLabel.text = memoData.category
        titleLabel.text = memoData.title
        dateLabel.text = memoData.date
        textView.text = memoData.text
    }
    
    private func layout(){
        
        self.navigationItem.title = "メモ"
        
        categoryLabel.layer.cornerRadius = 15
        categoryLabel.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        textView.layer.cornerRadius = 15
        textView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        editButton = UIBarButtonItem(title: "編集", style: .done, target: self, action: #selector(editButtonTapped(_:)))
        
        self.navigationItem.rightBarButtonItems = [editButton]
    }
    
    //ダークモード対応
    private func darkMode() {
        
        if (UITraitCollection.current.userInterfaceStyle == .dark) {
            
            categoryLabel.backgroundColor = .black
            dateLabel.backgroundColor = .black
            titleLabel.backgroundColor = .black
        }
    }
    
    func touchedLabel(touches: Set<UITouch>, view:UILabel)->Bool {
        
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
}
