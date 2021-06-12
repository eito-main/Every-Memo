//
////メモ
//
//import UIKit
//
//final class MemoViewController: UIViewController {
//    
//    
//    @IBOutlet private weak var memoCategory: UILabel!
//    @IBOutlet private weak var memoTitle: UITextField!
//    @IBOutlet private weak var memoDate: UILabel!
//    @IBOutlet private weak var memoText: UITextView!
//    
//    internal var memoData: MemoData!
//    private var editButton: UIBarButtonItem!
//    private var operationMemo: OperationMemo!
//    private var edit = false
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        operationMemo = OperationMemo()
//        
//        settingLayout()
//        settingMemo()
//        
//        if #available(iOS 13.0, *) {
//            if (UITraitCollection.current.userInterfaceStyle == .dark) {
//                settingDarkMode()
//            }
//        } else {
//            // Fallback on earlier versions
//        }
//    }
//}
//
//
//extension MemoViewController {
//    
//    
//    override func touchesBegan(_ touches: Set<UITouch>,with event: UIEvent?){
//        
//        if touchedLabel(touches: touches,view: memoCategory){
//            
//            if edit == true {
//                
//                let storyboard: UIStoryboard = UIStoryboard(name: "AddMemoCategory", bundle: nil)
//                let nextVC = storyboard.instantiateViewController(withIdentifier: "AddMemoChoseCategory") as! AddMemoCategoryViewController
//                
//                nextVC.delegate = self
//                self.present(nextVC, animated: true, completion: nil)
//                
//            }
//            return
//        }
//    }
//    
//    @objc internal func editButtonTapped(_ sender: UIBarButtonItem) {
//        
//        if edit == false {
//            
//            edit = true
//            editButton.title = "完了"
//            
//            memoTitle.isEnabled = true
//            memoText.isEditable = true
//            self.navigationItem.hidesBackButton = true
//            if #available(iOS 13.0, *) {
//                isModalInPresentation = true
//            } else {
//                // Fallback on earlier versions
//            }
//            
//        } else {
//            
//            guard memoText.text != nil && memoTitle.text != nil else {return}
//            
//            edit = false
//            editButton.title = "編集"
//            
//            memoTitle.isEnabled = false
//            memoText.isEditable = false
//            self.navigationItem.hidesBackButton = false
//            if #available(iOS 13.0, *) {
//                isModalInPresentation = false
//            } else {
//                // Fallback on earlier versions
//            }
//            
//            memoData.category = memoCategory.text!
//            memoData.title = memoTitle.text!
//            memoData.text = memoText.text!
//            operationMemo.updateMemo(for: memoData.id, to: memoData)
//        }
//    }
//    
//    private func settingMemo() {
//        
//        memoCategory.text = memoData.category
//        memoTitle.text = memoData.title
//        memoDate.text = memoData.date
//        memoText.text = memoData.text
//    }
//    
//    private func settingLayout(){
//        
//        self.navigationItem.title = "メモ"
//        
//        memoCategory.layer.cornerRadius = 15
//        memoCategory.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        
//        memoText.layer.cornerRadius = 15
//        memoText.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
//        
//        editButton = UIBarButtonItem(title: "編集", style: .done, target: self, action: #selector(editButtonTapped(_:)))
//        
//        self.navigationItem.rightBarButtonItems = [editButton]
//    }
//    
//    private func settingDarkMode() {
//        
//        memoCategory.backgroundColor = .black
//        memoDate.backgroundColor = .black
//        memoTitle.backgroundColor = .black
//    }
//    
//    internal func touchedLabel(touches: Set<UITouch>, view:UILabel) -> Bool {
//        
//        for touch: AnyObject in touches {
//            
//            let t: UITouch = touch as! UITouch
//            
//            if t.view?.tag == view.tag {
//                
//                return true
//            } else {
//                
//                return false
//            }
//        }
//        return false
//    }
//}
//
//
//extension MemoViewController: AddMemoCategoryViewControllerDelegate {
//    
//    
//    internal func getCategoryName(category: String) {
//        memoCategory.text = category
//    }
//}
