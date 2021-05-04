
//カテゴリー選択

import UIKit

protocol AddMemoCategoryViewControllerDelegate {
    
    func getCategoryName(category: String)
}

final class AddMemoCategoryViewController: UIViewController {
    
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var tableViewWidth: NSLayoutConstraint!
    
    private let cellId = "categoryCell"
    private let addCellId = "addCategoryCell"
    private let addCategory = "+"
    private var operationCategory: OperationCategory!
    private var cellHeight: CGFloat!
    
    var delegate: AddMemoCategoryViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        operationCategory = OperationCategory()
        
        settingTableView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
        cellHeight = scrollView.bounds.size.height / 15
        
        tableViewHeight.constant = cellHeight * CGFloat(operationCategory.currentCategorys.count + addCategory.count) - 1
        tableViewWidth.constant = self.view.frame.width
        
        tableView.reloadData()
    }
}


extension AddMemoCategoryViewController {
    
    
    private func settingTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: cellId )
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
                self!.tableView.reloadData()
                self!.tableViewHeight.constant = self!.cellHeight * CGFloat(self!.operationCategory.currentCategorys.count + self!.addCategory.count) - 1
            }
            .addCancelAction()
            .present(from: self)
    }
}


extension AddMemoCategoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        operationCategory.currentCategorys.count + addCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard indexPath.row != operationCategory.currentCategorys.count else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: addCellId, for: indexPath)
            cell.textLabel?.text = addCategory
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CategoryCell
        cell?.categoryName.text = "\(operationCategory.currentCategorys[indexPath.row])"
        cell?.categoryCount.text = ""
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard indexPath.row != operationCategory.currentCategorys.count else {
            
            alertAction()
            return
        }
        
        delegate?.getCategoryName(category: operationCategory.currentCategorys[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
}
