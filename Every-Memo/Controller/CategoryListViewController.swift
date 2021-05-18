
//カテゴリーリスト

import UIKit

final class CategoryListViewController: UIViewController {
    
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var tableViewWidth: NSLayoutConstraint!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    private var operationCategory: OperationCategory!
    private var operationMemo: OperationMemo!
    private let cellId = "categoryListCell"
    private var cellHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        operationMemo = OperationMemo()
        operationCategory = OperationCategory()
        
        settingNavigation()
        settingTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        operationMemo = OperationMemo()
        operationCategory = OperationCategory()
        
        settingLayout()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        cellHeight = scrollView.bounds.size.height / 15
 
        tableViewHeight.constant = cellHeight * CGFloat(operationCategory.currentCategorys.count) - 1
        tableViewWidth.constant = self.view.frame.width
        
        tableView.reloadData()
    }
}


extension CategoryListViewController {
    
    private func settingLayout() {
        
        if let cellHeight = cellHeight {
        tableViewHeight.constant = cellHeight * CGFloat(operationCategory.currentCategorys.count) - 1
        
        tableView.reloadData()
        }
    }
    private func settingTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: cellId )
    }
    
    private func settingNavigation() {
        
        self.navigationItem.title = "カテゴリー"
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
    }
    
    private func settingAlert(category: String, categoryNum: Int) {
        
        let alert = UIAlertController(title: "カテゴリー削除", message: "”\(category)”に含まれるメモは全て”カテゴリー未指定”に移されますがよろしいですか？", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            
            self.operationCategory.delete(num: categoryNum)
            self.tableView.reloadData()
            
            self.tableViewHeight.constant = self.cellHeight * CGFloat(self.operationCategory.currentCategorys.count) - 1
            self.tableViewWidth.constant = self.view.frame.width
            
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


extension CategoryListViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        operationCategory.currentCategorys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CategoryCell
        cell?.categoryName.text = "\(operationCategory.currentCategorys[indexPath.row])"
        cell?.categoryCount.text = "\(operationCategory.categoryCount(currentMemo: operationMemo.currentMemos, category: operationCategory.currentCategorys[indexPath.row]))"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "TitleList", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "titleListController") as! TitleListViewController
        nextVC.category = operationCategory.currentCategorys[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if operationCategory.categoryCount(currentMemo: operationMemo.currentMemos, category: operationCategory.currentCategorys[indexPath.row]) == 0 {
            
            self.operationCategory.delete(num: indexPath.row)
            self.tableView.reloadData()
            
            self.tableViewHeight.constant = self.cellHeight * CGFloat(self.operationCategory.currentCategorys.count) - 1
            self.tableViewWidth.constant = self.view.frame.width
            
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
