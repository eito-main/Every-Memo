
//カテゴリーリストナビゲーション

import UIKit
 
final class CategoryListNavigationController: UINavigationController {
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        settingNavigation()
    }
}


extension CategoryListNavigationController {
    
    
    private func settingNavigation() {
        
        UINavigationBar.appearance().isTranslucent = false
        navigationBar.shadowImage = UIImage()
    }
}
