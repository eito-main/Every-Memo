


import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var tableView: UITableView!
    
    static func makeFromStoryboard() -> CalendarViewController {
        let vc = UIStoryboard.calendarViewController
        return vc
    }
    
    private var operationMemo: OperationMemo!
    private var displayMemo = [MemoData]()
    private let cellId = "calendarCell"
    private var selectedDate = String()
    private var today: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        today = Date()
        operationMemo = OperationMemo()
        
        self.calendar.delegate = self
        self.calendar.dataSource = self
        
        settingTableView()
        operationFormatter(date: today)
        calendar.select(today)
        changeDisplayMemo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        operationMemo = OperationMemo()
        
        calendar.select(today)
        operationFormatter(date: today)
        changeDisplayMemo()
    }
}

extension CalendarViewController {
    
    
    private func settingTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "TitleCell", bundle: nil), forCellReuseIdentifier: cellId )
    }
    
//    private func settingDarkMode() {
//
//        calendarView.appearance.titleDefaultColor = UIColor.white
//    }
    
//    private func settingNavigation() {
//
//        self.navigationItem.title = "カレンダー"
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(
//            title: "",
//            style: .plain,
//            target: nil,
//            action: nil
//        )
//    }
    
    private func operationFormatter(date: Date) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd(EEE)"
        selectedDate = formatter.string(from: date)
    }
    
    private func changeDisplayMemo() {
        
        displayMemo = [MemoData]()
        
        if operationMemo.currentMemos.count == 0 {return}
        
        for memo in operationMemo.currentMemos {
            
            if memo.date == selectedDate {
                displayMemo.append(memo)
            }
        }
        tableView.reloadData()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        operationFormatter(date: date)
        changeDisplayMemo()
    }
}


extension CalendarViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return displayMemo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? TitleCell
        cell?.title.text = "\(displayMemo[indexPath.row].title)"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        Router.shared.showMemo(from: self, flag: false, memo: displayMemo[indexPath.row])
    }
}
