//
//  MatchVC.swift
//  TInderApp
//
//  Created by Deivid Willyan Rodrigues Fabiano on 10/02/21.
//

import UIKit

class MatchVC: UIViewController {
    
    let fotoImageView: UIImageView = .fotoImageView(named: "pessoa-1")
    let likeImageView: UIImageView = .fotoImageView(named: "icone-like")
    let msgLabel: UILabel = .textBoldLabel(18, textColor: .white, numberOfLines: 1)
    
    let msgTxt: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        textField.placeholder = "Diga algo legal..."
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.textColor = .darkText
        textField.returnKeyType = .go
        
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always

        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 0))
        textField.rightViewMode = .always
        
        return textField
    }()
    
    let msgEnviarButton: UIButton = {
        let button = UIButton()
        button.setTitle("Enviar", for: .normal)
        button.setTitleColor(UIColor(red: 62/255, green: 163/255, blue: 255/255, alpha: 1), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()
    
    let voltarButton: UIButton = {
      let button = UIButton()
      button.setTitle("Voltar para o Tinder", for: .normal)
      button.setTitleColor(.white, for: .normal)
      button.titleLabel?.font = .systemFont(ofSize: 16)
      return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(fotoImageView)
        fotoImageView.preencherSuperview()
        
        msgLabel.text = "Ana curtiu você também!"
        msgLabel.textAlignment = .center
        msgLabel.adicionaShadow()
        
        likeImageView.translatesAutoresizingMaskIntoConstraints = false
        likeImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        likeImageView.contentMode = .scaleAspectFit
        
        msgTxt.addSubview(msgEnviarButton)
        msgEnviarButton.preencher(
            top: msgTxt.topAnchor,
            leading: nil,
            trailing: msgTxt.trailingAnchor,
            bottom: msgTxt.bottomAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 16)
          )
        
        
        let stackView = UIStackView(arrangedSubviews: [likeImageView, msgLabel, msgTxt, voltarButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        
        view.addSubview(stackView)
        stackView.preencher(
            top: nil,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            bottom: view.bottomAnchor,
            padding: .init(top: 0, left: 32, bottom: 46, right: 32)
        )
    }
    
}
