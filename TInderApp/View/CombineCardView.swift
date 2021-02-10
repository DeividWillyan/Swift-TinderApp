//
//  CombineCardView.swift
//  TInderApp
//
//  Created by Deivid Willyan Rodrigues Fabiano on 10/02/21.
//

import UIKit

class CombineCardView: UIView {
    
    var usuario: Usuario? {
        didSet {
            if let usuario = usuario {
                fotoImageView.image = UIImage(named: usuario.foto)
                nameLabel.text = usuario.nome
                idadeLabel.text = String(usuario.idade)
                fraselabel.text = usuario.frase
            }
        }
    }
    
    let fotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pessoa-1")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView;
    }()
    
    let nameLabel: UILabel = .textBoldLabel(32, textColor: .white)
    let idadeLabel: UILabel = .textLabel(28, textColor: .white)
    let fraselabel: UILabel = .textLabel(18, textColor: .white, numberOfLines: 2)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 0.3
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 8
        clipsToBounds = true
        
        nameLabel.text = "Ana Laura"
        idadeLabel.text = "20"
        fraselabel.text = "O último a dar match chama"
        
        nameLabel.adicionaShadow()
        idadeLabel.adicionaShadow()
        fraselabel.adicionaShadow()
        
        addSubview(fotoImageView)
        
        fotoImageView.preencherSuperview()
        
        let nomeIdadeStackView = UIStackView(arrangedSubviews: [nameLabel, idadeLabel, UIView()])
        nomeIdadeStackView.spacing = 12
        
        let stackView = UIStackView(arrangedSubviews: [nomeIdadeStackView, fraselabel])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        
        addSubview(stackView)
        stackView.preencher(
            top: nil,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor,
            padding: .init(top: 0, left: 16, bottom: 16, right: 16)
        )
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
