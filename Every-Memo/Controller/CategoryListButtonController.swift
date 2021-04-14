
//カテゴリーListのボタンのクラス（最初の画面）

import UIKit

final class CategoryListButtonController: UIViewController {
    
    
    @IBOutlet weak var memoButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var calendarButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationSetUp()
        buttonSetUp()
    }
    
    func navigationSetUp() {
        
        self.navigationItem.title = "カテゴリー"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
    }
    
    func buttonSetUp() {
        
        memoButton.layer.cornerRadius = 25.0
        memoButton.layer.borderWidth = 0.5
        memoButton.layer.borderColor = UIColor.black.cgColor
        searchButton.layer.cornerRadius = 25.0
        searchButton.layer.borderWidth = 0.5
        searchButton.layer.borderColor = UIColor.black.cgColor
        calendarButton.layer.cornerRadius = 25.0
        calendarButton.layer.borderWidth = 0.5
        calendarButton.layer.borderColor = UIColor.black.cgColor
    }
}
