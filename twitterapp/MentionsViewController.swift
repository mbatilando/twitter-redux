//
//  MentionsViewController.swift
//  twitterapp
//
//  Created by Mari Batilando on 2/28/15.
//  Copyright (c) 2015 Mari Batilando. All rights reserved.
//

import UIKit

class MentionsViewController: UIViewController {
  
  @IBOutlet private weak var mentionsTableView: UITableView!
  
  private var mentions = [Tweet]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    mentionsTableView.delegate = self
    mentionsTableView.dataSource = self
    
    TwitterClient.sharedInstance.mentionsTimeline { (tweets, error) -> () in
      if error == nil {
        self.mentions = tweets!
        self.mentionsTableView.reloadData()
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

extension MentionsViewController: UITableViewDelegate, UITableViewDataSource {
 
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = self.mentionsTableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCell
    cell.tweet = mentions[indexPath.row]
    cell.selectionStyle = UITableViewCellSelectionStyle.None
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return mentions.count
  }
}