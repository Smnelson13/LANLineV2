//
//  AppDelegate.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/15/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit
import SendBirdSDK
import UserNotifications
import RAMAnimatedTabBarController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
  {
    UITabBar.appearance().tintColor = UIColor.white
    UITabBar.appearance().tintColor = .white
    UITabBar.appearance().unselectedItemTintColor = .white
    UIApplication.shared.statusBarStyle = .lightContent
    let center = UNUserNotificationCenter.current()
    center.getNotificationSettings() {
      settings in
      if settings.authorizationStatus == UNAuthorizationStatus.notDetermined
      {
        center.requestAuthorization(options: [.alert, .sound, .badge]) {
          granted, error in
          if granted
          {
            print("Authorization was granted.")
          }
          else
          {
            print("Authorization was denied.")
          }
        }
      }
    }
    
    UINavigationBar.appearance().tintColor = .white
    SBDMain.initWithApplicationId("83FD6C08-7A4D-47E0-9C02-D039B37CBC98")
    SBDMain.setLogLevel(SBDLogLevel.debug)
    SBDOptions.setUseMemberAsMessageSender(true)
    
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }

  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
  {
    SBDMain.registerDevicePushToken(deviceToken, unique: true) { (status, error) in
      if error == nil {
        if status == SBDPushTokenRegistrationStatus.pending {
          
        }
        else {
          
        }
      }
      else {
        
      }
    }
  }
  
}

class TabBarController: RAMAnimatedTabBarController
{
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    self.tabBar.items?.forEach { item in
      if let image = item.image {
        item.image = image.withRenderingMode(.alwaysTemplate)
      }
    }
    
    self.tabBar.tintColor = .white
    self.tabBar.unselectedItemTintColor = .white
  }
}



