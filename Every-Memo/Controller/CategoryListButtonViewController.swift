
//カテゴリーリスト

import UIKit

final class CategoryListButtonViewController: UIViewController {
    
    
    @IBOutlet private weak var memoButton: UIButton!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var calendarButton: UIButton!
    
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
    
    @IBAction func displayCalendar(_ sender: Any) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Calendar", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "calendarNavigation") as! CalenderNavigationController
        self.present(nextVC, animated: true, completion: nil)
    }
    
    @IBAction func displaySearch(_ sender: Any) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Search", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "searchNavigation") as! SearchNavigationController
        self.present(nextVC, animated: true, completion: nil)
    }
    
    @IBAction func displayAddMemo(_ sender: Any) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "AddMemo", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "addMemo") as! AddMemoViewController
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
}
