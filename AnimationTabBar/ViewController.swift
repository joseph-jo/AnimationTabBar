//
//  ViewController.swift
//  AnimationTabBar
//
//  Created by Joseph Chen on 2021/1/18.
//

import UIKit

class ViewController: UIViewController, AnimationTabBarDelegate {
    
    var tabBar: AnimationTabBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tabBar = AnimationTabBar(delegate: self)
        self.tabBar?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: AnimationTabBar.defaultHeight())
        self.tabBar?.center = self.view.center
        self.tabBar?.buttonString = ["MainStyle", "Sub1", "Sub2"]
        
        if let tabBar = self.tabBar {
            self.view.addSubview(tabBar)
        }
    }


}

extension ViewController {
    
    func onTabBarButtonClick(idx: Int) {
        
    }
    

}
