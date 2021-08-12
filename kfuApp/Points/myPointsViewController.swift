

import UIKit

class myPointsViewController: UIViewController {

    var currentId: Int = 0
    var nextIndex: Int = 0
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    var animation: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Оценки"
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        configurePageViewController()
    }
    
    func configurePageViewController() {
        guard let pageViewController = storyboard?.instantiateViewController(withIdentifier: "myPointsPVC") as? myPointsPageViewController else {
            return
        }
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        addChildViewController(pageViewController)
        pageViewController.didMove(toParentViewController: self)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(pageViewController.view)
        let views: [String:Any] = ["pageView": pageViewController.view]
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[pageView]-0-|",
                                                                  options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                  metrics: nil,
                                                                  views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[pageView]-0-|",
        options: NSLayoutConstraint.FormatOptions(rawValue: 0),
        metrics: nil,
        views: views))
        
        guard let startingViewController = detailViewControllerAt(index: 0) else {
            return
        }
        pageViewController.setViewControllers([startingViewController], direction: .forward, animated: true)
        courseLabel.text = getStringByDataSource(forId: currentId)
        
    }
    
    func getStringByDataSource(forId: Int) -> String {
        var result: String = ""
        switch forId {
        case 0:
            result = "1 курс"
        case 1:
            result = "2 курс"
        case 2:
            result = "3 курс"
        case 3:
            result = "4 курс"
        case 4:
            result = "5 курс"
        case 5:
            result = "6 курс"
        default:
            result = "Неизвестно"
        }
        return result
    }
    
    func detailViewControllerAt(index: Int) -> myPointsDataTableViewController? {
        
        guard let dataViewController = storyboard?.instantiateViewController(withIdentifier: "myPointsTVC") as? myPointsDataTableViewController else {
            return nil
        }
        dataViewController.Id = index
        
        if index >= myPoints.count || myPoints.count == 0 {
            return nil
        }
        
        if index < 0 {
            return nil
        }
        
        if index > 0 && index < 6 {
            if myPoints[index].count == 0 {
                return nil
            }
        }
        
        return dataViewController
        
    }
    
    //MARK: - Navigation bar options
    
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           navigationController?.setNavigationBarHidden(true, animated: true)
       }
       
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
}

extension myPointsViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if let vc = pendingViewControllers[0] as? myPointsDataTableViewController {
            nextIndex = vc.Id
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if finished {
            if animation == true {
                nextIndex = currentId
            }
            
            if animation == false {
                animation = true
            }
        }
        if completed {
            
            currentId = nextIndex
            courseLabel.text = getStringByDataSource(forId: currentId)
            animation = false

        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let dataViewController = viewController as! myPointsDataTableViewController
        var currentIndex = dataViewController.Id
        
        
        currentIndex -= 1
        return detailViewControllerAt(index: currentIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let dataViewController = viewController as! myPointsDataTableViewController
        var currentIndex = dataViewController.Id
    
        currentIndex += 1
        
        return detailViewControllerAt(index: currentIndex)
    }
    
}
