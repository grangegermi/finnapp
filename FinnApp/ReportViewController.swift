//
//  ReportViewController.swift
//  FinnApp
//
//  Created by Даша Волошина on 6.04.24.
//

import UIKit
import Charts
import Algorithms
import SnapKit

class ReportViewController: UIViewController, ChartViewDelegate {
    
    
    var bar = PieChartView()
    var array = ["Income", "Spending"]
    lazy var segmentControl: UISegmentedControl = {
        let view = UISegmentedControl(items: array)
//        view.selectedSegmentIndex = 0
        view.addTarget(self, action: #selector(goToScreen), for: .valueChanged)
        return view
    }()
    var income = IncomeCharts()
    var spending = SpendCharts()
    var viewScreen  = UIView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        income.createCharts()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(segmentControl)
        view.addSubview(viewScreen)
        segmentControl.selectedSegmentIndex = 0
        
        viewScreen.addSubview(income)
        viewScreen.addSubview(spending)
        spending.isHidden = true
        
//        viewScreen.backgroundColor = .blue

        segmentControl.backgroundColor = .systemPink
//        segmentControl.selectedSegmentIndex = 0
        segmentControl.selectedSegmentTintColor = .white
        
        segmentControl.addTarget(self, action: #selector(goToScreen), for: .valueChanged)
        
//        income.backgroundColor = .gray
//        spending.backgroundColor = .yellow
        
        self.navigationController?.navigationBar.isHidden = true
        
        constraint()
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(70)
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
            make.height.equalTo(view.snp.height).multipliedBy(0.1/2)
            make.left.right.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
    }
    
    
    func constraint(){
        
        viewScreen.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.top).offset(70)
            make.bottom.equalTo(view.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        }
        
        income.snp.makeConstraints { make in
            make.top.equalTo(viewScreen.snp.top)
            make.bottom.equalTo(viewScreen.snp.bottom)
            make.left.equalTo(viewScreen.snp.left)
            make.right.equalTo(viewScreen.snp.right)
        }
        
        spending.snp.makeConstraints { make in
            make.top.equalTo(viewScreen.snp.top)
            make.bottom.equalTo(viewScreen.snp.bottom)
            make.left.equalTo(viewScreen.snp.left)
            make.right.equalTo(viewScreen.snp.right)
        }
    }
    
    @objc func goToScreen() {
//        segmentControl.selectedSegmentIndex = 0
      
        if  segmentControl.selectedSegmentIndex == 0 {
            income.isHidden = false
            spending.isHidden = true
       
//        segmentControl.selectedSegmentIndex = 1
        //            income.alpha = 1
        //            spending.alpha = 0
        //            income.backgroundColor = .magenta

    } else {
//
//        segmentControl.selectedSegmentIndex = 1
        //            income.alpha = 0
        //            spending.alpha = 1
        //            income.backgroundColor = .green
        spending.isHidden = false
        income.isHidden = true
        
//        segmentControl.selectedSegmentIndex = 0
        
    }
}
   
    func getsumIncome() {
        MoneyCoreData.shared.fetchSpanding()
        bar.reloadInputViews()
    }
//        func popoverDismissed() {
//            getsumIncome()
//            self.navigationController?.dismiss(animated: true)
//        }
        
    
}



