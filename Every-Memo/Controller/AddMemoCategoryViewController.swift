
//カテゴリ選択

import UIKit

final class AddMemoCategoryViewController: UIViewController {
    
    
    @IBOutlet private weak var categoryTableView: UITableView!
    @IBOutlet private weak var catagoryTableViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var categoryTableViewBottom: NSLayoutConstraint!
    
    private let cellId = "categoryCell"
    private let addCellId = "addCategoryCell"
    private var operationCategory: OperationCategory!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        operationCategory = OperationCategory()
        
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
        if categoryTableViewBottom.constant >= CGFloat(0) {
            
            catagoryTableViewHeight.constant = CGFloat(categoryTableView.contentSize.height)
        }
        
        categoryTableView.reloadData()
        catagoryTableViewHeight.constant = CGFloat(categoryTableView.contentSize.height)
    }
    
    func alertAction() {
        
        UIAlertController
            .makeAlertWithTextField(title: "カテゴリーを追加", message: nil, textFieldConfig: { $0.placeholder = "新規カテゴリーを入力してください" })
            
            .addDefaultActionWithText() { [weak self] text in
                
                let newCategory = text.trimmingCharacters(in: .whitespaces)
                guard !newCategory.isEmpty else { return }
                
                if self!.operationCategory.currentCategorys.contains(newCategory) {
                    
                    return
                }
                
                self!.operationCategory.add(newCategory: text)
                self!.categoryTableView.reloadData()
                self!.catagoryTableViewHeight.constant = CGFloat(self!.categoryTableView.contentSize.height)
            }
            .addCancelAction()
            .present(from: self)
    }
}


extension AddMemoCategoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == operationCategory.currentCategorys.count {
            
            alertAction()
            
        } else {
            
            let checkPreVC = presentingViewController
            
            switch checkPreVC {
            
            case is AddMemoController:
                let preVC = presentingViewController as! AddMemoController
                preVC.category.text = operationCategory.currentCategorys[indexPath.row]
                
            case is CategoryListNavigationController:
                let preNC = presentingViewController as! CategoryListNavigationController
                let preVC = preNC.viewControllers[preNC.viewControllers.count - 1] as! MemoCheckController
                preVC.categoryLabel.text = operationCategory.currentCategorys[indexPath.row]
                
            case is SearchNavigationController:
                let preNC = presentingViewController as! SearchNavigationController
                let preVC = preNC.viewControllers[preNC.viewControllers.count - 1] as! MemoCheckController
                preVC.categoryLabel.text = operationCategory.currentCategorys[indexPath.row]
                
            case is CalenderNavigationController:
                let preNC = presentingViewController as! CalenderNavigationController
                let preVC = preNC.viewControllers[preNC.viewControllers.count - 1] as! MemoCheckController
                preVC.categoryLabel.text = operationCategory.currentCategorys[indexPath.row]
                
            default:
                break
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
}


extension AddMemoCategoryViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        operationCategory.currentCategorys.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == operationCategory.currentCategorys.count {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: addCellId, for: indexPath)
            cell.textLabel?.text = "+"
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
            cell.textLabel?.text = "\(operationCategory.currentCategorys[indexPath.row])"
            return cell
        }
    }
}
