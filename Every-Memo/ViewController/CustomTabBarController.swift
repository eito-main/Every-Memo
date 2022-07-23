


import UIKit

class CustomTabBarController: UITabBarController {

    private let vc1: AddMemoButtonViewController = {
        let vc = AddMemoButtonViewController.makeFromStoryboard()
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)

        return vc
    }()
    
    private let vc2: AddMemoButtonViewController = {
        let vc = AddMemoButtonViewController.makeFromStoryboard()
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        
        return vc
    }()
    
    private let vc3: AddMemoButtonViewController = {
        let vc = AddMemoButtonViewController.makeFromStoryboard()
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 2)
        
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let vcs = [vc1, vc2, vc3]
        let viewControllers = vcs.map{ UINavigationController(rootViewController: $0) }
        setViewControllers(viewControllers, animated: false)
    }
}
