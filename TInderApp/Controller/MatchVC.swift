//
//  MatchVC.swift
//  TInderApp
//
//  Created by Deivid Willyan Rodrigues Fabiano on 10/02/21.
//

import UIKit

class MatchVC: UIViewController, UITextFieldDelegate {
    
    var usuario: Usuario? {
        didSet {
            if let usuario = usuario {
                fotoImageView.image = UIImage(named: usuario.foto)
                msgLabel.text = "\(usuario.nome) curtiu você também!"
            }
        }
    }
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        view.addSubview(fotoImageView)
        fotoImageView.preencherSuperview()
        
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.black.cgColor]
        
        fotoImageView.layer.addSublayer(gradient)
        
        msgTxt.delegate = self
        
        msgLabel.textAlignment = .center
        msgLabel.adicionaShadow()
        
        voltarButton.addTarget(self, action: #selector(voltarClick), for: .touchUpInside)
        
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
        msgEnviarButton.addTarget(self, action: #selector(enviarMsg), for: .touchUpInside)
        
        
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
    
    @objc func voltarClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.enviarMsg()
        
        return true
    }
    
    @objc func enviarMsg() {
        if let msg = self.msgTxt.text {
            print(msg)
        }
    }
    
    @objc func keyboardShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if let duracao = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
                
                UIView.animate(withDuration: duracao, animations: {
                    self.view.frame = CGRect(
                        x: self.view.frame.origin.x,
                        y: self.view.frame.origin.y,
                        width: self.view.frame.width,
                        height: self.view.frame.height - keyboardSize.height
                    )
                    self.view.layoutIfNeeded()
                    
                })
            }
        }
    }
    
    @objc func keyboardHide(notification: NSNotification) {
        if let duracao = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            UIView.animate(withDuration: duracao, animations: {
                self.view.frame = UIScreen.main.bounds
                self.view.layoutIfNeeded()
            })
        }
    }
    
}
