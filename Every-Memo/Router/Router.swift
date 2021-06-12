


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
    
    func showTitle(from: UIViewController, category: String) {
        let vc = TitleViewController.makeFromStoryboard(category: category)
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

