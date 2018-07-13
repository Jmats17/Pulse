//
//  TabBarController.swift
//  
//
//  Created by Justin Matsnev on 7/13/18.
//

import Foundation
import UIKit
import TransitionableTab


class TabBarController : UITabBarController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
}

extension TabBarController: TransitionableTab {
    

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return animateTransition(tabBarController, shouldSelect: viewController)
    }

}
