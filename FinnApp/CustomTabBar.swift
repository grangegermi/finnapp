//
//  CustomTabBar.swift
//  FinnApp
//
//  Created by Даша Волошина on 11.04.24.
//

import UIKit

class CustomTabBar: UITabBar {

    var  button = UIButton()
//    
    override func draw(_ rect: CGRect) {
        let shape = CAShapeLayer()
        let path1 = UIBezierPath()
            path1.move(to: CGPoint(x: 0, y: 0))
            
        path1.addLine(to: CGPoint(x: rect.width/2-30, y: 0))
            path1.addArc(withCenter: CGPoint(x:rect.width/2 , y: 0), radius: 30, startAngle: .pi, endAngle: .pi*2, clockwise: false)
            
        path1.addLine(to: CGPoint(x: rect.width, y: 0))
        path1.addLine(to: CGPoint(x:rect.width , y:rect.height ))
        path1.addLine(to: CGPoint(x:0, y:rect.height ))
//        path1.close()
        
        shape.path = path1.cgPath
        layer.insertSublayer(shape, at: 0)
        shape.fillColor = UIColor.colorTabBar.cgColor
        button.frame = CGRect(x: rect.midX - 25, y: -25, width: 50, height: 50)
    }
    override init(frame:CGRect){
        super.init(frame: frame)
        createButton()
        addSubview(button)
        itemPositioning = .centered
        itemSpacing = UIScreen.main.bounds.width / 10
        tintColor = UIColor.colorSelectedItem
        unselectedItemTintColor = UIColor.colorUnselectedItem

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func createButton(){
        button.backgroundColor = UIColor.colorTabBar
//        button.layer.borderColor = UIColor.white.cgColor
//        button.layer.borderWidth = 4
//
    
        button.layer.cornerRadius = 25
//        button.center.x = self.center.x
        button.setImage(UIImage(systemName:"plus"), for: .normal)
       
    }
    
   
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        button.frame.contains(point) ? button: super.hitTest(point, with: event)
    }
}

    

