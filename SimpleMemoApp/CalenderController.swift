
//カレンダー表示の画面のクラス

import UIKit
import FSCalendar

class CalenderController: UIViewController, FSCalendarDelegate {
    
    private var viewModel: ViewModel!
    
    var displayMemo = [MemoData]()
    var selectedDate:String = ""
    
    //カレンダー
    @IBOutlet weak var calendarView: FSCalendar!
    //カレンダーの下に配置するtableView
    @IBOutlet weak var calenderTableView: UITableView!
    //tableViewの高さ
    @IBOutlet weak var calenderTableHeight: NSLayoutConstraint!
    //tableViewの下からの距離
    @IBOutlet weak var calendertableBottom: NSLayoutConstraint!
    //viewが読み込まれた後の処理
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //viewModelの初期化
        viewModel = ViewModel()
        
        //FSCalendarの関数をViewControllerに委任する
        self.calendarView.delegate = self
        //tableViewを使う時必ず書く
        calenderTableView.delegate = self
        calenderTableView.dataSource = self
        
        let now = Date()
        let calendar = Calendar.current
        calendarView.select(now)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd(EEE)"
        selectedDate = formatter.string(from: now)
        
        displayMemoChange()
        
        self.navigationItem.title = "カレンダー"
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
                    title: "",
                    style: .plain,
                    target: nil,
                    action: nil
                )
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if calendertableBottom.constant >= CGFloat(0) {
        calenderTableHeight.constant = CGFloat(calenderTableView.contentSize.height)
        }
    }
    
    //viewを表示する前に実行される
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
        
        if calendertableBottom.constant >= CGFloat(0) {
        calenderTableHeight.constant = CGFloat(calenderTableView.contentSize.height)
        }
    }
    
    //カレンダー上で日付が選択されたときの処理
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        //表示する形式をformatterで指定
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd(EEE)"
        
        //date型からstring型へ変換
        let tapSelectedDate = formatter.string(from: date)
        selectedDate = tapSelectedDate
        
        displayMemoChange()
    }
    
    func displayMemoChange() {
        displayMemo = [MemoData]()
        
        if viewModel.currentMemos.count == 0 {return}
        
        for count in 0...viewModel.currentMemos.count-1 {
            
            if viewModel.currentMemos[count].date == selectedDate {
                displayMemo.append(viewModel.currentMemos[count])
            }
        }
       
        calenderTableView.reloadData()
        
        if calendertableBottom.constant >= CGFloat(0) {
        calenderTableHeight.constant = CGFloat(calenderTableView.contentSize.height)
        }
        
    }
    
    
    
}

//tableViewのdelegateとdataSorceの処理
extension CalenderController : UITableViewDelegate, UITableViewDataSource {
    //tableViewに表示するCellの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayMemo.count
        
    }
    //cellの設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "calenderTableViewCell", for: indexPath)
        cell.textLabel?.text = displayMemo[indexPath.row].title
        
        return cell
    }
    
        //cellをタップしたときの処理
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "memoCheckController") as! MemoCheckController
            nextVC.memoData = displayMemo[indexPath.row]
                  self.navigationController?.pushViewController(nextVC, animated: true)
    
    
        }
    
    
}

