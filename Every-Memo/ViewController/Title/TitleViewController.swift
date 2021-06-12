


import UIKit

class TitleViewController: UIViewController {
    
    
    static func makeFromStoryboard(category: String) -> TitleViewController {
      let vc = UIStoryboard.titleViewController
        vc.category = category
      return vc
    }
    
    private var category = "カテゴリー未指定"
}
