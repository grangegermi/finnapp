//
//  SpendCharts.swift
//  FinnApp
//
//  Created by MAC on 9.11.24.
//

import UIKit
import Charts

class SpendCharts: UIView, ChartViewDelegate, ModalTransitionListener, UITextFieldDelegate {
    
        func popoverDismissed() {
            
        }
        
        var bar = PieChartView()
        var startDate = UILabel()
        var finishDate = UILabel()
        var dateTextStart = UITextField()
        var dateTextFinish = UITextField()
        
        let formatter = DateFormatter()
        
        override init(frame:CGRect) {
            super.init(frame: frame)
            
            
            backgroundColor = .blue
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
            
            var enteries = [ChartDataEntry]()
            var a = Dictionary(grouping: MoneyCoreData.shared.spend.enumerated(), by: {$0.element.image}).mapValues{$0.map{$0.element.totalSpend}}
            
            var b = a.filter{$0.value.count > 1}.values
            let c = MoneyCoreData.shared.spend.map{($0.image, $0.totalSpend)}
            let d = Dictionary(c, uniquingKeysWith: {$0 + $1})
            //        print(d)
            
            
            for x in  d.values{
                enteries.append(ChartDataEntry(x: Double(x),
                                               y: Double(x)))
            }
            
            let set = PieChartDataSet(entries: enteries)
            set.colors = ChartColorTemplates.colorful()
            
            
            let data = PieChartData(dataSet: set)
            bar.data = data
            //
            popoverDismissed()
            MoneyCoreData.shared.fetchSpanding()
            ModalTransitionMediator.instance.setListener(listener: self)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
    }
