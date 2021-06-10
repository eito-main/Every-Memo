


import UIKit

// 画面遷移を管理
final class Router {
    
    static let shared: Router = .init()
    private init() {} // ?
    
    
//    func setupTab() {
//        let firstViewController = FirstViewController()
//        firstViewController.tabBarItem = UITabBarItem(title: "tab1", image: .none, tag: 0)
//
//        let secondViewController = SecondViewController()
//        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
//
//        viewControllers = [firstViewController, secondViewController]
//    }
    private var window: UIWindow?
    func setupTab(window: UIWindow?) {
        
    }
    
    
    func showRoot(window: UIWindow?, whereWill: UIViewController) {
//        let vc = RegistrationViewController.makeFromStoryboard()
//        let nav = UINavigationController(rootViewController: vc)
//        window?.rootViewController = nav
        
//        switch whereWill {
//
//        case is CategoryViewController:
//            print("a")
//        case is SearchViewController:
//            print("i")
//        case is CalendarViewController:
//            print("u")
//        default:
//            print("e")
//        }
        
        window?.makeKeyAndVisible()
        self.window = window
    }
    
    func showCalendar(from: UIViewController) {
        let vc = FirstViewController.makeFromStoryboard()
        show(from: from, next: vc)
    }
    
    func showCalendar(from: UIViewController) {
        let vc = FirstViewController.makeFromStoryboard()
        show(from: from, next: vc)
    }
    
    func showCalendar(from: UIViewController) {
        let vc = FirstViewController.makeFromStoryboard()
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

