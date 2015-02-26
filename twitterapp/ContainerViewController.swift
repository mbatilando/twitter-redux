//
//  ContainerViewController.swift
//  twitterapp
//
//  Created by Mari Batilando on 2/25/15.
//  Copyright (c) 2015 Mari Batilando. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
  
  @IBOutlet weak var containerView: UIView!
  
  var menuViewController: MenuViewController!
  var tweetsNavigationController: UINavigationController!
  var tweetsViewController: TweetsViewController!
  var expanded = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tweetsNavigationController = storyboard?.instantiateViewControllerWithIdentifier("TweetsNavigationController") as? UINavigationController
    view.addSubview(tweetsNavigationController.view)
    addChildViewController(tweetsNavigationController)
    tweetsNavigationController.didMoveToParentViewController(self)
    
//    tweetsViewController = storyboard?.instantiateViewControllerWithIdentifier("TweetsViewController") as? TweetsViewController
    var foo = tweetsNavigationController.viewControllers[0] as TweetsViewController
    foo.tweetsViewControllerDelegate = self
    
    menuViewController = self.storyboard?.instantiateViewControllerWithIdentifier("menuViewController") as? MenuViewController
    view.insertSubview(menuViewController.view, belowSubview: containerView)
    addChildViewController(menuViewController)
    menuViewController.didMoveToParentViewController(self)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

// MARK: - TweetsViewControllerDelegate
extension ContainerViewController: TweetsViewControllerDelegate {
  func didPan(sender: AnyObject) {
    UIView.animateWithDuration(1, animations: { () -> Void in
      if !self.expanded {
        self.expanded = true
        self.tweetsNavigationController.view.frame.origin.x += 150
      }
      }) { (completion) -> Void in
        
    }
  }
}
