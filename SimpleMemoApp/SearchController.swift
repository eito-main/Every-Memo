
//検索画面のクラス

import UIKit

class SearchController: UIViewController, UISearchBarDelegate {
    
    //検索バー
    @IBOutlet weak var searchBar: UISearchBar!
    //検索結果のtableView
    @IBOutlet weak var searchResultTableView: UITableView!
    //tableViewの高さ
    @IBOutlet weak var searchTableViewHeight: NSLayoutConstraint!
    //tableViewの下からの距離
    @IBOutlet weak var searchTableViewBottom: NSLayoutConstraint!
    //viewModelの初期化
    private var viewModel: ViewModel!
    
    //検索結果配列
    var searchResult:[MemoData] = []
    
    //viewが読み込まれた後の処理
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.backgroundImage = UIImage()
        self.navigationItem.title = "検索"

        //サーチバーのセット
        setSearchBar()
        //viewModelの初期化
        viewModel = ViewModel()
        
        if viewModel.currentMemos.count == 0 {return}
        
        //TableViewを使う時必ず書く
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
                    title: "",
                    style: .plain,
                    target: nil,
                    action: nil
                )
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if searchTableViewBottom.constant >= CGFloat(0) {
        searchTableViewHeight.constant = CGFloat(searchResultTableView.contentSize.height)
        }
    }
    
    //viewを表示する前に実行される
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
        viewModel = ViewModel()
        searchBar.text = ""
        searchResult.removeAll()
        searchResultTableView.reloadData()
        
        
        if searchTableViewBottom.constant >= CGFloat(0) {
        searchTableViewHeight.constant = CGFloat(searchResultTableView.contentSize.height)
        }
        
    }
    
        //検索バーの設置
        func setSearchBar() {
            
            //デリゲート
            searchBar.delegate = self
            //プレースホルダー
            searchBar.placeholder = "タイトル検索"
            //検索バーのスタイル
            searchBar.autocapitalizationType = UITextAutocapitalizationType.none
            
        }
        
        //検索ボタン押下時の呼び出しメソッド
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.endEditing(true)
            
        if viewModel.currentMemos.count == 0 {return}
        
        if(searchBar.text != "") {
            
            //検索結果配列を空にする。
            searchResult.removeAll()
            
            //検索文字列を含むデータを検索結果配列に追加する。
            for count in 0...viewModel.currentMemos.count-1 {
                
                if viewModel.currentMemos[count].title.contains(searchBar.text!){
                    searchResult.append(viewModel.currentMemos[count])
                }
            }
            
            //テーブルを再読み込みする。
            searchResultTableView.reloadData()
            
            if searchTableViewBottom.constant >= CGFloat(0) {
            searchTableViewHeight.constant = CGFloat(searchResultTableView.contentSize.height)
            }
            
        }
    }
    
    
}


extension SearchController: UITableViewDelegate {
    
    //cellをタップしたときの処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "memoCheckController") as! MemoCheckController
        nextVC.memoData = searchResult[indexPath.row]
              self.navigationController?.pushViewController(nextVC, animated: true)

}
    
}


extension SearchController: UITableViewDataSource {
    
    //表示するcellの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResult.count
    }
    
    //表示するcellの設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = searchResultTableView.dequeueReusableCell(withIdentifier: "searchResultTableViewCellId",for: indexPath)
        
       
        
        cell.textLabel?.text = searchResult[indexPath.row].title

        return cell
    }
    
    
}

