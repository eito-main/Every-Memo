


import UIKit

class MemoViewController: UIViewController {
    
    static func makeFromStoryboard() -> MemoViewController {
      let vc = UIStoryboard.memoViewController
      return vc
    }
}
