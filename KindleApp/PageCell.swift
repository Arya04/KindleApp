//
//  PageCell.swift
//  KindleApp
//
//  Created by Arya Atighehchian on 8/3/18.
//  Copyright © 2018 Arya Atighehchian. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "text"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textLabel)
        textLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        textLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
}
