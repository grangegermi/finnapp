//
//  IncomeCharts.swift
//  FinnApp
//
//  Created by MAC on 9.11.24.
//

import UIKit
import Charts
import SnapKit

class IncomeCharts: UIView, ChartViewDelegate, ModalTransitionListener, UITextFieldDelegate {
    func popoverDismissed() {
        
    }
    
    
    var bar = PieChartView()
    var startDate = UILabel()
    var finishDate = UILabel()
    var dateTextStart = UITextField()
    var dateTextFinish = UITextField()
    var dateTrackerStart = UIDatePicker()
    var dateTrackerFinish = UIDatePicker()
    
    let formatter = DateFormatter()
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        
       
        backgroundColor = .green
        self.addSubview(bar)
        bar.delegate = self
        
        dateTextStart.delegate = self
        dateTextFinish.delegate = self
        
        self.addSubview(startDate)
        self.addSubview(finishDate)
        self.addSubview(dateTextStart)
        self.addSubview(dateTextFinish)
        createCharts()
        createConstraints()
        createText()
        createTextField ()
        createDate()
    }
    
    func createDate(){
        dateTrackerStart.datePickerMode = .date
        dateTrackerStart.preferredDatePickerStyle = .wheels
        let currentDateTime = Date()
        formatter.dateFormat = "MM/dd/yyyy"
        dateTextStart.inputView = dateTrackerStart
        dateTextStart.text = formatter.string(from: currentDateTime)
        dateTrackerStart.addTarget(self, action: #selector(trackerStart), for: UIControl.Event.allEvents)
        
        dateTrackerFinish.datePickerMode = .date
        dateTrackerFinish.preferredDatePickerStyle = .wheels
        let currentDateTime2 = Date()
        formatter.dateFormat = "MM/dd/yyyy"
        formatter.timeZone = .current
        dateTextFinish.inputView = dateTrackerFinish
        dateTextFinish.text = formatter.string(from: currentDateTime)
        dateTrackerFinish.addTarget(self, action: #selector(trackerFinish), for: UIControl.Event.allEvents)
    }
    
    func createConstraints() {
        
        startDate.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).inset(20)
//            make.right.equalTo(self.snp.right).inset(-20)
            make.top.equalTo(self.snp.top).inset(20)
        }
        
        dateTextStart.snp.makeConstraints { make in
            make.left.equalTo(startDate.snp.left).inset(20)
            make.right.equalTo(self.snp.right).offset(-20)
            make.top.equalTo(startDate.snp.top).offset(40)
            make.height.equalTo(self.snp.height).multipliedBy(0.06)
        }
        
        finishDate.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).inset(20)
//            make.right.equalTo(self.snp.right).inset(-20)
            make.top.equalTo(dateTextStart.snp.top).offset(80)
        }
        
        dateTextFinish.snp.makeConstraints { make in
            make.left.equalTo(finishDate.snp.left).inset(20)
            make.right.equalTo(self.snp.right).offset(-20)
            make.top.equalTo(finishDate.snp.top).offset(40)
            make.height.equalTo(self.snp.height).multipliedBy(0.06)
        }
        
        bar.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(dateTextFinish.snp.top).inset(0.5)
            make.bottom.equalToSuperview().offset(0.5)
        }
        
    }
    
    func createText() {
        startDate.text = "Start"
        finishDate.text = "Finish"
    }
    
    @objc func trackerStart(dateTracker: UIDatePicker) {
       
        dateTextStart.text = formatter.string(from: dateTrackerStart.date)
        self.endEditing(true)
    }
    
    @objc func trackerFinish(dateTracker: UIDatePicker) {
       
        dateTextFinish.text = formatter.string(from: dateTrackerFinish.date)
        self.endEditing(true)
    }
    
    func createTextField (){
        
        dateTextStart.placeholder  = "Start date"
        dateTextStart.backgroundColor = .white
        dateTextStart.layer.cornerRadius = 10
        dateTextStart.setLeftPaddingPoints(10)
        
        dateTextFinish.placeholder = "Finish date"
        dateTextFinish.backgroundColor = .white
        dateTextFinish.layer.cornerRadius = 10
        dateTextFinish.setLeftPaddingPoints(10)
    }
    
    func createCharts(){
        MoneyCoreData.shared.fetchSpanding()
        //        bar.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.width)
        //        bar.center = self.center
        //        self.backgroundColor = .white
        //        print(Date.now)

        var current = Date()
        if dateTextStart.text == formatter.string(for: current){
            
            //         var dateSorted1 = MoneyCoreData.shared.income.map{$0.incomeDate == Date.now}
            
//            
            var enteries1 = [ChartDataEntry]()
            //            var chart = sortedDate2.map{$0.incomeSum}
            var c1 = MoneyCoreData.shared.income.filter{$0.incomeDate! == formatter.date(from: dateTextStart.text!)}
            print(c1)
            var b1 = c1.map{$0.incomeSum}.reduce(0, +)
//            print(b1)
            for x in [b1] {
                enteries1.append(ChartDataEntry(x: Double(x),
                                                y: Double(x)))
            }
            
            let set1 = PieChartDataSet(entries: enteries1)
            set1.colors = ChartColorTemplates.liberty()
            
            
            let data1 = PieChartData(dataSet: set1)
            bar.data = data1
        }
           
    
            
            var sortedDate = MoneyCoreData.shared.income.filter{$0.incomeDate! >= dateTrackerStart.date && $0.incomeDate! <= dateTrackerFinish.date}
      
            //        print(sortedDate)
            //        var a = MoneyCoreData.shared.income.map{($0.incomeDate, $0.incomeSum)}
            //        print(a)
            //        if dateTextStart.text{
            var enteries = [ChartDataEntry]()
            var chart = sortedDate.map{$0.incomeSum}
            var c = chart.reduce(0, +)
//        print (MoneyCoreData.shared.income)
            for x in [Double(c)] {
                enteries.append(ChartDataEntry(x: Double(x),
                                               y: Double(x)))
            }
            
            let set = PieChartDataSet(entries: enteries)
            set.colors = ChartColorTemplates.colorful()
            
            
            let data = PieChartData(dataSet: set)
            bar.data = data
            //        }
            //        MoneyCoreData.shared.income.enumerated().map{$0.element.incomeDate}
            
            //        var a = Dictionary(grouping: MoneyCoreData.shared.spend.enumerated(), by: {$0.element.image}).mapValues{$0.map{$0.element.totalSpend}}
            //
            //        var b = a.filter{$0.value.count > 1}.values
            //        let c = MoneyCoreData.shared.spend.map{($0.image, $0.totalSpend)}
            //        let d = Dictionary(c, uniquingKeysWith: {$0 + $1})
            ////        print(d)
            
            
            
            //
         
        
        popoverDismissed()
        MoneyCoreData.shared.fetchSpanding()
        ModalTransitionMediator.instance.setListener(listener: self)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
