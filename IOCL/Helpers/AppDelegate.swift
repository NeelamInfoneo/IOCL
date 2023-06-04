//
//  AppDelegate.swift
//  IOCL
//
//  Created by infoneo on 19/12/22.
//

import UIKit
import IQKeyboardManagerSwift
import SideMenu
import KRProgressHUD
import Firebase
import FirebaseMessaging
import UserNotifications
import FirebaseCore
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    var window: UIWindow?
    let orientationLock = UIInterfaceOrientationMask.portrait
    var deviceID = String()
    var fcmToken = String()
    var FCMtoken = String()
    var strDeviceToken: String = ""

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        /// IQKEYBOARD ENABLE
        IQKeyboardManager.shared.enable = true
        
        // MARK: Firebase SetUp
        // MARK: Messaging Delagte.................................
     
        self.registerForNotification()
               FirebaseApp.configure()
               Messaging.messaging().delegate = self
        if let uuid = UIDevice.current.identifierForVendor?.uuidString {
            print(uuid)
            self.deviceID = uuid
        }
        setUpRoot()
        KRProgressHUD.set(activityIndicatorViewColors: [.appColor(.themeColor)])
        return true
    }
}

//MARK: -FUNCTION FOR SET ROOT VC OR HOME VC-
extension AppDelegate {
    
    func setUpRoot(){
        if kUserDefaults.retriveBool(.isLoggedIn) == true {
            setHomeTabVC()
        }else {
            setAppRootVC()
        }
    }
    @objc
    func setAppRootVC() {
        let vc = OnbordingVC.instantiate(fromAppStoryboard: .Main)
        let rootNC = UINavigationController(rootViewController: vc)
        rootNC.navigationBar.isHidden = true
        window?.rootViewController = rootNC
        window?.makeKeyAndVisible()
    }
    func setLogutVC() {
        let vc = OnbordingVC.instantiate(fromAppStoryboard: .Main)
        let rootNC = UINavigationController(rootViewController: vc)
        rootNC.navigationBar.isHidden = true
        window?.rootViewController = rootNC
        window?.makeKeyAndVisible()
        kUserDefaults.removeFromDefault(.Token)
        UserDefaults.standard.removeObject(forKey: "IsApproverAdmin")
        UserDefaults.standard.removeObject(forKey: "IsHRSurveyAdmin")
        UserDefaults.standard.removeObject(forKey: "IsCarRequestAdmin")
        UserDefaults.standard.removeObject(forKey: "IsComplaintAdmin")
        UserDefaults.standard.removeObject(forKey: "Token")
    }
    @objc
    func setHomevc() {
        let vc = IOCLTabbarController.instantiate(fromAppStoryboard: .Main)
        let rootNC = UINavigationController(rootViewController: vc)
        rootNC.navigationBar.isHidden = true
        //        let sidemenu = SideMenuVC.instantiate(fromAppStoryboard: .User)
        //        let menu = SideMenuNavigationController(rootViewController: sidemenu)
        //        menu.leftSide = true
        //self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = rootNC
        self.window?.makeKeyAndVisible()
        
    }
    
    @objc
    func setHomeTabVC() {
        let vc = HomeVC.instantiate(fromAppStoryboard: .User)
        let rootNC = UINavigationController(rootViewController: vc)
        rootNC.navigationBar.isHidden = true
        
        //        let sidemenu = SideMenuVC.instantiate(fromAppStoryboard: .User)
        //        let menu = SideMenuNavigationController(rootViewController: sidemenu)
        //        menu.leftSide = true
        //self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = rootNC
        self.window?.makeKeyAndVisible()
        
    }
}
extension AppDelegate: UNUserNotificationCenterDelegate {

    //MARK: - Register For RemoteNotification
    func registerForNotification() {
        UNUserNotificationCenter.current().delegate = self
                let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { (isAllow, error) in

                    if isAllow {

                        Messaging.messaging().delegate = self

                    }

                }

                UIApplication.shared.registerForRemoteNotifications()
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        #if DEVELOPMENT
            Messaging.messaging().setAPNSToken(deviceToken, type: .sandbox)
        #else
            Messaging.messaging().setAPNSToken(deviceToken, type: .prod)
        #endif
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        debugPrint("Unable to register for remote notifications: \(error.localizedDescription)")
    }

    //MARK: - UNUserNotificationCenterDelegate
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        debugPrint(userInfo)
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        let userInfo = notification.request.content.userInfo
        debugPrint(userInfo)
        completionHandler([.badge, .alert, .sound])
    }


    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {

    //MARK: - MessagingDelegate
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print(fcmToken)
        FCMtoken = fcmToken ?? ""
        print("FCMtoken \(FCMtoken)")
        UserDefaults.standard.setValue(FCMtoken, forKey: "fcm_token")
        
    }
    
  

}

