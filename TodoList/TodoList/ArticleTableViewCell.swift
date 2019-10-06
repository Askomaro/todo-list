//
//  ArticleTableViewCell.swift
//  DOUCalendar
//
//  Created by Anton Skomarovskyi on 10/07/19.
//  Copyright © 2019 Anton Skomarovskyi. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    var spaceConstant : CGFloat  = 5
    
    var imageViewBackground: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 3
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 3
        
        return view
    }()
    
    var mainImageView : UIImageView = {
        var imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    var mainLabelTitle : UILabel = {
        var label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.black
        
        return label
    }()
    
    var infoLabel : UILabel = {
        var infoLabel = UILabel()
        
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.font = UIFont.systemFont(ofSize: 10)
        infoLabel.textColor = UIColor.darkGray
        infoLabel.textAlignment = .right
        
        return infoLabel
    }()
    
    var textView : UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = UIColor.lightGray
        textView.font = UIFont.systemFont(ofSize: 12)
        textView.isEditable = false
        textView.isUserInteractionEnabled = false
        
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

//        self.imageViewBackground.addSubview(mainImageView)
        
//        self.addSubview(imageViewBackground)
        self.addSubview(mainLabelTitle)
        self.addSubview(infoLabel)
        self.addSubview(textView)
    }
    
    override func layoutSubviews() {
        mainImageView.centerYAnchor.constraint(equalTo: imageViewBackground.centerYAnchor).isActive = true
        mainImageView.widthAnchor.constraint(equalToConstant: 100 ).isActive = true
        
        imageViewBackground.leftAnchor.constraint(equalTo: self.leftAnchor, constant: spaceConstant).isActive = true
        imageViewBackground.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageViewBackground.widthAnchor.constraint(equalToConstant: 100 ).isActive = true

        mainLabelTitle.leftAnchor.constraint(equalTo: self.imageViewBackground.rightAnchor, constant: spaceConstant * 2).isActive = true
        mainLabelTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: spaceConstant).isActive = true
        mainLabelTitle.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        textView.leftAnchor.constraint(equalTo: self.imageViewBackground.rightAnchor, constant: spaceConstant).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: spaceConstant).isActive = true
        textView.topAnchor.constraint(equalTo: self.infoLabel.bottomAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        infoLabel.leftAnchor.constraint(equalTo: self.mainLabelTitle.leftAnchor).isActive = true
        infoLabel.bottomAnchor.constraint(equalTo: self.textView.topAnchor).isActive = true
        infoLabel.topAnchor.constraint(equalTo: self.mainLabelTitle.bottomAnchor, constant: spaceConstant).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
