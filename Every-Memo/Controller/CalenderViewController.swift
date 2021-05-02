
//カレンダ

import UIKit
import FSCalendar

final class CalenderViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollViewWidth: NSLayoutConstraint!
    @IBOutlet weak var calendarHeight: NSLayoutConstraint!
    @IBOutlet weak var calendarWidth: NSLayoutConstraint!
    
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewWidth: NSLayoutConstraint!
    
    private var operationMemo: OperationMemo!
    private var displayMemo = [MemoData]()
    private let cellId = "calenderTableViewCell"
    
    private var cellHeight: CGFloat!
    
    var selectedDate = String()
    var now: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        now = Date()
        operationMemo = OperationMemo()
        
        self.calendarView.delegate = self
        self.calendarView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        
        operationFormatter(date: now)
        
        navigationSetUp()
        calendarView.select(now)
        displayMemoChange()
        
        if (UITraitCollection.current.userInterfaceStyle == .dark) {
            darkMode()
        }
        self.tableView.register(UINib(nibName: "TitleCell", bundle: nil), forCellReuseIdentifier: cellId )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        operationMemo = OperationMemo()
        
        calendarView.select(now)
        operationFormatter(date: now)
        displayMemoChange()
    }
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        
        let safeAreaBottom = self.view.safeAreaInsets.bottom
        
        viewHeight.constant = (self.view.frame.height - safeAreaBottom) / 2
        viewWidth.constant = self.view.frame.width
        scrollViewHeight.constant = viewHeight.constant
        scrollViewWidth.constant = viewWidth.constant
        calendarHeight.constant = viewHeight.constant
        calendarWidth.constant = viewWidth.constant
        
        cellHeight = viewHeight.constant / 8
        
        tableViewHeight.constant = cellHeight * CGFloat(displayMemo.count) - 1
        tableViewWidth.constant = viewWidth.constant
        
        tableView.reloadData()
    }
}


extension CalenderViewController {
    
    
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
        let currentMemosIndexNumber = operationMemo.currentMemos.count-1
        
        if operationMemo.currentMemos.count == 0 {return}
        
        for count in 0...currentMemosIndexNumber {
            
            if operationMemo.currentMemos[count].date == selectedDate {
                displayMemo.append(operationMemo.currentMemos[count])
            }
        }
        tableView.reloadData()
        
        if let cellHeight = cellHeight {
            tableViewHeight.constant = cellHeight * CGFloat(displayMemo.count) - 1
            
            tableView.reloadData()
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        operationFormatter(date: date)
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
}


extension CalenderViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return displayMemo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? TitleCell
        cell?.titleLabel.text = "\(displayMemo[indexPath.row].title)"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Memo", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "memoCheckController") as! MemoViewController
        nextVC.memoData = displayMemo[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
