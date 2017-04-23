//
//  HowToUseInfo.swift
//  Flex
//
//  Created by KRUBEL SAHLE on 21/04/2017.
//  Copyright © 2017 KRUBEL SAHLE. All rights reserved.
//

import UIKit


class HowToUseInfo: UIViewController {
    
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "This Is How You Use The App:"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
            view.addSubview(infoLabel)
            infoLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
        
            navigationController?.isNavigationBarHidden = false
        
            view.backgroundColor = .white
        
            goBackButton()
        }
    
        fileprivate func goBackButton() {
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back_arrow").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleBackButton))
        
        }
    
    
        func handleBackButton() {
            
            
        
            let userProfileController = MainTabBarController()
            navigationController?.pushViewController(userProfileController, animated: true)
            navigationController?.isNavigationBarHidden = true 
            
          
        }
    
    }
