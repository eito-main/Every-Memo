


import UIKit

// 画面遷移を管理
final class Router {
    
    static let shared: Router = .init()
    private init() {}
    
    private var window: UIWindow?
    
    func setupTab(window: UIWindow?) {
        window?.rootViewController = CustomTabBarController()
        window?.makeKeyAndVisible()

        self.window = window
    }
    
    
//    func showRoot(window: UIWindow?, whereWill: UIViewController) {
////        let vc = RegistrationViewController.makeFromStoryboard()
////        let nav = UINavigationController(rootViewController: vc)
////        window?.rootViewController = nav
//
////        switch whereWill {
////
////        case is CategoryViewController:
////            print("a")
////        case is SearchViewController:
////            print("i")
////        case is CalendarViewController:
////            print("u")
////        default:
////            print("e")
////        }
//
//        window?.makeKeyAndVisible()
//        self.window = window
//    }
//
    func showCategory(from: UIViewController) {
        let vc = CategoryViewController.makeFromStoryboard()
        show(from: from, next: vc)
    }

    func showSearch(from: UIViewController) {
        let vc = SearchViewController.makeFromStoryboard()
        show(from: from, next: vc)
    }

    func showCalendar(from: UIViewController) {
        let vc = CalendarViewController.makeFromStoryboard()
        show(from: from, next: vc)
    }
    
    func showTitle(from: UIViewController) {
        let vc = TitleViewController.makeFromStoryboard()
        show(from: from, next: vc)
    }
    
    func showMemo(from: UIViewController) {
        let vc = MemoViewController.makeFromStoryboard()
        show(from: from, next: vc)
    }
    
    func showAddCategory(from: UIViewController) {
        let vc = AddCategoryViewController.makeFromStoryboard()
        show(from: from, next: vc)
    }
    
    //??
    func showAddMemoButton(from: UIViewController) {
        let vc = AddMemoButtonViewController.makeFromStoryboard()
        show(from: from, next: vc)
    }
}

private extension Router {
    func show(from: UIViewController, next: UIViewController, animated: Bool = true) {
        if let nav = from.navigationController {
            nav.pushViewController(next, animated: animated)
        } else {
            from.present(next, animated: animated, completion: nil)
        }
    }
}

