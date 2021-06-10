


import UIKit

extension UIStoryboard {
    static var categoryViewController: CategoryViewController {
        UIStoryboard.init(name: "Category", bundle: nil).instantiateInitialViewController() as! CategoryViewController
    }
    
    static var searchViewController: SearchViewController {
        UIStoryboard.init(name: "Search", bundle: nil).instantiateInitialViewController() as! SearchViewController
    }
    
    static var calendarViewController: CalendarViewController {
        UIStoryboard.init(name: "Calendar", bundle: nil).instantiateInitialViewController() as! CalendarViewController
    }
    
    static var titleViewController: TitleViewController {
        UIStoryboard.init(name: "Title", bundle: nil).instantiateInitialViewController() as! TitleViewController
    }
    
    static var memoViewController: MemoViewController {
        UIStoryboard.init(name: "Memo", bundle: nil).instantiateInitialViewController() as! MemoViewController
    }
    
    static var addMemoViewController: AddMemoViewController {
        UIStoryboard.init(name: "AddMemo", bundle: nil).instantiateInitialViewController() as! AddMemoViewController
    }
    
    static var addCategoryViewController: AddCategoryViewController {
        UIStoryboard.init(name: "AddCategory", bundle: nil).instantiateInitialViewController() as! AddCategoryViewController
    }
    
    static var addMemoButtonViewController: AddMemoButtonViewController {
        UIStoryboard.init(name: "AddMemoButton", bundle: nil).instantiateInitialViewController() as! AddMemoButtonViewController
    }
    
}
