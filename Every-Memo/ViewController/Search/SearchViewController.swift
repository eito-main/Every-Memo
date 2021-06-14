


import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    static func makeFromStoryboard() -> SearchViewController {
      let vc = UIStoryboard.searchViewController
      return vc
    }
    
        private var operationMemo: OperationMemo!
        private var searchResult:[MemoData] = []
        private let cellId = "SearchCell"
    
        override func viewDidLoad() {
            super.viewDidLoad()
    
            operationMemo = OperationMemo()
    
            searchBar.delegate = self
    
            settingTableView()
            settingSearchBar()
        }
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
    
            operationMemo = OperationMemo()
    
            resetSearchBar()
            tableView.reloadData()
        }
    
}

extension SearchViewController {


    private func settingTableView() {

        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: "TitleCell", bundle: nil), forCellReuseIdentifier: cellId )
    }

    private func resetSearchBar() {

        searchBar.text = ""
        searchResult.removeAll()
    }

private func settingSearchBar() {

        //searchBar.backgroundImage = UIImage()
//        self.navigationItem.title = "検索"
        searchBar.placeholder = "タイトル検索"
        searchBar.autocapitalizationType = UITextAutocapitalizationType.none
    }

//    private func settingNavigation() {
//
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(
//            title: "",
//            style: .plain,
//            target: nil,
//            action: nil
//        )
//    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        searchBar.endEditing(true)

        if operationMemo.currentMemos.count == 0 {return}

        if(searchBar.text != nil) {

            searchResult.removeAll()

            for memo in operationMemo.currentMemos {

                if memo.title.contains(searchBar.text!) {
                    searchResult.append(memo)
                }
            }
            tableView.reloadData()
        }
    }
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 50
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResult.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? TitleCell
        cell?.title.text = "\(searchResult[indexPath.row].title)"
        
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        Router.shared.showMemo(from: self, flag: false, memo: searchResult[indexPath.row])
    }
}
