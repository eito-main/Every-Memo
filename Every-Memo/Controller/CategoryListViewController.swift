
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
        
        navigationSetUp()
        settingTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        operationMemo = OperationMemo()
        operationCategory = OperationCategory()
        
        if let cellHeight = cellHeight {
        tableViewHeight.constant = cellHeight * CGFloat(operationCategory.currentCategorys.count) - 1
        
        tableView.reloadData()
        }
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
    
    
    private func settingTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: cellId )
    }
    
    private func navigationSetUp() {
        
        self.navigationItem.title = "カテゴリー"
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
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
}
