//
//  AddController.swift
//  FinnApp
//
//  Created by Даша Волошина on 14.04.24.
//

import UIKit
import SnapKit

//protocol HomeDelegate:AnyObject {
//    
//    func reloudCollection(controller:UIViewController)
//}

protocol TopViewDelegate: AnyObject {
    func getsumIncome() 
}

protocol ModalTransitionListener {
    func popoverDismissed()
}

class ModalTransitionMediator {
    /* Singleton */
    class var instance: ModalTransitionMediator {
        struct Static {
            static let instance: ModalTransitionMediator = ModalTransitionMediator()
        }
        return Static.instance
    }

private var listener: ModalTransitionListener?

private init() {

}

func setListener(listener: ModalTransitionListener) {
    self.listener = listener
}

func sendPopoverDismissed(modelChanged: Bool) {
    listener?.popoverDismissed()
}
}

class AddController: UIViewController, UIGestureRecognizerDelegate  {
 
    
    weak var delegate:TopViewDelegate?
 
    var model = Model()
    var segment = UISegmentedControl()
    var income = IncomeView()
    var spending = SpendView()
    var array = ["Доход", "Расход"]
    var viewScreen  = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(MoneyCoreData.shared.logpath())
        
        model.viewController = self
        model.addArray()
        segment = UISegmentedControl(items: array)
        
        
        view.backgroundColor = .lightGray
        view.addSubview(viewScreen)
        view.addSubview(segment)
        viewScreen.backgroundColor = .orange
        
        
        viewScreen.addSubview(spending)
        spending.backgroundColor = .magenta
        
        viewScreen.addSubview(income)
        income.backgroundColor = .yellow
//        self.navigationItem.leftBarButtonItem?.isHidden = true
        //        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "back", style: .done, target: self, action: #selector(done))
        //        let nav = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        //        view.addSubview(nav)
        
//        let vchome = HomeViewController()
//        let navbutton = UIBarButtonItem(title: "back", image: nil, primaryAction: .init(handler: {_ in
//            
//            if let sheet = UINavigationController(rootViewController: vchome).sheetPresentationController{
//                sheet.animateChanges {
//                    sheet.selectedDetentIdentifier = .medium
//                }
//            }
//        }))
//        navigationItem.leftBarButtonItem = navbutton
   
        
        segment.backgroundColor = .yellow
        segment.selectedSegmentTintColor = .white
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(goToScreen), for: .valueChanged)
        
        
        
        segment.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(20)
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
            make.height.equalTo(view.snp.height).multipliedBy(0.1/2)
            make.left.right.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        viewScreen.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(50)
            make.bottom.equalTo(view.snp.bottom)
            make.left.right.equalToSuperview()
            make.right.equalToSuperview()
            
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
        
        if  segment.selectedSegmentIndex == 0 {
            spending.isHidden = true
            income.isHidden = false
            //            income.alpha = 1
            //            spending.alpha = 0
            //            income.backgroundColor = .magenta
            
            
            
        } else {
            //            income.alpha = 0
            //            spending.alpha = 1
            //            income.backgroundColor = .green
            income.isHidden = true
            spending.isHidden = false
            
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        delegate?.getsumIncome()

        MoneyCoreData.shared.fetchIncome()
        MoneyCoreData.shared.fetchSpanding()
        ModalTransitionMediator.instance.sendPopoverDismissed(modelChanged: true)
       
    }
    
   
}
    

