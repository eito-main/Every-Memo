
//メモ

import UIKit

final class MemoViewController: UIViewController {
    
    
    @IBOutlet weak var memoCategory: UILabel!
    @IBOutlet weak var memoTitle: UITextField!
    @IBOutlet weak var memoDate: UILabel!
    @IBOutlet weak var memoText: UITextView!
    
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
        if (UITraitCollection.current.userInterfaceStyle == .dark) {
        darkMode()
        }
    }
    
    @objc func editButtonTapped(_ sender: UIBarButtonItem) {
        
        if edit == false {
            
            edit = true
            editButton.title = "完了"
            
            memoTitle.isEnabled = true
            memoText.isEditable = true
            self.navigationItem.hidesBackButton = true
            isModalInPresentation = true
            
        } else {
            
            guard memoText.text != nil && memoTitle.text != nil else {return}
            
            edit = false
            editButton.title = "編集"
            
            memoTitle.isEnabled = false
            memoText.isEditable = false
            self.navigationItem.hidesBackButton = false
            isModalInPresentation = false
            
            memoData.category = memoCategory.text!
            memoData.title = memoTitle.text!
            memoData.text = memoText.text!
            operationMemo.updateMemo(for: memoData.id, to: memoData)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,with event: UIEvent?){
        
        if touchedLabel(touches: touches,view: memoCategory){
            
            if edit == true {
                
                let storyboard: UIStoryboard = UIStoryboard(name: "AddMemoCategory", bundle: nil)
                let nextVC = storyboard.instantiateViewController(withIdentifier: "AddMemoChoseCategory") as! AddMemoCategoryViewController
                self.present(nextVC, animated: true, completion: nil)
                
            }
            return
        }
    }
    
    private func setMemo() {
        
        memoCategory.text = memoData.category
        memoTitle.text = memoData.title
        memoDate.text = memoData.date
        memoText.text = memoData.text
    }
    
    private func layout(){
        
        self.navigationItem.title = "メモ"
        
        memoCategory.layer.cornerRadius = 15
        memoCategory.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        memoText.layer.cornerRadius = 15
        memoText.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        editButton = UIBarButtonItem(title: "編集", style: .done, target: self, action: #selector(editButtonTapped(_:)))
        
        self.navigationItem.rightBarButtonItems = [editButton]
    }
    
    //ダークモード対応
    private func darkMode() {
            
            memoCategory.backgroundColor = .black
            memoDate.backgroundColor = .black
            memoTitle.backgroundColor = .black
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
