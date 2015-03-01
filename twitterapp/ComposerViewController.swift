//
//  ComposerViewController.swift
//  twitterapp
//
//  Created by Mari Batilando on 2/21/15.
//  Copyright (c) 2015 Mari Batilando. All rights reserved.
//

import UIKit

class ComposerViewController: UIViewController {
  
  @IBOutlet private weak var profileImageView: UIImageView!
  @IBOutlet private weak var userRealNameLabel: UILabel!
  @IBOutlet private weak var twitterHandleLabel: UILabel!
  @IBOutlet private weak var tweetTextView: UITextView!
  @IBOutlet private weak var charCountLabel: UILabel!
  @IBOutlet private weak var tweetButton: UIButton!
  
  var tweet: Tweet?
  var replyId: Int?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    profileImageView.setImageWithURL(User.currentUser!.profileImgURL)
    profileImageView.layer.cornerRadius = 5.0
    profileImageView.clipsToBounds = true
    tweetButton.layer.cornerRadius = 5.0
    
    tweetTextView.delegate = self
    
    if tweet != nil {
      insertTwitterHandle(tweet!.user!.screenName!)
      replyId = tweet!.id
    }
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func insertTwitterHandle(handle: String) {
    tweetTextView.text = handle
    tweetTextView.delegate?.textViewDidChange!(tweetTextView)
  }
  
  @IBAction func onTweet(sender: AnyObject) {
    TwitterClient.sharedInstance.tweetWithCompletion(tweetTextView.text, replyId: replyId, completion: { (success, error) -> () in
      if success != nil {
        self.dismissViewControllerAnimated(true, completion: nil)
      } else {
        println("An error happened while posting a tweet")
      }
    })
  }
  
  @IBAction func onCancel(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
}

extension ComposerViewController: UITextViewDelegate {
  func textViewDidChange(textView: UITextView) {
    let textCount = countElements(tweetTextView.text)
    charCountLabel.text = "\(140 - textCount)"
  }
}
