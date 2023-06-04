//
//  IOCLTabbarController.swift
//  IOCL
//
//  Created by infoneo on 19/12/22.
//

import UIKit

class IOCLTabbarController: UITabBarController, UITabBarControllerDelegate {
    
    //MARK: -VARIABLES-
    var Home : UITabBarItem!
    var List : UITabBarItem!
    var Search : UITabBarItem!
    var Profile : UITabBarItem!
    var Messages : UITabBarItem!
    
    //MARK: -VIEW LIFE CYLCE FUNCTION-
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarSetup()
        self.delegate = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.clipsToBounds = false
    }
    
    //MARK: -FUNCTIONS-
    @objc
    private func tabBarSetup() {
        //Home TabBar Setup
        tabBar.backgroundColor = .appColor(.themeColor)
        self.Home = UITabBarItem()
        
        ///Bet Leger TabBar Setup
        self.List = UITabBarItem()
       
        ///Add TabBar Setup
        self.Search = UITabBarItem()
        ///Betcha TabBar Setup
        self.Profile = UITabBarItem()
       
        ///Messages TabBar Setup
        self.Messages = UITabBarItem()
       
        let VC1 = HomeVC.instantiate(fromAppStoryboard: .User)
        VC1.tabBarItem = self.Home
        
        let VC2 = HomeVC.instantiate(fromAppStoryboard: .Main)
        VC2.tabBarItem = self.List
        let VC3 = HomeVC.instantiate(fromAppStoryboard: .User)
        VC3.tabBarItem = self.Search
        let VC4 = ProfileVC.instantiate(fromAppStoryboard: .User)
        VC4.tabBarItem = self.Profile
        let VC5 = HomeVC.instantiate(fromAppStoryboard: .User)
        VC5.tabBarItem = self.Messages
        self.viewControllers = [VC1, VC2, VC3, VC4, VC5]
        self.tabBarElementSetup()
        UITabBar.appearance().unselectedItemTintColor = UIColor.appColor(.white)
    }
    ///TAB BAR SET ICON FOR SELECTION
    @objc
    private func tabBarElementSetup() {
        
        self.tabBarItemSetup(self.Home, img: UIImage(named: "homeUnselect")!, selectedImg: UIImage(named: "homeSelect")!)
        self.tabBarItemSetup(self.List, img: UIImage(named: "listSelect")!, selectedImg: UIImage(named: "listSelect")!)
        self.tabBarItemSetup(self.Search, img: UIImage(named: "searchTab")!, selectedImg: UIImage(named: "searchTab")!)
        self.tabBarItemSetup(self.Profile, img: UIImage(named: "profileSelect")!, selectedImg: UIImage(named: "profileSelect")!)
        self.tabBarItemSetup(self.Messages, img: UIImage(named: "messagesUnselect")!, selectedImg: UIImage(named: "messagesSelect")!)
        
        for tabBarItem in tabBar.items! where tabBarItem == self.Search {
            tabBarItem.title = ""
            tabBarItem.imageInsets = UIEdgeInsets(top: -10, left: 0, bottom: 0, right: 0)
        }

    }
    ///SET UP IMAGE  DIRECTIONS
    @objc
    private func tabBarItemSetup(_ item: UITabBarItem, img: UIImage, selectedImg: UIImage) {
        item.image = img.withRenderingMode(.alwaysOriginal)
        item.selectedImage = selectedImg.withRenderingMode(.alwaysOriginal)
        item.imageInsets = UIEdgeInsets(top: 15, left: 0, bottom: -10, right: 0)
       
    }
    
   
}
