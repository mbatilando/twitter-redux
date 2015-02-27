//
//  ProfileViewController.swift
//  twitterapp
//
//  Created by Mari Batilando on 2/26/15.
//  Copyright (c) 2015 Mari Batilando. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var bannerImageView: UIImageView!
  @IBOutlet weak var searchButton: UIButton!
  @IBOutlet weak var composeButton: UIButton!
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var settingsButton: UIButton!
  @IBOutlet weak var friendsButton: UIButton!
  @IBOutlet weak var editProfileButton: UIButton!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var twitterHandleLabel: UILabel!
  @IBOutlet weak var profileDescriptionLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var websiteLabel: UILabel!
  @IBOutlet weak var tweetsCountLabel: UILabel!
  @IBOutlet weak var followerCount: UILabel!
  @IBOutlet weak var followingCountLabel: UILabel!
  @IBOutlet weak var tweetsTableView: UITableView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
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
