//
//  NotificationViewController.swift
//  NotificationService
//
//  Created by Justin Matsnev on 7/12/18.
//  Copyright © 2018 Justin Matsnev. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
        
    }
    
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        print("handling notification")
//        if let notification = response.notification.request.content.userInfo as? [String:AnyObject] {
//            let message = parseRemoteNotification(notification: notification)
//            print(message as Any)
//        }
//        completionHandler()
//    }
//
//    private func parseRemoteNotification(notification:[String:AnyObject]) -> String? {
//        if let aps = notification["aps"] as? [String:AnyObject] {
//            let alert = aps["alert"] as? String
//            return alert
//        }
//
//        return nil
//    }
    
}
