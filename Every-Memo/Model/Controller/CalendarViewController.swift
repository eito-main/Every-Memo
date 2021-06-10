


import UIKit

class CalendarViewController: UIViewController {
    
    
    static func makeFromStoryboard() -> CalendarViewController {
      let vc = UIStoryboard.calendarViewController
      return vc
    }
}
