//
//  AppDelegate.swift
//  UniNuri
//
//  Created by 김경훈 on 2023/06/07.
//

import UIKit
import Amplify
import AWSDataStorePlugin
import AWSAPIPlugin
import UserNotifications
import AWSPinpoint
import AWSCognitoAuthPlugin

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

//    var pinpoint: AWSPinpoint?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        // Notification
//        let pinpointConfiguration = AWSPinpointConfiguration.defaultPinpointConfiguration(launchOptions: launchOptions)
//        pinpointConfiguration.debug = true
//        pinpoint = AWSPinpoint(configuration: pinpointConfiguration)
//
//        registerForPushNotification()
//
//        AWSDDLog.sharedInstance.logLevel = .verbose
//        AWSDDLog.add(AWSDDTTYLogger.sharedInstance)
        
        // API 연결
        do {
            // 전송 api Plugin
            let apiPlugin = AWSAPIPlugin(modelRegistration: AmplifyModels())
            // 데이터 만드는 api Plugin
            let dataStorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
            // 인증 api Plugin
            let authPlugin  = AWSCognitoAuthPlugin()
            
            try Amplify.add(plugin: authPlugin)
            try Amplify.add(plugin: apiPlugin)
            try Amplify.add(plugin: dataStorePlugin)
            try Amplify.configure()
            print("Amplify configured with DataStore plugin")
        } catch {
            print("Failed to initialize Amplify with \(error)")
            return false
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }
    
    //MARK: Push Notification Methods
//    func registerForPushNotification(){
//        UNUserNotificationCenter.current().delegate = self
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {
//            [weak self] granted, _ in
//            
//            guard granted else{return}
//            
//            self?.getNotificationSettings()
//        })
//    }
//    
//    func getNotificationSettings(){
//        UNUserNotificationCenter.current().getNotificationSettings(completionHandler: {
//            settings in
//            print("Notification setting : \(settings)")
//            guard settings.authorizationStatus == .authorized else {return}
//            
//            DispatchQueue.main.async {
//                UIApplication.shared.registerForRemoteNotifications()
//            }
//        })
//    }
//    
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        if application.applicationState == .active{
//            let alert = UIAlertController(title: "Notification Received", message: userInfo.description, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//
//            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
//
//        }
        
//        pinpoint?.notificationManager.interceptDidReceiveRemoteNotification(userInfo, fetchCompletionHandler: completionHandler)
        
//        completionHandler(.newData)
//    }
}

//extension AppDelegate: UNUserNotificationCenterDelegate {
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void) {
//        // Handle foreground push notifications
//        pinpoint?.notificationManager.interceptDidReceiveRemoteNotification(notification.request.content.userInfo, fetchCompletionHandler: { _ in })
//
//        // Make sure to call `completionHandler`
//        // See https://developer.apple.com/documentation/usernotifications/unusernotificationcenterdelegate/1649518-usernotificationcenter for more details
//        completionHandler(.badge)
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: () -> Void)  {
//        // Handle background and closed push notifications
//        pinpoint?.notificationManager.interceptDidReceiveRemoteNotification(response.notification.request.content.userInfo, fetchCompletionHandler: { _ in })
//
//        // Make sure to call `completionHandler`
//        // See https://developer.apple.com/documentation/usernotifications/unusernotificationcenterdelegate/1649501-usernotificationcenter for more details
//        completionHandler()
//    }
//}

