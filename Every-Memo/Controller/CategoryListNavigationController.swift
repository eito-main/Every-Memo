
//カテゴリーリストナビゲーション

import UIKit
 
final class CategoryListNavigationController: UINavigationController {
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        UINavigationBar.appearance().isTranslucent = false
        navigationBar.shadowImage = UIImage()
    }
}
