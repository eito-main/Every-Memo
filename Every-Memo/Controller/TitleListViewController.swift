
//タイトルリスト

import UIKit

final class TitleListViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var operationMemo: OperationMemo!
    private var cellHeight: CGFloat!
    private let cellId = "titleListCellId"
    private var memoList = [MemoData]()
    var category = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        operationMemo = OperationMemo()

        tableView.delegate = self
        tableView.dataSource = self
        
        memoListUpdate()
        navigationSetUp()
        
        self.tableView.register(UINib(nibName: "TitleCell", bundle: nil), forCellReuseIdentifier: cellId )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        operationMemo = OperationMemo()

        memoListUpdate()
        tableView.reloadData()
        
        if let cellHeight = cellHeight {
            tableViewHeight.constant = cellHeight * CGFloat(memoList.count) - 1
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        cellHeight = scrollView.bounds.size.height / 15
        
        tableView.reloadData()
 
        tableViewHeight.constant = cellHeight * CGFloat(memoList.count) - 1
        tableViewWidth.constant = self.view.frame.width
    }
}


extension TitleListViewController {
    
    
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


extension TitleListViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        memoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? TitleCell
        cell?.titleLabel.text = "\(memoList[indexPath.row].title)"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Memo", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "memoCheckController") as! MemoViewController
        nextVC.memoData = memoList[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        operationMemo.deleteMemo(for: memoList[indexPath.row].id)
        memoList.remove(at: indexPath.row)
        tableView.reloadData()
        
        tableViewHeight.constant = cellHeight * CGFloat(memoList.count) - 1
        tableViewWidth.constant = self.view.frame.width
    }
}
