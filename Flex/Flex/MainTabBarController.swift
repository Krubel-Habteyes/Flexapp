//
//  MainTabBarController.swift
//  Flex
//
//  Created by KRUBEL SAHLE on 02/04/2017.
//  Copyright © 2017 KRUBEL SAHLE. All rights reserved.
//



import UIKit
import Firebase

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    
    lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "play_button"), for: .normal)
        //button.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let index = viewControllers?.index(of: viewController)
        if index == 2 {
            
            let layout = UICollectionViewFlowLayout()
            let photoSelectorController = PhotoSelectorController(collectionViewLayout: layout)
            let navController = UINavigationController(rootViewController: photoSelectorController)
            
            present(navController, animated: true, completion: nil)
            
            return false
        }
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(playButton)
        playButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 200, width: 0, height: 350)
        
       //dividers()
        
        self.delegate = self
        
        if FIRAuth.auth()?.currentUser == nil {
            //show if not logged in
            DispatchQueue.main.async {
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
            }
            
            return
        }
        
        setupViewControllers()
        
        dividers()
    }
    
    
    fileprivate func dividers() {
        
        let topDividerView = UIView()
        topDividerView.backgroundColor = UIColor.rgb(red: 64, green: 244, blue: 208)
        
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = UIColor.rgb(red: 64, green: 244, blue: 208)

        
        view.addSubview(topDividerView)
        topDividerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(bottomDividerView)
        bottomDividerView.anchor(top: topDividerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
    }
 

    
   func  setupViewControllers() {
    
    //search
    let searchNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"))
    
    //home
    
    let homeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: UserProfileController(collectionViewLayout: UICollectionViewLayout()))
    
    
    let likeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"))
    
    let plusNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "plus"), selectedImage: #imageLiteral(resourceName: "plus"))
    
    
    //user profile
    let layout = UICollectionViewFlowLayout()
    let userProfileController = UserProfileController(collectionViewLayout: layout)
    let userProfileNavController = UINavigationController(rootViewController: userProfileController)
    
    userProfileNavController.tabBarItem.image = #imageLiteral(resourceName: "unselected_user")
    userProfileNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "selected_user")
    
    
    
    
    tabBar.tintColor = .black
    
    viewControllers = [homeNavController,
                       searchNavController,
                       plusNavController,
                       likeNavController,
                       userProfileNavController]
    
    //modify tab bar item insets
    guard let items = tabBar.items else { return }
    
    for item in items {
        item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
}









