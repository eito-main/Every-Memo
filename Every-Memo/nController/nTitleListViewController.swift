//
////タイトルリスト
//
//import UIKit
//
//final class TitleListViewController: UIViewController {
//    
//    
//    @IBOutlet private weak var tableView: UITableView!
//    @IBOutlet private weak var tableViewHeight: NSLayoutConstraint!
//    @IBOutlet private weak var tableViewWidth: NSLayoutConstraint!
//    @IBOutlet private weak var scrollView: UIScrollView!
//    
//    private var operationMemo: OperationMemo!
//    private var cellHeight: CGFloat!
//    private let cellId = "titleListCellId"
//    private var memoList = [MemoData]()
//    private var layoutCheck = false
//    internal var category = String()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        settingTableView()
//        settingNvigation()
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        operationMemo = OperationMemo()
//        memoListUpdate()
//        tableView.reloadData()
//    }
//    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        
//        cellHeight = scrollView.bounds.size.height / 15
//        tableViewHeight.constant = cellHeight * CGFloat(memoList.count) - 1
//        tableViewWidth.constant = self.view.frame.width
//    }
//}
//
//
//extension TitleListViewController {
//    
//    
//    private func settingTableView() {
//        
//        tableView.delegate = self
//        tableView.dataSource = self
//        self.tableView.register(UINib(nibName: "TitleCell", bundle: nil), forCellReuseIdentifier: cellId )
//    }
//    
//    private func settingNvigation() {
//        
//        self.navigationItem.title = "タイトル"
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(
//            title: "",
//            style: .plain,
//            target: nil,
//            action: nil
//        )
//    }
//    
//    private func memoListUpdate() {
//        
//        memoList = []
//        
//        
//        if operationMemo.currentMemos.count == 0 {return}
//        
//        for count in 0..<operationMemo.currentMemos.count {
//            
//                if operationMemo.currentMemos[count].category == category {
//                    
//                    memoList.append(operationMemo.currentMemos[count])
//                }
//        }
//    }
//}
//
//
//extension TitleListViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        return cellHeight
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return memoList.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? TitleCell
//        cell?.titleLabel.text = "\(memoList[indexPath.row].title)"
//        
//        return cell!
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        let storyboard: UIStoryboard = UIStoryboard(name: "Memo", bundle: nil)
//        let nextVC = storyboard.instantiateViewController(withIdentifier: "memoCheckController") as! MemoViewController
//        nextVC.memoData = memoList[indexPath.row]
//        self.navigationController?.pushViewController(nextVC, animated: true)
//    }
//    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        
//        operationMemo.deleteMemo(for: memoList[indexPath.row].id)
//        memoList.remove(at: indexPath.row)
//        tableView.reloadData()
//        
//        tableViewHeight.constant = cellHeight * CGFloat(memoList.count) - 1
//        tableViewWidth.constant = self.view.frame.width
//    }
//}
