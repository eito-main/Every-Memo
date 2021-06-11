


import UIKit

class AddMemoButtonViewController: UIViewController {
    

    @IBOutlet weak var container: UIView!
    
    static func makeFromStoryboard() -> AddMemoButtonViewController {
      let vc = UIStoryboard.addMemoButtonViewController
        
      return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var subViewController: UIViewController
        guard let tag = self.tabBarItem?.tag else { return }
        
        switch tag {
        case 0:
            subViewController = CategoryViewController.makeFromStoryboard()
        case 1:
            subViewController = SearchViewController.makeFromStoryboard()
        case 2:
            subViewController = CalendarViewController.makeFromStoryboard()
        default:
            subViewController = CategoryViewController.makeFromStoryboard()
        }
        
        displayContentController(content: subViewController, container: container)

    }
    
    func displayContentController(content: UIViewController, container: UIView) {
        addChild(content)
        content.view.frame = container.bounds
        container.addSubview(content.view)
        content.didMove(toParent: self)
    }
}
