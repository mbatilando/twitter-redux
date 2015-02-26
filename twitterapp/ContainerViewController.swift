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
    
    // TODO: This is bad
    let tweetsVC = tweetsNavigationController.viewControllers[0] as TweetsViewController
    tweetsVC.tweetsViewControllerDelegate = self
    
    menuViewController = self.storyboard?.instantiateViewControllerWithIdentifier("menuViewController") as? MenuViewController
    view.insertSubview(menuViewController.view, belowSubview: containerView)
    addChildViewController(menuViewController)
    menuViewController.didMoveToParentViewController(self)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

// MARK: - TweetsViewControllerDelegate
extension ContainerViewController: TweetsViewControllerDelegate {

  func didPan(sender: UIPanGestureRecognizer) {
    var panOriginX: CGFloat = 0
    var difference: CGFloat = 0

    if sender.state == UIGestureRecognizerState.Began {
      panOriginX = sender.locationInView(tweetsNavigationController.view).x
    } else if sender.state == UIGestureRecognizerState.Changed {
      difference = sender.translationInView(tweetsNavigationController.view).x
      switch difference {
      case 1...225:
        self.tweetsNavigationController.view.frame.origin.x = difference
      default:
        println("hi")
      }
    } else if sender.state == UIGestureRecognizerState.Ended {
      difference = sender.translationInView(tweetsNavigationController.view).x
      if difference < 75 {
        UIView.animateWithDuration(1, animations: { () -> Void in
          self.tweetsNavigationController.view.frame.origin.x = panOriginX
        }, completion: { (completion) -> Void in
        })
      }
    }
  }
}
