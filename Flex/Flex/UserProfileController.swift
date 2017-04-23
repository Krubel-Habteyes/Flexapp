//
//  UserProfileController.swift
//  Flex
//
//  Created by KRUBEL SAHLE on 02/04/2017.
//  Copyright © 2017 KRUBEL SAHLE. All rights reserved.
//


import UIKit
import Firebase

class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        
        navigationItem.title = FIRAuth.auth()?.currentUser?.uid
        
        fetchUser()
    
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")
        
    
        setupLogOutButton()
        
    }

    fileprivate func  setupLogOutButton() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "account_setting").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handgleLogOut))
         
    }
    
    func handgleLogOut() {
        let alertControl = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        
        alertControl.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            do {
                try FIRAuth.auth()?.signOut()
                
             let loginController = LoginController()
             let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
                
            } catch let SignOurErr {
                print("Failed to sign out: ", SignOurErr)
            }
            
        }))
        
        alertControl.addAction(UIAlertAction(title: "How To Use This App", style: UIAlertActionStyle.default, handler: { (_) in
            
            let howToUse = HowToUseInfo()
            let navController = UINavigationController(rootViewController: howToUse)
                self.present(navController, animated: true, completion: nil)
            
        }))
        
        alertControl.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil ))
        
        
        present(alertControl, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! UserProfileHeader
        
        header.user = self.user 
        
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    var user: User?
    fileprivate func fetchUser() {
        
        guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
        
        FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value ?? "")
            
            guard let dictionary = snapshot.value as? [String: Any] else {return}

            self.user = User(dictionary: dictionary)
            self.navigationItem.title = self.user?.username
            self.collectionView?.reloadData()
            
        }) { (err) in
            print("Failed to fetch user: ", err)
        }
    }
}

struct User {
    
    let username: String
    let profileImageUrl: String
    
    init(dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as?
        String ?? ""
    }
}


