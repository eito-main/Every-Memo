
//検索画面のクラス

import UIKit

final class SearchController: UIViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResultTableView: UITableView!
    @IBOutlet weak var searchTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var searchTableViewBottom: NSLayoutConstraint!
    
    private var operationMemo: OperationMemo!
    private var searchResult:[MemoData] = []
    private let cellId = "searchResultTableViewCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        operationMemo = OperationMemo()
        
        searchBar.delegate = self
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        
        setSearchBar()
        
        if searchTableViewBottom.constant >= CGFloat(0) {
            searchTableViewHeight.constant = CGFloat(searchResultTableView.contentSize.height)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        operationMemo = OperationMemo()
        
        searchBar.text = ""
        searchResult.removeAll()
        searchResultTableView.reloadData()
        
        if searchTableViewBottom.constant >= CGFloat(0) {
            searchTableViewHeight.constant = CGFloat(searchResultTableView.contentSize.height)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.endEditing(true)
        if operationMemo.currentMemos.count == 0 {return}
        
        if(searchBar.text != nil) {
            
            searchResult.removeAll()
            
            for count in 0...operationMemo.currentMemos.count-1 {
                
                if operationMemo.currentMemos[count].title.contains(searchBar.text!) {
                    searchResult.append(operationMemo.currentMemos[count])
                }
            }
            searchResultTableView.reloadData()
            if searchTableViewBottom.constant >= CGFloat(0) {
                
                searchTableViewHeight.constant = CGFloat(searchResultTableView.contentSize.height)
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


extension SearchController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "memoCheckController") as! MemoCheckController
        nextVC.memoData = searchResult[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}


extension SearchController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = searchResultTableView.dequeueReusableCell(withIdentifier: cellId,for: indexPath)
        cell.textLabel?.text = searchResult[indexPath.row].title
        
        return cell
    }
}
