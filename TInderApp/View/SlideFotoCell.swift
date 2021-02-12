//
//  SlideFotoCell.swift
//  TInderApp
//
//  Created by Deivid Willyan Rodrigues Fabiano on 12/02/21.
//

import UIKit

class SlideFotoCell: UICollectionViewCell {
    
    var fotoImgView: UIImageView = .fotoImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 8
        clipsToBounds = true
        addSubview(fotoImgView)
        fotoImgView.preencherSuperview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
