//
//  SpendView.swift
//  FinnApp
//
//  Created by MAC on 18.05.24.
//

import UIKit
import SnapKit
class SpendView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate{

    var sumTextField = UITextField()
    var nameSpend = UITextField()
    var dateText = UITextField()
    var button = UIButton()
    var dateTracker = UIDatePicker()
    let formatter = DateFormatter()
    var someImage = String()
   
    lazy var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return  self.createLayout()
        }
    )
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        self.addSubview(nameSpend)
        self.addSubview(sumTextField)
        self.addSubview(collectionView)
        self.addSubview(dateText)
        self.addSubview(button)
        toolBar()
        MoneyCoreData.shared.fetchIcon()
        dateTracker.datePickerMode = .date
        dateTracker.preferredDatePickerStyle = .wheels
        dateTracker.addTarget(self, action: #selector(tracker(dateTracker:)), for: UIControl.Event.allEvents)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        sumTextField.delegate = self
        nameSpend.delegate = self
        
        nameSpend.backgroundColor = UIColor.white
        nameSpend.placeholder = "Enter Name"
        nameSpend.layer.cornerRadius = 6
        nameSpend.setLeftPaddingPoints(10)
        
        sumTextField.backgroundColor = UIColor.white
        sumTextField.placeholder = "Enter Sum"
        sumTextField.layer.cornerRadius = 6
        sumTextField.setLeftPaddingPoints(10)
        
        dateText.textColor = .black
        dateText.backgroundColor = UIColor.white
        let currentDateTime = Date()
        formatter.dateFormat = "MM/dd/yyyy"
        dateText.inputView = dateTracker
        dateText.text = formatter.string(from: currentDateTime)
        dateText.layer.cornerRadius = 6
        dateText.placeholder = "Choose date"
        dateText.setLeftPaddingPoints(10)
        
        button.backgroundColor  = .black
        button.setTitle("Save", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(save), for: .touchUpInside)
        collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.id)
        
        nameSpend.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(20)
            make.height.equalTo(self.snp.height).multipliedBy(0.1/2)
            make.left.right.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }

        sumTextField.snp.makeConstraints { make in
            make.top.equalTo(nameSpend.snp.bottom).offset(20)
            make.height.equalTo(self.snp.height).multipliedBy(0.1/2)
            make.left.right.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(sumTextField.snp.top).inset(50)
            make.left.right.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(self.snp.height).multipliedBy(0.6)
        }
        
        dateText.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(sumTextField.snp.height)
        }
        
        button.snp.makeConstraints { make in
            make.left.right.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.height.equalToSuperview().multipliedBy(0.1/2)
            make.top.equalTo(dateText.snp.bottom).offset(20)
            
        }
        
    }
    
  
    
    func toolBar() {
         let tool = UIToolbar()
        tool.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace , target: nil, action: nil)
        tool.setItems([flexSpace, doneButton], animated: true)
        dateText.inputAccessoryView = tool
    }
    
    @objc func doneAction() {

  
//        dateText.text = formatter.string(from: currentDateTime)
        self.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sumTextField.endEditing(true)
        nameSpend.endEditing(true)
     
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
        collectionView.endEditing(true)
    }
    
    
    @objc func tracker(dateTracker: UIDatePicker) {
       
       
        dateText.text = formatter.string(from: dateTracker.date)
        self.endEditing(true)
      
    }
   
    
     @objc func save(){
         
         guard let ddate = dateText.text else {
             return
         }
         
         guard let doubleNum = Double(sumTextField.text ?? "")  else {
             return
         }
         
         MoneyCoreData.shared.createSpending(name: nameSpend.text ?? "", image: someImage, totalSpend:doubleNum, date:  formatter.date(from: ddate)!)

     }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return MoneyCoreData.shared.arrayIcons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = Cell()
        
        if indexPath.section == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.id, for: indexPath) as! Cell
            cell.imageOne.image = UIImage(systemName: MoneyCoreData.shared.arrayIcons[indexPath.row].image!)
            cell.imageOne.contentMode = .scaleAspectFit
            cell.imageOne.tintColor = .black
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        someImage = MoneyCoreData.shared.arrayIcons[indexPath.row].image ?? ""
        
        if let cell = collectionView.cellForItem(at: indexPath) as? Cell {
            cell.imageOne.tintColor  = .blue
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? Cell {
            cell.imageOne.tintColor = .black
        }
    }
    
    func createLayout() -> NSCollectionLayoutSection {
        
        let supplementaryViews = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(50)
                ),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
        ]

        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(12), top: .fixed(10), trailing: .fixed(12), bottom: .fixed(0))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.1), heightDimension: .fractionalHeight(0.1)), repeatingSubitem: item, count: 6)
        
//        group.interItemSpacing =
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 50
        
         return section
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UITextField{
    
    func setLeftPaddingPoints(_ amount:CGFloat){
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }
}
