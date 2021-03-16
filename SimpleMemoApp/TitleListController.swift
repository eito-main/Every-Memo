
//メモ一覧画面

import UIKit

class TitleListController: UIViewController {
    
    //tableView
    @IBOutlet weak var titleListTableView: UITableView!
    //tableViewの高さ
    @IBOutlet weak var titleListTableViewHeight: NSLayoutConstraint!
    //テーブルビューのsafe area（下）からの距離
    @IBOutlet weak var titleListTableViewBottom: NSLayoutConstraint!
    
    private var viewModel: ViewModel!
    
    var memoIdList = [String]()
    var memoList = [MemoData]()
        
        
    //viewが読み込まれた後の処理
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.title = "タイトル"
        
        //viewModelの初期化
        viewModel = ViewModel()
        
        if viewModel.currentMemos.count != 0 {
        idCheck()
        }
        
        //TableViewを使う時必ず書く
        titleListTableView.delegate = self
        titleListTableView.dataSource = self
        
        //戻るボタンの設定
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
                    title: "",
                    style: .plain,
                    target: nil,
                    action: nil
                )
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if titleListTableViewBottom.constant >= CGFloat(0) {
        titleListTableViewHeight.constant = CGFloat(titleListTableView.contentSize.height)
        }
                
    }
    
    //viewを表示する前に実行される
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
        
        if titleListTableViewBottom.constant >= CGFloat(0) {
        titleListTableViewHeight.constant = CGFloat(titleListTableView.contentSize.height)
        }
       
    }
    
    func idCheck() {
        for count in 0...viewModel.currentMemos.count-1 {
            if memoIdList.count == 0 {return}
            
            for count2 in 0...memoIdList.count-1 {
                if viewModel.currentMemos[count].id == memoIdList[count2] {
                    memoList.append(viewModel.currentMemos[count])
                    
            }
        }
        }
    }
    
    //メモの削除
    func deleteMemo(forRowAt indexPath: IndexPath) {
        viewModel.deleteMemo(for: "memoList(indexPath).id")
        titleListTableView.reloadData()
    }
    
}
extension TitleListController: UITableViewDelegate{
    //cellをタップしたときの処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "memoCheckController") as! MemoCheckController
        nextVC.memoData = memoList[indexPath.row]
              self.navigationController?.pushViewController(nextVC, animated: true)

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        
        viewModel.deleteMemo(for: memoList[indexPath.row].id)
        memoList.remove(at: indexPath.row)
        

        titleListTableView.reloadData()
        if titleListTableViewBottom.constant >= CGFloat(0) {
            titleListTableViewHeight.constant = CGFloat(titleListTableView.contentSize.height)
        }

        }
    
    
}

extension TitleListController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        memoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "titleListCellId", for: indexPath)
        
        
        cell.textLabel?.text = memoList[indexPath.row].title
        return cell
    }
    
    
}


    
    
    

