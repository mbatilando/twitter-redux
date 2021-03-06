//
//  MenuViewController.swift
//  twitterapp
//
//  Created by Mari Batilando on 2/25/15.
//  Copyright (c) 2015 Mari Batilando. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate {
  func didSelectOption(option: String)
}

class MenuViewController: UIViewController {
  
  @IBOutlet private weak var profileImageView: UIImageView!
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var screenNameLabel: UILabel!
  @IBOutlet private weak var locationLabel: UILabel!
  @IBOutlet private weak var tableView: UITableView!
  
  private var options = ["Home", "Profile", "Mentions"]
  var delegate: MenuViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    
    profileImageView.setImageWithURL(User.currentUser?.profileImgURL!)
    nameLabel.text = User.currentUser?.name
    screenNameLabel.text = User.currentUser?.screenName
    locationLabel.text = User.currentUser?.location
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

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("menuCell") as UITableViewCell
    cell.textLabel?.text = options[indexPath.row]
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.delegate?.didSelectOption(options[indexPath.row])
  }
}