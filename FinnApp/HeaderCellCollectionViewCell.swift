//
//  HeaderCellCollectionViewCell.swift
//  FinnApp
//
//  Created by Даша Волошина on 4.04.24.
//

import UIKit
import SnapKit

class HeaderCellCollectionViewCell: UICollectionViewCell {
    
    static let id = "HeaderCell"
    static let kind = "HeaderCell"
    var button = UIButton()
    var textHeader = UILabel()
    override init(frame:CGRect){
        super.init(frame:frame)
        contentView.addSubview(textHeader)
        contentView.addSubview(button)
        createConstraints()
        
    }
    func createConstraints() {
        textHeader.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).inset(10)
            make.top.equalTo(contentView.snp.top).inset(10)
        }
        button.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.right).inset(120)
            make.top.equalTo(contentView.snp.top).inset(10)
            make.width.equalTo(textHeader.snp.width)
            make.height.equalTo(30)
        }
    }
     
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
