//
//  AppDelegate.swift
//  Baby Gender
//
//  Created by ... on 10/17/21.
//  Copyright © 2016 weCan. All rights reserved.
//

import UIKit
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var chineseDictionary: [String: String] = [:]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.setDictionary()
        GADMobileAds.configure(withApplicationID: "ca-app-pub-1903586528289428~8881360998")

        // Override point for customization after application launch.
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
    
    func setDictionary() {
        // Boy 0, Girl 1
        let coded =
            "001000000000" +
            "100110010011" +
            "011000000100" +
            "101111111111" +
            "010101101111" +
            "100100111001" +
            "001001010010" +
            "011010101000" +
            "100001011011" +
            "000010110100" +
            "110110101101" +
            "001101001011" +
            "101010000000" +
            "000011010111" +
            "001010010111" +
            "010110101101" +
            "101101001011" +
            "000101010010" +
            "010001001111" +
            "010111011000" +
            "111101101101" +
            "000111010010" +
            "110101010110" +
            "000100110101" +
            "111000001010" +
            "011100011100" +
            "101101001010" +
            "011011010101" +
            "011011010101" +
            "011011010101" +
            "011011010101" +
            "011011010101" +
            "011011010101" +
            "011011010101" +
            "011011010101"
        
        var age = 16
        var month = 0
        for simbol in coded.characters {
            let char = String(simbol)
            
            var gender: String = ""
            if Int(char) == 0 {
                gender = "Boy"
            } else {
                gender = "Girl"
            }
            if (month == 12) {
                age = age + 1
            }
            
            month = month%12 + 1
            let key = "\(age)\(month)"
            
            chineseDictionary[key] = gender
        }
        
    }


}

