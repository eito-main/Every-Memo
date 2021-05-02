
//検索画面

import UIKit

final class SearchViewController: UIViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var viewUnderScroll: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewWidth: NSLayoutConstraint!
    
    private var operationMemo: OperationMemo!
    private var searchResult:[MemoData] = []
    private var cellHeight: CGFloat! = 0
    private let cellId = "searchResultTableViewCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        operationMemo = OperationMemo()
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        setSearchBar()
        
        self.tableView.register(UINib(nibName: "TitleCell", bundle: nil), forCellReuseIdentifier: cellId )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        operationMemo = OperationMemo()
        
        searchBar.text = ""
        searchResult.removeAll()
        tableView.reloadData()
        
        if cellHeight != 0  {
            tableViewHeight.constant = cellHeight * CGFloat(searchResult.count) - 1
        }
    }
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        
        cellHeight = viewUnderScroll.frame.height / 12
        scrollViewHeight.constant = viewUnderScroll.frame.height
        scrollViewWidth.constant = viewUnderScroll.frame.width
        if cellHeight != 0  {
            tableViewHeight.constant = cellHeight * CGFloat(searchResult.count) - 1
        }
    }
}


extension SearchViewController {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.endEditing(true)
        let currentMemosIndexNumber = operationMemo.currentMemos.count-1
        
        if operationMemo.currentMemos.count == 0 {return}
        
        if(searchBar.text != nil) {
            
            searchResult.removeAll()
            
            for count in 0...currentMemosIndexNumber {
                
                if operationMemo.currentMemos[count].title.contains(searchBar.text!) {
                    searchResult.append(operationMemo.currentMemos[count])
                }
            }
            tableView.reloadData()
            
            if cellHeight != 0  {
                tableViewHeight.constant = cellHeight * CGFloat(searchResult.count) - 1
            }
        }
    }
    
    private func setSearchBar() {
        
        searchBar.backgroundImage = UIImage()
        self.navigationItem.title = "検索"
        searchBar.placeholder = "タイトル検索"
        searchBar.autocapitalizationType = UITextAutocapitalizationType.none
    }
    
    private func navigationSetUp() {
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
    }
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? TitleCell
        cell?.titleLabel.text = "\(searchResult[indexPath.row].title)"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Memo", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "memoCheckController") as! MemoViewController
        nextVC.memoData = searchResult[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
