//
//  NewPageView.swift
//  WeatherApp
//
//  Created by Admin on 1/1/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import UIKit

class NewPageView: UIPageViewController{
    
    
    //store your viewControllers in a lazy array
    private(set) lazy var pageViewArr:[UIViewController] = {
        return [self.newColoredViewController(color: "Red"), self.newColoredViewController(color: "Green"), self.newColoredViewController(color: "Blue")]
    }()
    
    private func newColoredViewController(color: String) ->UIViewController{
        return UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier:"\(color)ViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("pageViewController")
        dataSource = self
        
        //displays the first view controller (red)
        if let firstViewController = pageViewArr.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
}

extension NewPageView: UIPageViewControllerDataSource{

    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewArr.index(of: viewController) else {return nil}
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {return nil}
        guard pageViewArr.count > previousIndex else {return nil}
        return pageViewArr[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewArr.index(of: viewController) else {return nil}
        let nextIndex = viewControllerIndex + 1
        let pageViewArrCount = pageViewArr.count
        guard pageViewArrCount != nextIndex else {return nil}
        guard pageViewArrCount > nextIndex else {return nil}
        return pageViewArr[nextIndex]
    }
}







