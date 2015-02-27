//
//  User.swift
//  twitterapp
//
//  Created by Mari Batilando on 2/19/15.
//  Copyright (c) 2015 Mari Batilando. All rights reserved.
//

import UIKit


var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
  var name: String?
  var screenName: String?
  var profileImgURL: NSURL?
  var tagline: String?
  var location: String
  var dictionary: NSDictionary
  var id: Int
  var bannerImgURL: NSURL?
  var tweetCount: Int
  var followerCount: Int
  var followingCount: Int
  
  init(dictionary: NSDictionary) {
    self.dictionary = dictionary
    name = dictionary["name"] as? String
    screenName = "@" + (dictionary["screen_name"] as String)
    profileImgURL = NSURL(string: dictionary["profile_image_url"] as String + "_bigger")
    tagline = dictionary["description"] as? String
    location = dictionary["location"] as String
    id = dictionary["id"] as Int
    bannerImgURL = NSURL(string: dictionary["profile_banner_url"] as String + "/600x200")
    tweetCount = dictionary["statuses_count"] as Int
    followerCount = dictionary["friends_count"] as Int
    followingCount = dictionary["following"] as Int    
  }
  
  func logout() {
    User.currentUser = nil
    TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
    NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
  }
    
  class var currentUser: User? {
    get {
      if _currentUser == nil {
        var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
        if data != nil {
          var dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSDictionary
          _currentUser = User(dictionary: dictionary)
        }
      }
      return _currentUser
    }
    set(user) {
      _currentUser = user
      
      if _currentUser != nil {
        var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: nil, error: nil)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
      } else {
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
      }
      NSUserDefaults.standardUserDefaults().synchronize()
    }
  }
}
