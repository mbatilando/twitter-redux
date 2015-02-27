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
  var profileViewController: ProfileViewController!
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
    view.insertSubview(menuViewController.view, belowSubview: tweetsNavigationController.view)
    addChildViewController(menuViewController)
    menuViewController.didMoveToParentViewController(self)
    
    profileViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ProfileViewController") as? ProfileViewController
    addChildViewController(profileViewController)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

// MARK: - TweetsViewControllerDelegate
extension ContainerViewController: TweetsViewControllerDelegate {
  
  func didTapImg(sender: UITapGestureRecognizer,  user: User) {
    profileViewController.user = user
    view.insertSubview(profileViewController.view, aboveSubview: tweetsNavigationController.view)
    profileViewController.didMoveToParentViewController(self)
  }

  func didPan(sender: UIPanGestureRecognizer) {
    var panOriginX: CGFloat = 0
    var difference: CGFloat = sender.translationInView(tweetsNavigationController.view).x

    if sender.state == UIGestureRecognizerState.Began {
      if !expanded {
        panOriginX = sender.locationInView(tweetsNavigationController.view).x
      }
    } else if sender.state == UIGestureRecognizerState.Changed {
      
      if expanded {
        switch difference {
        case -225...0:
            self.tweetsNavigationController.view.frame.origin.x = 225 + difference
        default:
          break
        }
      } else {
        switch difference {
        case 0...225:
          self.tweetsNavigationController.view.frame.origin.x = difference
        default:
          break
        }
      }
    } else if sender.state == UIGestureRecognizerState.Ended {
      
      if expanded {
        switch 225 + difference {
        case 0...175:
          UIView.animateWithDuration(0.5,
            animations: { () -> Void in
              self.tweetsNavigationController.view.frame.origin.x = panOriginX
            },
            completion: { (completion) -> Void in
              self.expanded = false
            }
          )
        case 175...999_999:
          UIView.animateWithDuration(0.5,
            animations: { () -> Void in
              self.tweetsNavigationController.view.frame.origin.x = 225
            },
            completion: { (completion) -> Void in
              self.expanded = true
            }
          )
        default:
          break
        }
      } else {
        switch difference {
        case 0...175:
          UIView.animateWithDuration(0.5,
            animations: { () -> Void in
              self.tweetsNavigationController.view.frame.origin.x = panOriginX
            },
            completion: { (completion) -> Void in
              self.expanded = false
            }
          )
        case 175...999_999:
          UIView.animateWithDuration(0.5,
            animations: { () -> Void in
              self.tweetsNavigationController.view.frame.origin.x = 225
            },
            completion: { (completion) -> Void in
              self.expanded = true
            }
          )
        default:
          break
        }
        }
      }
  }
}
