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
  
  var tweets = [Tweet]()
  var user: User?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tweetsTableView.delegate = self
    tweetsTableView.dataSource = self
    tweetsTableView.rowHeight = UITableViewAutomaticDimension
    tweetsTableView.estimatedRowHeight = 80
    
    profileImageView.layer.cornerRadius = 5.0
    profileImageView.clipsToBounds = true
    profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
    profileImageView.layer.borderWidth = 2.5
    
    editProfileButton.layer.borderWidth = 1
    editProfileButton.layer.borderColor = UIColor(red: 0.67, green: 0.67, blue: 0.67, alpha: 1.0).CGColor
    editProfileButton.layer.cornerRadius = 5.0
    
    
    // TODO: Refactor for multiple users
    let params = [ "screen_name": user!.screenName! ]
    TwitterClient.sharedInstance.userTimelineWithParams(params, completion: { (tweets, error) -> () in
      if error == nil {
        self.tweets = tweets!
        self.tweetsTableView.reloadData()
      } else {
        println(error)
      }
    })
    
    if user != nil {
      setupProfile()
    }
  }
  
  override func viewDidAppear(animated: Bool) {
    setupProfile()
    let params = [ "screen_name": user!.screenName! ]
    TwitterClient.sharedInstance.userTimelineWithParams(params, completion: { (tweets, error) -> () in
      if error == nil {
        self.tweets = tweets!
        self.tweetsTableView.reloadData()
      } else {
        println(error)
      }
    })
  }
  
  func setupProfile () {
    profileImageView.setImageWithURL(user!.profileImgURL!)
    bannerImageView.setImageWithURL(user!.bannerImgURL)
    nameLabel.text = user!.name
    twitterHandleLabel.text = user!.screenName
    profileDescriptionLabel.text = user!.tagline
    locationLabel.text = user!.location
    tweetsCountLabel.text = "\(user!.tweetCount)"
    followerCount.text = "\(user!.followerCount)"
    followingCountLabel.text = "\(user!.followingCount)"
    websiteLabel.text = user!.descURL
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tweetsTableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCell
    cell.tweet = tweets[indexPath.row]
    cell.selectionStyle = UITableViewCellSelectionStyle.None
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tweets.count
  }
}
