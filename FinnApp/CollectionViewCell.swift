//
//  CollectionViewCell.swift
//  FinnApp
//
//  Created by Даша Волошина on 24.02.24.
//

import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell {
    
    static let id = "CollectionViewCell"
    var view = UIView()
    var textName = UILabel()
    var textTotal = UILabel()
    var image = UIImageView()
    
    override init(frame:CGRect){
        super.init(frame:frame)
        contentView.addSubview(view)
        view.addSubview(textTotal)
        view.addSubview(textName)
        view.addSubview(image)
        createConstraints()
        addImage()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addImage(){
        
        image.image = UIImage(systemName: "house.fill")
        textTotal.text = "-200"
        textName.text = "Home"
        view.backgroundColor = .orange
        view.layer.cornerRadius = 10 
    }
    func createConstraints(){
        
        view.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left)
            make.top.equalTo(contentView.snp.top)
            make.right.equalTo(contentView.snp.right)
            make.bottom.equalTo(contentView.snp.bottom)
        }

        textName.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(20)
            make.left.equalTo(view.snp.left).inset(10)
        }
        
        textTotal.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(60)
            make.left.equalTo(view.snp.left).inset(10)
        }
        
        image.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(20)
            make.right.equalTo(view.snp.right).inset(10)
        }
    }
}

