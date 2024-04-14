//
//  TopView.swift
//  FinnApp
//
//  Created by Даша Волошина on 24.03.24.
//

import UIKit
import SnapKit

protocol TopViewDelegate: AnyObject {
    func allReady()
}

class TopView: UIView {

    var textTotal = UILabel()
    var textIncome = UILabel()
    var textSpending = UILabel()
    var textNameTotal = UILabel()
    var textNameIncome = UILabel()
    var textNameSpending = UILabel()
    
    override init(frame:CGRect){
        super.init(frame:frame)
        
        addSubview(textTotal)
        addSubview(textIncome)
        addSubview(textSpending)
        addSubview(textNameTotal)
        addSubview(textNameIncome)
        addSubview(textNameTotal)
        addSubview(textNameSpending)
        createText()
        createConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createText(){
        
        textNameTotal.text = "Остаток"
        textNameIncome.text = "Доход"
        textNameSpending.text = "Расход"
    }
    
    func createConstraints(){

        textNameTotal.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(20)
            make.left.equalTo(self.snp.left).inset(50)
        }
        textTotal.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(20)
            make.left.equalTo(textNameTotal.snp.right).inset(20)
        }
        
        textNameIncome.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(36)
            make.left.equalTo(self.snp.left).inset(50)
        }
        
        textIncome.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(36)
            make.left.equalTo(textNameIncome.snp.right).inset(20)
        }
        textNameSpending.snp.makeConstraints { make in
            make.top.equalTo(textNameIncome.snp.top).inset(20)
            make.left.equalTo(self.snp.left).inset(50)
        }
        
        textSpending.snp.makeConstraints { make in
            make.top.equalTo(textNameIncome.snp.top).inset(20)
            make.left.equalTo(textNameSpending.snp.right).inset(20)
        }
    }    
}
