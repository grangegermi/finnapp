//
//  IncomeView.swift
//  FinnApp
//
//  Created by MAC on 18.05.24.
//

import UIKit
import SnapKit

class IncomeView: UIView, UITextFieldDelegate {
  
    
   
    var datePicker = UIDatePicker()
    var sumText = UITextField()
    var dateText = UITextField()
    var buttonSave = UIButton()
    let formatter = DateFormatter()
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        
      
        self.addSubview(sumText)
        self.addSubview(dateText)
        self.addSubview(buttonSave)
        constraints()
        sumText.delegate = self
        sumText.placeholder = "Enter Sum"
        sumText.setLeftPaddingPoints(10)
    
    
        dateText.delegate = self
        dateText.placeholder = "Choose the date"
        dateText.setLeftPaddingPoints(10)
        dateText.inputView = datePicker
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(selectDate(datePicker:)), for: .valueChanged)
        
        createTextField()
        toolBar()
        
        buttonSave.backgroundColor = .magenta
        buttonSave.layer.cornerRadius = 6
        buttonSave.setTitle("Save", for: .normal)
        buttonSave.addTarget(self, action: #selector(saveIncome), for: .touchUpInside)
        
    }
    @objc func selectDate(datePicker: UIDatePicker) {
  
        formatter.dateFormat = "MM/dd/yyyy"
        dateText.text = formatter.string(from: datePicker.date)
      
    }
   
    
    @objc func doneAction() {
        self.endEditing(true)
    }
    
    @objc func saveIncome () {
        
        guard let someDate = dateText.text else {
            return
        }
        
        guard let someIncome = Double(sumText.text ?? "")  else {
            return
        }

       

        MoneyCoreData.shared.createContextIncome(incomeSum: Double(someIncome), date: formatter.date(from: someDate)!)
        
    }
    func toolBar() {
         let tool = UIToolbar()
        tool.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace , target: nil, action: nil)
        tool.setItems([flexSpace, doneButton], animated: true)
        dateText.inputAccessoryView = tool
    }
    
    
    func createTextField(){

        sumText.backgroundColor = UIColor.white
        sumText.layer.cornerRadius = 6
        
        dateText.backgroundColor = UIColor.white
        dateText.layer.cornerRadius = 6
    }
    
    func constraints(){
        
        sumText.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(40)
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
            make.height.equalTo(self.snp.height).multipliedBy(0.1/2)
        }
         
        dateText.snp.makeConstraints { make in
            make.top.equalTo(sumText.snp.bottom).offset(40)
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
            make.height.equalTo(self.snp.height).multipliedBy(0.1/2)
        }
    
        buttonSave.snp.makeConstraints { make in
            make.top.equalTo(dateText.snp.bottom).offset(40)
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
            make.height.equalTo(self.snp.height).multipliedBy(0.1/2)
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return sumText.resignFirstResponder()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
  

}
