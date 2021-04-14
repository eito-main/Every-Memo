
//検索画面からのナビゲーションのクラス

import UIKit

final class SearchNavigationController: UINavigationController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().isTranslucent = false
        navigationBar.shadowImage = UIImage()
    }
}
