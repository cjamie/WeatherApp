//
//  RedPageView.swift
//  WeatherApp
//
//  Created by Admin on 1/1/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import UIKit

class NewPageView: UIPageViewController{
    
    private(set) lazy var pageViewArr:[UIViewController] = {
        return [self.newColoredViewController(color: "Green"), self.newColoredViewController(color: "Red"), self.newColoredViewController(color: "Blue")]
    }()
    
    private func newColoredViewController(color: String) ->UIViewController{
        return UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier:"\(color)ViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        if let firstViewController = pageViewArr.first {
            setViewControllers([firstViewController], direction: .forward,animated: true, completion: nil)
        }
    }
}

extension NewPageView: UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
}







