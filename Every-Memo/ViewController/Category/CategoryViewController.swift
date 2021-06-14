


import UIKit


class CategoryViewController: UIViewController {
    
    static func makeFromStoryboard() -> CategoryViewController {
        let vc = UIStoryboard.categoryViewController
        return vc
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    private var operationCategory: OperationCategory!
    private var operationMemo: OperationMemo!
    private let cellId = "category"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        operationMemo = OperationMemo()
        operationCategory = OperationCategory()
        
//        settingNavigation()
        settingTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        operationMemo = OperationMemo()
        operationCategory = OperationCategory()
        tableView.reloadData()
    }
}


extension CategoryViewController {
    
    
//    private func settingNavigation() {
//
//        self.navigationItem.title = "Category"
//
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(
//            title: "",
//            style: .plain,
//            target: nil,
//            action: nil
//        )
//    }
    
    private func settingTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: cellId )
    }
    
    private func settingAlert(category: String, categoryNum: Int) {
        
        let alert = UIAlertController(title: "カテゴリー削除", message: "”\(category)”に含まれるメモは全て”カテゴリー未指定”に移されますがよろしいですか？", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            
            self.operationCategory.delete(num: categoryNum)
            self.tableView.reloadData()
            
            for count in 0..<self.operationMemo.currentMemos.count {
                
                if self.operationMemo.currentMemos[count].category == category {
                    
                    var changeMemo = self.operationMemo.currentMemos[count]
                    changeMemo.category = "カテゴリー未指定"
                    self.operationMemo.updateMemo(for: changeMemo.id, to: changeMemo)
                }
            }
            self.dismiss(animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel) { (acrion) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
}


extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        operationCategory.currentCategorys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CategoryCell
        cell?.category.text = "\(operationCategory.currentCategorys[indexPath.row])"
        cell?.count.text = "\(operationCategory.categoryCount(currentMemo: operationMemo.currentMemos, category: operationCategory.currentCategorys[indexPath.row]))"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let category = operationCategory.currentCategorys[indexPath.row]
        Router.shared.showTitle(from: self, category: category)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if operationCategory.categoryCount(currentMemo: operationMemo.currentMemos, category: operationCategory.currentCategorys[indexPath.row]) == 0 {
            
            self.operationCategory.delete(num: indexPath.row)
            self.tableView.reloadData()
            
            self.dismiss(animated: true, completion: nil)
            
            return
        }
        settingAlert(category: operationCategory.currentCategorys[indexPath.row], categoryNum: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 0 { return false }
        return true
    }
}
