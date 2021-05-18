
//検索画面ナビゲーション

import UIKit

final class SearchNavigationController: UINavigationController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingNavigation()
    }
}


extension SearchNavigationController {
    
    
    private func settingNavigation() {
        
        UINavigationBar.appearance().isTranslucent = false
        navigationBar.shadowImage = UIImage()
    }
}
