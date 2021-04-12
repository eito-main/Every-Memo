
//カテゴリーListの画面（最初の画面）

import UIKit

final class CategoryListController: UIViewController {
    
    //テーブルビュー
    @IBOutlet private weak var categoryTableView: UITableView!
    //テーブルビューの高さ
    @IBOutlet private weak var categoryTableViewHeight: NSLayoutConstraint!
    //テーブルビューのsafe area（下）からの距離
    @IBOutlet private weak var categoryTableViewBottom: NSLayoutConstraint!
    
    private var viewModel: OperationMemo!
    //UserDefaultsに保存するためのキー
//    static let categoryStoreKey = "categoryKey"
    //cellId
    private let categoryListCellId = "categoryListCell"
    //メモカテゴリーの配列（初期値あり）
    var memoCategoryList = ["カテゴリー未指定"]
    //UserDefaultsの宣言
    let ud = UserDefaults.standard
    //Idリストを一時的に補完するための変数
    var memoIdList = [String]()
    
    
    //viewが読み込まれた後の処理
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "カテゴリー"
        
        loadCategory()
        
        //viewModelの初期化
        viewModel = OperationMemo()
        
        //TableViewを使う時必ず書く
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
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
        
        if categoryTableViewBottom.constant >= CGFloat(0) {
            categoryTableViewHeight.constant = CGFloat(categoryTableView.contentSize.height)
        }
        
    }
    
    //viewを表示する前に実行される
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadCategory()
        
        //画面が再び表示された時にviewModelの値を更新（新規メモの反映）するため
        viewModel = OperationMemo()
        
        if categoryTableViewBottom.constant >= CGFloat(0) {
            categoryTableViewHeight.constant = CGFloat(categoryTableView.contentSize.height)
        }
        //何度もカテゴリーが追加されない様にするための条件
        guard memoCategoryList.count == 1 else {return}
        loadCategory()
        //モーダルが閉じられた時にtableViewを更新するためのメソッド
        viewModel = OperationMemo()
        categoryTableView.reloadData()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        memoIdList = [String]()
        
    }
    
    //カテゴリーの配列の更新をする関数
    private func loadCategory(){
        if ud.array(forKey: AddMemoChoseCategoryController.categoryStoreKey) != nil{
            
            //取得 またas!でアンラップしているのでnilじゃない時のみ
            let udMemoCategoryArray = ud.array(forKey: AddMemoChoseCategoryController.categoryStoreKey) as! [String]
            if udMemoCategoryArray.count == 0 {
                
                memoCategoryList = memoCategoryList + udMemoCategoryArray
                self.ud.set(self.memoCategoryList, forKey: AddMemoChoseCategoryController.categoryStoreKey)
            } else {
                
                memoCategoryList = udMemoCategoryArray
            }
            
            //reloadしてくれる
            categoryTableView.reloadData()
            
        }
    }
    
    
}


//UITableViewDelegateの処理
extension CategoryListController: UITableViewDelegate {
    
    
    //cellをタップしたときの処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if viewModel.currentMemos.count != 0 {
            for count in 0...viewModel.currentMemos.count-1 {
              
                if memoCategoryList[indexPath.row] == viewModel.currentMemos[count].category {
                    memoIdList.append(viewModel.currentMemos[count].id)
                    
                }
            }
        }
        
        
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "titleListController") as! TitleListController
        nextVC.memoIdList = memoIdList
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    
}


//UITableViewDataSourceの処理
extension CategoryListController: UITableViewDataSource {
    
    //表示するcellの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        memoCategoryList.count
    }
    
    //表示するcellの情報を入力する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: categoryListCellId)
        cell.textLabel?.text = "\(memoCategoryList[indexPath.row])"
        
        return cell
    }
    
    
}

