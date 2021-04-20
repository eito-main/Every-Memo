
//タイトルリスト

import UIKit

final class TitleListViewController: UIViewController {
    
    
    @IBOutlet weak var titleListTableView: UITableView!
    @IBOutlet weak var titleListTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var titleListTableViewBottom: NSLayoutConstraint!
    
    private var operationCategory: OperationCategory!
    private var operationMemo: OperationMemo!
    private let cellId = "titleListCellId"
    private var memoList = [MemoData]()
    var category = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        operationMemo = OperationMemo()
        operationCategory = OperationCategory()
        
        titleListTableView.delegate = self
        titleListTableView.dataSource = self
        
        memoListUpdate()
        navigationSetUp()
        
        if titleListTableViewBottom.constant >= CGFloat(0) {
            
            titleListTableViewHeight.constant = CGFloat(titleListTableView.contentSize.height)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        operationMemo = OperationMemo()
        operationCategory = OperationCategory()
        
        memoListUpdate()
        titleListTableView.reloadData()
        
        if titleListTableViewBottom.constant >= CGFloat(0) {
            
            titleListTableViewHeight.constant = CGFloat(titleListTableView.contentSize.height)
        }
    }
    
    private func navigationSetUp() {
        
        self.navigationItem.title = "タイトル"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
    }
    
    private func memoListUpdate() {
        
        memoList = [MemoData]()
        let currentMemosIndexNumber = operationMemo.currentMemos.count-1
        
        if operationMemo.currentMemos.count == 0 {return}
        
        for count in 0...currentMemosIndexNumber {
            
                if operationMemo.currentMemos[count].category == category {
                    
                    memoList.append(operationMemo.currentMemos[count])
                }
        }
    }
}


extension TitleListViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Memo", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "memoCheckController") as! MemoViewController
        nextVC.memoData = memoList[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        operationMemo.deleteMemo(for: memoList[indexPath.row].id)
        memoList.remove(at: indexPath.row)
        titleListTableView.reloadData()
        
        if titleListTableViewBottom.constant >= CGFloat(0) {
            
            titleListTableViewHeight.constant = CGFloat(titleListTableView.contentSize.height)
        }
    }
}


extension TitleListViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        memoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = memoList[indexPath.row].title
        
        return cell
    }
}






