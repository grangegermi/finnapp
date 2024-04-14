//
//  AddController.swift
//  FinnApp
//
//  Created by Даша Волошина on 14.04.24.
//

import UIKit

class AddController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {

    var picker = UIPickerView()
    var textField = UITextField()
    var collectionview = UICollectionView()
    var dateTrecker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        <#code#>
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
}
