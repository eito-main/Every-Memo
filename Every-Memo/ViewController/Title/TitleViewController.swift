


import UIKit

class TitleViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    static func makeFromStoryboard(category: String) -> TitleViewController {
        let vc = UIStoryboard.titleViewController
        vc.category = category
        return vc
    }
    
    private var operationMemo: OperationMemo!
    private var memoList = [MemoData]()
    private var category = "カテゴリー未指定"
    private let cellId = "titleCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        operationMemo = OperationMemo()
        self.tableView.register(UINib(nibName: "TitleCell", bundle: nil), forCellReuseIdentifier: cellId )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        operationMemo = OperationMemo()
        memoListUpdate(category: category)
        tableView.reloadData()
    }
}

extension TitleViewController {
    
    func memoListUpdate(category: String) {
        
        memoList = []
        for memo in operationMemo.currentMemos {
            if memo.category == category {
                memoList.append(memo)
            }
        }
    }
    
    private func settingAlert(title: String, id: String) {
        
        let alert = UIAlertController(title: "メモ削除", message: "”\(title)”を削除してよろしいですか？", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            
            self.operationMemo.deleteMemo(for: id)
            self.memoListUpdate(category: self.category)
            self.tableView.reloadData()
            
            self.dismiss(animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel) { (acrion) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
}

extension TitleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? TitleCell
        cell?.category.text = "\(memoList[indexPath.row].title)"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let category = operationCategory.currentCategorys[indexPath.row]
        Router.shared.showMemo(from: self, flag: false, memo: memoList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        settingAlert(title: memoList[indexPath.row].title, id: memoList[indexPath.row].id)
    }
}
