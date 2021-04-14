
//カテゴリーListの画面（最初の画面）

import UIKit

final class CategoryListController: UIViewController {
    
    
    @IBOutlet private weak var categoryTableView: UITableView!
    @IBOutlet private weak var categoryTableViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var categoryTableViewBottom: NSLayoutConstraint!
    
    private var operationCategory: OperationCategory!
    private var operationMemo: OperationMemo!
    private let cellId = "categoryListCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        operationMemo = OperationMemo()
        operationCategory = OperationCategory()
        
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
        navigationSetUp()
        
        if categoryTableViewBottom.constant >= CGFloat(0) {
            categoryTableViewHeight.constant = CGFloat(categoryTableView.contentSize.height)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        operationMemo = OperationMemo()
        operationCategory = OperationCategory()
        
        categoryTableView.reloadData()
        
        if categoryTableViewBottom.constant >= CGFloat(0) {
            categoryTableViewHeight.constant = CGFloat(categoryTableView.contentSize.height)
        }
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


extension CategoryListController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "titleListController") as! TitleListController
        nextVC.category = operationCategory.currentCategorys[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}


extension CategoryListController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        operationCategory.currentCategorys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        cell.textLabel?.text = "\(operationCategory.currentCategorys[indexPath.row])"
        
        return cell
    }
}
