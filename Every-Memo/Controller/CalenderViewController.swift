
//カレンダ

import UIKit
import FSCalendar

final class CalenderViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var calenderTableView: UITableView!
    @IBOutlet weak var calenderTableHeight: NSLayoutConstraint!
    @IBOutlet weak var calendertableBottom: NSLayoutConstraint!
    
    private var operationMemo: OperationMemo!
    private var displayMemo = [MemoData]()
    private let cellId = "calenderTableViewCell"
    var selectedDate = String()
    var now: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        now = Date()
        operationMemo = OperationMemo()
        
        self.calendarView.delegate = self
        self.calendarView.dataSource = self
        calenderTableView.delegate = self
        calenderTableView.dataSource = self
        
        operationFormatter(date: now)
        
        navigationSetUp()
        calendarView.select(now)
        displayMemoChange()
        
        if (UITraitCollection.current.userInterfaceStyle == .dark) {
            darkMode()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
        
        operationMemo = OperationMemo()
        
        calendarView.select(now)
        operationFormatter(date: now)
        displayMemoChange()
    }
    
    private func navigationSetUp() {
        
        self.navigationItem.title = "カレンダー"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
                    title: "",
                    style: .plain,
                    target: nil,
                    action: nil
                )
    }
    
    //ダークモード対応
    private func darkMode() {
            
            calendarView.appearance.titleDefaultColor = UIColor.white
    }
    
    private func operationFormatter(date: Date) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd(EEE)"
        selectedDate = formatter.string(from: date)
    }
    
    private func displayMemoChange() {
        
        displayMemo = [MemoData]()
        
        if operationMemo.currentMemos.count == 0 {return}
        
        for count in 0...operationMemo.currentMemos.count-1 {
            
            if operationMemo.currentMemos[count].date == selectedDate {
                displayMemo.append(operationMemo.currentMemos[count])
            }
        }
        calenderTableView.reloadData()
        
        if calendertableBottom.constant >= CGFloat(0) {
            
        calenderTableHeight.constant = CGFloat(calenderTableView.contentSize.height)
        }
    }
    
    //カレンダー上で日付が選択されたときの処理
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        operationFormatter(date: date)
        displayMemoChange()
    }
}


extension CalenderViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return displayMemo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = displayMemo[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Memo", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "memoCheckController") as! MemoViewController
        nextVC.memoData = displayMemo[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
