//
//  UserProfileHeader.swift
//  Flex
//
//  Created by KRUBEL SAHLE on 05/04/2017.
//  Copyright © 2017 KRUBEL SAHLE. All rights reserved.
//

import UIKit
import Firebase

class UserProfileHeader: UICollectionViewCell {
    
    
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        return iv
        
    }()
    
    let pointsButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "CurrentPoints@2x84x84"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    let galleryButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "gallery"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()

    let awardButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "AwardHistory@2x84x84"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    let supportingLabel: UILabel = {
        let label = UILabel()
        label.text = "11\nsupporting"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let supportersLabel: UILabel = {
        let label = UILabel()
        label.text = "0\nsupporters"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    let HottestBodyLabel: UILabel = {
        let label = UILabel()
        label.text = "Hottest Body:"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        //label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let BestViewLabel: UILabel = {
        let label = UILabel()
        label.text = "Best View:"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        //label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let BestDressedLabel: UILabel = {
        let label = UILabel()
        label.text = "Best Dressed:"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        //label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let CutestFaceLabel: UILabel = {
        let label = UILabel()
        label.text = "Cutest Face:"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        //label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let AlwaysLitLabel: UILabel = {
        let label = UILabel()
        label.text = "Always Lit (Party Animal): "
        label.font = UIFont.boldSystemFont(ofSize: 14)
        //label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let FunniestLabel: UILabel = {
        let label = UILabel()
        label.text = "Funniest:"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        //label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: self.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 300, height: 200)
        
        //profileImageView.layer.borderColor = UIColor.rgb(red: 64, green: 244, blue: 208).cgColor
        //profileImageView.layer.borderWidth = 3
        profileImageView.clipsToBounds = true
        
        setupBottomToolbar()
        
        setupUserStatsView()
        
        pointsInCategory()

        
    }
    
    fileprivate func pointsInCategory() {
        
        let stackView = UIStackView(arrangedSubviews: [HottestBodyLabel, BestViewLabel, CutestFaceLabel, FunniestLabel, BestDressedLabel, AlwaysLitLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.anchor(top: supportersLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
        
        
    }

    
    fileprivate func setupUserStatsView() {
        
        let stackView = UIStackView(arrangedSubviews: [supportersLabel, supportingLabel])
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.anchor(top: profileImageView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
    }
    
  

    
    fileprivate func setupBottomToolbar() {
        
        let topDividerView = UIView()
        topDividerView.backgroundColor = UIColor.rgb(red: 64, green: 244, blue: 208)

        
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = UIColor.rgb(red: 64, green: 244, blue: 208)
        
        let stackView = UIStackView(arrangedSubviews: [pointsButton, galleryButton, awardButton])
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        addSubview(topDividerView)
        addSubview(bottomDividerView)
        
        stackView.anchor(top: nil, left: leftAnchor, bottom: self.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 50, paddingRight: 0, width: 0, height: 50)
        
        topDividerView.anchor(top: stackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        bottomDividerView.anchor(top: stackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
    }
    
    var user: User? {
        
        didSet {
            
            setupProfileimage()
            

        }
    }
    
    fileprivate func setupProfileimage() {
        
        guard let profileImageUrl = user?.profileImageUrl else {return}
        
        guard let url = URL(string: profileImageUrl) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            print(data ?? "")
            
            guard let data = data else {return}
            
            let image  = UIImage(data: data)
            
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
            
            }.resume()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
