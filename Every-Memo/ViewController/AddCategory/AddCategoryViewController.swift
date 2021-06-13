


import UIKit

protocol AddCategoryViewControllerDelegate {
    
    func getCategoryName(category: String)
}

class AddCategoryViewController: UIViewController {
    
    private var operationCategory: OperationCategory!
    private let addCategoryCellId = "AddCategoryCell"
    private let addCategoryPlusCellId = "AddCategoryPlusCell"
    var delegate: AddCategoryViewControllerDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    static func makeFromStoryboard() -> AddCategoryViewController {
        let vc = UIStoryboard.addCategoryViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        operationCategory = OperationCategory()
        
        //settingNavigation()
        settingTableView()
    }
    
    private func settingTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: "AddCategoryCell", bundle: nil), forCellReuseIdentifier: addCategoryCellId )
        self.tableView.register(UINib(nibName: "AddCategoryPlusCell", bundle: nil), forCellReuseIdentifier: addCategoryPlusCellId )
    }
    
        private func settingAlert() {
    
            let alert = UIAlertController(title: "カテゴリーを追加", message: nil, preferredStyle: .alert)
    
            let ok = UIAlertAction(title: "追加", style: .default) { (action) in
    
                let text = alert.textFields?.first?.text
                let newCategory = text!.trimmingCharacters(in: .whitespaces)
    
                if self.operationCategory.currentCategorys.contains(newCategory) {
                    return
                }
    
                self.operationCategory.add(newCategory: text!)
                self.tableView.reloadData()
    
            }
    
            let cancel = UIAlertAction(title: "キャンセル", style: .cancel)
    
            alert.addAction(ok)
            alert.addAction(cancel)
            alert.addTextField(configurationHandler: { $0.placeholder = "新規カテゴリー名を入力してください" })
    
            present(alert, animated: true, completion: nil)
        }
}


extension AddCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        operationCategory.currentCategorys.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == operationCategory.currentCategorys.count {
            let addCell = tableView.dequeueReusableCell(withIdentifier: addCategoryPlusCellId, for: indexPath) as? AddCategoryPlusCell
            
            return addCell!
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: addCategoryCellId, for: indexPath) as? AddCategoryCell
        
        cell?.category.text = "\(operationCategory.currentCategorys[indexPath.row])"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == operationCategory.currentCategorys.count {
            settingAlert()
            return
        }
        delegate?.getCategoryName(category: operationCategory.currentCategorys[indexPath.row])
        self.navigationController?.popViewController(animated: true)
        return
    }
}
