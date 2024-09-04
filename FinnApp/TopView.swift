//
//  TopView.swift
//  FinnApp
//
//  Created by Даша Волошина on 24.03.24.
//

import UIKit
import SnapKit



class TopView: UIView, ModalTransitionListener{
 
    
    var viewIncome: AddController?
    

    var sumIncome : Double = 0.0
    var a = 0.0
    var total = 0.0
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
//        createText()
        createConstraints()
//        MoneyCoreData.shared.deleteIncome()
        MoneyCoreData.shared.fetchIncome()
//        popoverDismissed()
//        MoneyCoreData.shared.fetchIncome()
        self.setNeedsDisplay()
//        viewIncome?.delegate = self
       
    }
   
    func popoverDismissed() {
//        let vc = AddController()
//        MoneyCoreData.shared.fetchIncome()
//        vc.navigationController?.dismiss(animated: true)
        self.reloadInputViews()
//
      
    }
//    override func updateTraitsIfNeeded() {
//        reloadData()
//    }
    
//    func reloadData() {
//           if delegate != nil {
//               textIncome.text = delegate!.getsumIncome()
//               MoneyCoreData.shared.fetchIncome()
//           }
//           self.setNeedsDisplay()
//       }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
   
   func  gotSum() {
       createText()
       textIncome.text = String(sumIncome)
       textTotal.text = String(total)
    }

    func createText(){
        
        textNameTotal.text = "Остаток"

        let a = MoneyCoreData.shared.spend.map({$0.totalSpend}).reduce(0, +)
//        textTotal.text = String(sumIncome - a)
        print(total)
        
        textNameIncome.text = "Доход"
        sumIncome = MoneyCoreData.shared.income.map({$0.incomeSum}).reduce(0, +)
        
        textNameSpending.text = "Расход"
        textSpending.text  = (String (MoneyCoreData.shared.spend.map({$0.totalSpend}).reduce(0, +)))
        
        total = sumIncome - a
//        String(MoneyCoreData.shared.spend.map({$0.totalSpend}))
        
    }
    
    func createConstraints(){

        textNameTotal.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(20)
            make.left.equalTo(self.snp.left).inset(50)
        }
        textTotal.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(20)
            make.left.equalTo(textNameTotal.snp.right).inset(-50)
        }
        
        textNameIncome.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(50)
            make.left.equalTo(self.snp.left).inset(50)
        }
        
        textIncome.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(50)
            make.left.equalTo(textNameIncome.snp.right).inset(-20)
        }
        textNameSpending.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(80)
            make.left.equalTo(self.snp.left).inset(50)
        }
        
        textSpending.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(80)
            make.left.equalTo(textNameSpending.snp.right).inset(-20)
        }
    }  
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
