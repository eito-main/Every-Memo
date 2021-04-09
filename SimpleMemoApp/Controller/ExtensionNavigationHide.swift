
//NavigationBarの表示非表示について

import UIKit

extension UIViewController {
    
    //NavigatioBarを隠す関数
    func hideNavigationBar(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    //NavigationBarを再び表示させる関数
    func showNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}
