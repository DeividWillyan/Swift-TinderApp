//
//  DetalheHeaderView.swift
//  TInderApp
//
//  Created by Deivid Willyan Rodrigues Fabiano on 12/02/21.
//

import UIKit

class DetalheHeaderView: UICollectionReusableView {
    
    var usuario: Usuario? {
        didSet {
            if let usuario = usuario {
                fotoImgView.image = UIImage(named: usuario.foto)
            }
        }
    }
    
    var fotoImgView: UIImageView = .fotoImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(fotoImgView)
        fotoImgView.preencherSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
