
//メモ追加画面にてカテゴリーを選択する際に使用する画面のクラス

import UIKit

class AddMemoChoseCategoryController: UIViewController {
    
    //UserDefaultsに保存するためのキー
    static let categoryStoreKey = "categoryKey"
    
    //カテゴリーリストのcellId
    private let categoryCellId = "categoryCell"
    //新規カテゴリーを追加するためのcellのcellId
    private let addCategoryCellId = "addCategoryCell"
    
    var memoCategoryArray = ["カテゴリー未指定"]
    
    //UserDefaultsの宣言
    let ud = UserDefaults.standard
    
    //カテゴリーのテーブルビュー紐付け
    @IBOutlet weak var categoryTableView: UITableView!
    //カテゴリーテーブルビューの高さ
    @IBOutlet weak var catagoryTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var categoryTableViewBottom: NSLayoutConstraint!
    
    //viewが読み込まれた後の処理
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TableViewを使う時必ず書く
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if categoryTableViewBottom.constant >= CGFloat(0) {
        catagoryTableViewHeight.constant = CGFloat(categoryTableView.contentSize.height)
        }
        
    }
    
    //viewを表示する前に実行される
    override func viewWillAppear(_ animated: Bool) {
        
        if categoryTableViewBottom.constant >= CGFloat(0) {
        catagoryTableViewHeight.constant = CGFloat(categoryTableView.contentSize.height)
        }
        //何度もカテゴリーが追加されない様にするための条件
        guard memoCategoryArray.count == 1 else {return}
        loadCategory()
    }
    
    //カテゴリーの配列の更新をする関数
    func loadCategory(){
        if ud.array(forKey: AddMemoChoseCategoryController.categoryStoreKey) != nil{
            
            //取得 またas!でアンラップしているのでnilじゃない時のみ
            var udMemoCategoryArray = ud.array(forKey: AddMemoChoseCategoryController.categoryStoreKey) as! [String]
            if udMemoCategoryArray.count == 0 {
                
                memoCategoryArray = memoCategoryArray + udMemoCategoryArray
                self.ud.set(self.memoCategoryArray, forKey: AddMemoChoseCategoryController.categoryStoreKey)
            } else {
                
                memoCategoryArray = udMemoCategoryArray
            }
            
            //reloadしてくれる
            categoryTableView.reloadData()
            catagoryTableViewHeight.constant = CGFloat(categoryTableView.contentSize.height)
        }
    }
    
    
}


//UITableViewDelegateの処理
extension AddMemoChoseCategoryController: UITableViewDelegate {
    
    
    //cellがタップされた時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //選択された行が最後の行だった場合
        if indexPath.row == memoCategoryArray.count {
            
            
            UIAlertController
                .makeAlertWithTextField(title: "Add Category", message: nil, textFieldConfig: { $0.placeholder = "Category" })
                .addDefaultActionWithText(title: "OK") { [weak self] text in
                    //空白除去
                    let inputCategory = text.trimmingCharacters(in: .whitespaces)
                    //空白の場合処理を抜ける
                    guard !inputCategory.isEmpty else { return }
                    //配列に同じ値があった場合処理を抜ける
                    if self!.memoCategoryArray.contains(inputCategory) {
                        return
                        
                    }
                    //配列に追加しuserdefaultsに保存
                    self?.memoCategoryArray.append(text)
                    self?.ud.set(self?.memoCategoryArray, forKey: AddMemoChoseCategoryController.categoryStoreKey)
                    self?.loadCategory()
                    
                }
                .addCancelAction()
                .present(from: self)
            
            return
        } else {
            
            //メモ追加画面に選択されたカテゴリー名を渡す
            if let vc = presentingViewController as? AddMemoController {
                vc.categoryName = memoCategoryArray[indexPath.row]
                vc.modalDidFinished()
            }
            
            //モーダルを閉じる
            dismiss(animated: true, completion: nil)
            
        }
    }
    
    
}

//UITableViewDataSourceの処理
extension AddMemoChoseCategoryController: UITableViewDataSource {
    
    
    //cellの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        memoCategoryArray.count + 1
    }
    
    //cellの設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //選択された行が最後の行だった場合
        if indexPath.row == memoCategoryArray.count {
            
            let addingCell = tableView.dequeueReusableCell(withIdentifier: addCategoryCellId, for: indexPath)
            addingCell.textLabel?.text = "+"
            return addingCell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: categoryCellId, for: indexPath)
            cell.textLabel?.text = "\(memoCategoryArray[indexPath.row])"
            return cell
            
        }
    }
    
    
}
