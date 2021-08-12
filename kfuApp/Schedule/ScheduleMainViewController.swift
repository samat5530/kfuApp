import UIKit

class ScheduleMainViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    var day = Date()
    var currentViewControllerIndex = 0
    var nextIndex = 0
    var animation = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePageViewController()
        self.title = "Расписание"
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           navigationController?.setNavigationBarHidden(true, animated: true)
       }
       
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func getStringbyDate(for date: Date, addingDay: Int) -> String {
        
        let format = DateFormatter()
        format.locale = Locale(identifier: "ru_RU")
        format.dateFormat = "EEEE, d MMM, yyyy"
        
        if addingDay == 0 {
            return format.string(from: date)
        }
        else {
            let newDate = Calendar.current.date(byAdding: Calendar.Component.day, value: addingDay, to: date)
            return format.string(from: newDate ?? Date())
        }
    }
    
    func configurePageViewController() {
            guard let pageViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: SchedulePageViewController.self)) as? SchedulePageViewController else {return}
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
        dateLabel.text = getStringbyDate(for: day, addingDay: currentViewControllerIndex)
        }
        
    func detailViewControllerAt(index: Int) -> ScheduleTableViewController? {
        
        guard let dataViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: ScheduleTableViewController.self)) as? ScheduleTableViewController else {
            return nil
        }
        dataViewController.index = index
        
        if dataViewController.index == 0 {
            dataViewController.currentDate = Date()
        }
        else
        {
            let date = Date()
            dataViewController.currentDate = Calendar.current.date(byAdding: Calendar.Component.day, value: index, to: date)
        }
        
        return dataViewController
        
    }

}

extension ScheduleMainViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if let vc = pendingViewControllers[0] as? ScheduleTableViewController {
            nextIndex = vc.index
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if finished {
            if animation == true {
                nextIndex = currentViewControllerIndex
            }
            
            if animation == false {
                animation = true
            }
        }
        if completed {
            
            currentViewControllerIndex = nextIndex
            dateLabel.text = getStringbyDate(for: day, addingDay: currentViewControllerIndex)
            animation = false

        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let dataViewController = viewController as! ScheduleTableViewController
        //guard var currentIndex = dataViewController?.index else {
        //    return nil
        //}
        var currentIndex = dataViewController.index
        
        currentIndex -= 1
        //currentViewControllerIndex = currentIndex
        //print("Инициализирован контроллер который будет до этого")
        return detailViewControllerAt(index: currentIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let dataViewController = viewController as! ScheduleTableViewController
        //guard var currentIndex = dataViewController?.index else {
        //    return nil
        //}
        var currentIndex = dataViewController.index
        //currentViewControllerIndex = currentIndex
        
        
        currentIndex += 1
        
        //print("Инициализирован контроллер который будет после этого")
        return detailViewControllerAt(index: currentIndex)
    }
}

