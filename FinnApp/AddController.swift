//
//  AddController.swift
//  FinnApp
//
//  Created by Даша Волошина on 14.04.24.
//

import UIKit
import SnapKit

class AddController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {

    var picker = UIPickerView()
    var textField = UITextField()
    var dateText = UITextField()
    lazy var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return  self.createLayout()
        }
    )
    var dateTracker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(picker)
//        view.addSubview(textField)
        view.addSubview(collectionView)
        view.addSubview(dateTracker)
        view.addSubview(dateText)
        picker.delegate = self
        picker.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        textField.delegate = self
        
        picker.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(20)
            make.left.equalTo(view.snp.left).inset(40)
            make.right.equalTo(view.snp.right).inset(40)
//            make.bottom.equalTo(collectionView.snp.top).inset(20)
            make.height.equalTo(view.snp.height).multipliedBy(0.1)

        }
        
//        textField.snp.makeConstraints { make in
//            make.top.equalTo(picker.snp.bottom).inset(100)
//            make.height.equalTo(view.snp.height).multipliedBy(0.1)
////            make.width.equalTo(view.snp.width).multipliedBy(0.9)
//            make.right.equalTo(view.snp.right)
//            make.left.equalTo(view.snp.left)
//        }
        
        dateText.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).inset(textField.bounds.height)
            make.height.equalTo(30)
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
        }
        dateText.text = "fff"
        dateText.borderStyle = .bezel
        dateText.textColor = .black
        dateText.inputView = dateTracker
        
        dateTracker.datePickerMode = .date
        dateTracker.preferredDatePickerStyle = .wheels
        picker.backgroundColor = .yellow
        textField.borderStyle = .line
        collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.id)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(100)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(view.snp.height).multipliedBy(0.4)
        }
        
        dateTracker.snp.makeConstraints { make in
            make.top.equalTo(dateText.snp.bottom).inset(textField.bounds.height)
            make.height.equalTo(view.snp.height).multipliedBy(0.3)
            make.width.equalTo(view.snp.width).multipliedBy(0.7)
            make.right.equalTo(view.snp.right).inset(40)
            make.left.equalTo(view.snp.left).inset(40)
        }
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return "Hello"
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = Cell()
        
        if indexPath.section == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.id, for: indexPath) as! Cell
            cell.imageOne.image = UIImage(systemName: "paperplane.fill")
        }
        return cell
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
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(0.2)), repeatingSubitem: item, count: 6)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        
         return section
    }
}
