//
//  Cell.swift
//  FinnApp
//
//  Created by Даша Волошина on 14.04.24.
//

import UIKit
import SnapKit

class Cell: UICollectionViewCell {
    
    static let id = "Cell"
    var image = UIImageView()
    
    override init(frame:CGRect){
        super.init(frame: frame)
        contentView.addSubview(image)
        addImageConstraints()
        
    }
    func addImageConstraints() {
        image.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
            make.bottom.equalTo(contentView.snp.bottom)
            make.right.equalTo(contentView.snp.right)
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
