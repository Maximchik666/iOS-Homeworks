//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Maksim Kruglov on 17.02.2023.
//

import Foundation
import UserNotifications
import UIKit

class LocalNotificationsService:NSObject, UNUserNotificationCenterDelegate {
    
    func registerForLatestUpdatesIfPossible() {
        
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .provisional]) { sucess, error in
            print(sucess)
            if let error = error {
                print(error)
            }
        }
        
        registerUpdatesCategory()
        
        let content = UNMutableNotificationContent()
        content.title = "Посмотрите последние обновления!"
        content.body = "Возможно, там есть что-то новенькое!"
        content.sound = .default
        content.badge = (UIApplication.shared.applicationIconBadgeNumber + 1) as NSNumber
        content.categoryIdentifier = "updates"
        
        
        var dateComponent = DateComponents()
        dateComponent.hour = 18
        dateComponent.minute = 02
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    private func registerUpdatesCategory() {
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let someAction = UNNotificationAction(identifier: "someAction", title: "Действие")
        let someActionCategory = UNNotificationCategory(identifier: "updates", actions: [someAction], intentIdentifiers: [])
        
        let categories: Set<UNNotificationCategory> = [someActionCategory]
        center.setNotificationCategories(categories)
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        switch response.actionIdentifier {

        case "someAction": print ("Удачное нажатие на кнопочку! Поздравдяем!")
        default: print ("Косяк")
        }
        
        completionHandler()
    }
}
