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
        segment = UISegmentedControl(items: array)
        
        
        view.backgroundColor = .lightGray
        view.addSubview(viewScreen)
        view.addSubview(segment)
        viewScreen.backgroundColor = .orange
        
        
        viewScreen.addSubview(spending)
        spending.backgroundColor = .magenta
        
        viewScreen.addSubview(income)
        income.backgroundColor = .yellow
        self.navigationItem.leftBarButtonItem?.isHidden = true
        //        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "back", style: .done, target: self, action: #selector(done))
        //        let nav = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        //        view.addSubview(nav)
        
        let vchome = HomeViewController()
        let navbutton = UIBarButtonItem(title: "back", image: nil, primaryAction: .init(handler: {_ in
            
            if let sheet = UINavigationController(rootViewController: vchome).sheetPresentationController{
                sheet.animateChanges {
                    sheet.selectedDetentIdentifier = .medium
                }
            }
        }))
        navigationItem.leftBarButtonItem = navbutton
        
      
        
        //        navigationItem.leftBarButtonItem = navbutton
        //        navigationController?.navigationBar.setItems([navigationItem], animated: false)
        
        //        navigationController?.navigationBar.topItem?.rightBarButtonItem?.title = "Назад"
        
        //                                        menu: model.addArray()
        
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
        
        
        
        
        //        let direction = UISwipeGestureRecognizer.Direction.down
        ////        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        //        gesture.direction = direction
        //        gesture.delegate = self
        //        view.addGestureRecognizer(gesture)
    }
    
    //    func dismiss(animated: Bool){
    //        let vcHome = HomeViewController()
    //                vcHome.collectionView.reloadData()
    //
    //    }
    
    //    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
    //        let vcHome = HomeViewController()
    //        vcHome.collectionView.reloadData()
    //    }
    
    
    //    @objc func done(){
    //        print("back")
    //        let vc = HomeViewController()
    //        vc.collectionView.reloadData()
    //        self.navigationController?.popViewController(animated: true)
    //    }
    
    //    @objc func swipe(){
    //        print("hello")
    //        let vc = HomeViewController()
    //        vc.collectionView.reloadData()
    //    }
    
    
    //    override func viewDidDisappear(_ animated: Bool) {
    //        super.viewDidDisappear(true)
    //        let vc = HomeViewController()
    //        delegate?.reloudCollection(controller: self)
    //
    //        navigationController?.pushViewController(vc, animated: true)
    //
    //        vc.collectionView.reloadData()
    //        vc.reloadInputViews()
    //        vc.viewDidLayoutSubviews()
    //    }
    
    
    
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
    
//    func getsumIncome(sum: Double) {
//        delegate?.getsumIncome(sum: sum)
//    }
//    
    //    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    //            return true
    //        }
    //
    //        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    //            return false
    //        }
    //
    //        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    //            return true
    //        }
    //
    //        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    //            return true
    //        }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        delegate?.getsumIncome()
        MoneyCoreData.shared.fetchIncome()
        ModalTransitionMediator.instance.sendPopoverDismissed(modelChanged: true)
       
    }
    
   
}
    

