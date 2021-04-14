
//新規カテゴリー追加のためのアラート

import UIKit

extension UIAlertController {
    
    //アラートの基本構築
    static func makeAlertWithTextField(title: String?, message: String?, textFieldConfig: ((UITextField) -> Void)?) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField(configurationHandler: textFieldConfig)
        
        return alert
    }
    
    //追加ボタンの設定とタップ時の処理
    func addDefaultActionWithText(textHandler: ((String) -> Void)?) -> UIAlertController {
        
        let action = UIAlertAction(title: "追加", style: .default) { [weak self] _ in
            guard let text = self?.textFields?.first?.text else {
                preconditionFailure("The Alert Controller has no text fields")
            }
            textHandler?(text)
        }
        addAction(action)
        
        return self
    }
    
    //キャンセル
    func addCancelAction() -> UIAlertController {
        
        addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        
        return self
    }
    
    //遷移
    func present(from viewController: UIViewController) {
        
        viewController.present(self, animated: true, completion: nil)
    }
}
