
//カレンダーのナビゲーションのクラス

import UIKit

class CalenderNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().isTranslucent = false
        // ナビゲーションバーの下部ボーダーを消す
        navigationBar.shadowImage = UIImage()
        
    }
    
}
