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
  var expanded = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tweetsNavigationController = storyboard?.instantiateViewControllerWithIdentifier("TweetsNavigationController") as? UINavigationController
    view.addSubview(tweetsNavigationController.view)
    addChildViewController(tweetsNavigationController)
    tweetsNavigationController.didMoveToParentViewController(self)
    
    menuViewController = self.storyboard?.instantiateViewControllerWithIdentifier("menuViewController") as? MenuViewController
    
    view.insertSubview(menuViewController.view, belowSubview: containerView)
    addChildViewController(menuViewController)
    menuViewController.didMoveToParentViewController(self)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onPan(sender: AnyObject) {
    UIView.animateWithDuration(1, animations: { () -> Void in
      if !self.expanded {
        self.expanded = true
        self.containerView.frame.origin.x += 150
      }
    }) { (completion) -> Void in
      
    }
  }
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}
