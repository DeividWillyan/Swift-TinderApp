//
//  DetalheVC.swift
//  TInderApp
//
//  Created by Deivid Willyan Rodrigues Fabiano on 11/02/21.
//

import UIKit

class HeaderLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        layoutAttributes?.forEach({ (attribute) in
            if( attribute.representedElementKind == UICollectionView.elementKindSectionHeader) {
                
                guard let collectionView = collectionView else { return }
                let contentOffSetY = collectionView.contentOffset.y
                attribute.frame = CGRect(
                    x: 0,
                    y: contentOffSetY,
                    width: collectionView.bounds.width,
                    height: attribute.bounds.height - contentOffSetY
                )
                
            }
        })
        
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}

class DetalheVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var usuario: Usuario? {
        didSet{
            self.collectionView.reloadData()
        }
    }
        
    let cellId = "cellId"
    let headlerId = "headlerId"
    let perfilId = "perfilId"
    let fotosId = "fotosId"
    
    var likeBtn: UIButton = .iconFooter(named: "icone-like")
    var deslikeBtn: UIButton = .iconFooter(named: "icone-deslike")
    
    var callback: ((Usuario?, Acao) -> Void)?
    
    init() {
        super.init(collectionViewLayout: HeaderLayout())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 134, right: 0)
        
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.register(DetalheHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headlerId)
        collectionView.register(DetalhePerfilCell.self, forCellWithReuseIdentifier: perfilId)
        collectionView.register(DetalheFotosCell.self, forCellWithReuseIdentifier: fotosId)
        
        self.adicionarFooter()
    }
    
    func adicionarFooter() {
        let stackView = UIStackView(arrangedSubviews: [UIView(), deslikeBtn, likeBtn, UIView()])
        stackView.distribution = .equalCentering
        
        view.addSubview(stackView)
        stackView.preencher(
            top: nil,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            bottom: view.bottomAnchor,
            padding: .init(top: 0, left: 16, bottom: 34, right: 16)
        )
        
        deslikeBtn.addTarget(self, action: #selector(deslikeClick), for: .touchUpInside)
        likeBtn.addTarget(self, action: #selector(likeClick), for: .touchUpInside)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headlerId, for: indexPath) as! DetalheHeaderView
        header.usuario = self.usuario
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.bounds.width, height: view.bounds.height * 0.7)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
//        cell.backgroundColor = .blue
//        return cell;
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: perfilId, for: indexPath) as! DetalhePerfilCell
            cell.usuario = self.usuario
            
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: fotosId, for: indexPath) as! DetalheFotosCell
        return cell       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = UIScreen.main.bounds.width
        var height: CGFloat = UIScreen.main.bounds.width * 0.66

        if indexPath.item == 0 {
            let cell = DetalhePerfilCell(frame: CGRect(x: 0, y: 0, width: width, height: height))
            cell.usuario = self.usuario
            
            cell.layoutIfNeeded()
            
            let estimativaTamanho = cell.systemLayoutSizeFitting(CGSize(width: width, height: 1000))
            height = estimativaTamanho.height
        }
        
       
        
        return .init(width: width, height: height)
    }
    
    @objc func voltarClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func deslikeClick() {
        self.callback?(self.usuario, Acao.deslike)
        self.voltarClick()
    }
    
    @objc func likeClick() {
        self.callback?(self.usuario, Acao.like)
        self.voltarClick()
    }
    
}
