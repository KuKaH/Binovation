//
//  BinovationApp.swift
//  Binovation
//
//  Created by 홍준범 on 4/8/25.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseMessaging

@main
struct BinovationApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            BinovationSplashView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    let gcmMessageIDKey = "gcm.message_id"
    
    // 앱이 켜졌을 때
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // 파이어베이스 설정
        FirebaseApp.configure()
        
        // Setting Up Notifications...
        // 원격 알림 등록
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOption: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOption,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        
        // Setting Up Cloud Messaging...
        // 메세징 델리겟
        Messaging.messaging().delegate = self
        
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    // fcm 토큰이 등록 되었을 때
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func sendTokenToServer(_ token: String) {
        guard let url = URL(string: "http://3.107.139.2/trash/device-token/") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json: [String: Any] = ["token": token]
        request.httpBody = try? JSONSerialization.data(withJSONObject: json)
        
        URLSession.shared.dataTask(with: request).resume()
    }
    
}

// Cloud Messaging...
extension AppDelegate: MessagingDelegate{
    
    // fcm 등록 토큰을 받았을 때
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        if let token = fcmToken {
            print("FCM token: \(token)")
            sendTokenToServer(token)
        }
        // Store this token to firebase and retrieve when to send message to someone...
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
    }
}

// User Notifications...[AKA InApp Notification...]

@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // 푸시 메세지가 앱이 켜져있을 때 나올떄
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                -> Void) {
        
        let userInfo = notification.request.content.userInfo
        let content = notification.request.content
        print("🔔 [Foreground] Title: \(content.title)")
        print("🔔 [Foreground] Body: \(content.body)")
        print("🔔 [Foreground] userInfo: \(content.userInfo)")
        
        if let category = userInfo["category"] as? String {
            switch category {
            case "민원":
                print("민원 알림 감지됨")
                if AppTabManager.shared.selectedAppTab == .notification,
                   NotificationTabManager.shared.selectedTab == .complaint {
                    ComplaintViewModel.shared.fetchComplaints()
                }
            case "용량":
                print("용량 감지됨")
                if AppTabManager.shared.selectedAppTab == .notification,
                   NotificationTabManager.shared.selectedTab == .push {
                    PushAlertViewModel.shared.fetchPushAlerts()
                }
        
            default:
                break
            }
        }
        completionHandler([[.banner, .badge, .sound]])
    }
    
    // 푸시메세지를 받았을 떄
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        let content = response.notification.request.content
        print("📲 [Clicked] Title: \(content.title)")
        print("📲 [Clicked] Body: \(content.body)")
        print("📲 [Clicked] userInfo: \(content.userInfo)")
        
        if let category = userInfo["category"] as? String {
            AppTabManager.shared.selectedAppTab = .notification
            switch category {
            case "민원":
                NotificationTabManager.shared.selectedTab = .complaint
            case "용량":
                NotificationTabManager.shared.selectedTab = .push
            default:
                break
            }
        }
        completionHandler()
    }
}
