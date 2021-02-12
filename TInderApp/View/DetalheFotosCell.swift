//
//  DetalheFotosCell.swift
//  TInderApp
//
//  Created by Deivid Willyan Rodrigues Fabiano on 12/02/21.
//

import UIKit

class DetalheFotosCell: UICollectionViewCell {
    
    let descLabel: UILabel = .textBoldLabel(16)
    let slideFotosVC = SlideFotosVC()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        descLabel.text = "Fotos recentes Instagram"
        
        addSubview(descLabel)
        descLabel.preencher(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 0, left: 20, bottom: 0, right: 20)
        )
        
        addSubview(slideFotosVC.view)
        slideFotosVC.view.preencher(
            top: descLabel.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
