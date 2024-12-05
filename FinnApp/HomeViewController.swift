//
//  HomeViewController.swift
//  FinnApp
//
//  Created by Даша Волошина on 25.02.24.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, ModalTransitionListener, TopViewDelegate {
    
    
    
//    var contr :AddController?
    var topView:TopView = TopView(frame: CGRect(origin: .zero, size: .zero))
    lazy var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return  self.createSectionLayout()
        }
    )
    
    var model = MoneyCoreData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MoneyCoreData.shared.fetchSpanding()
        ModalTransitionMediator.instance.setListener(listener: self)
        popoverDismissed()
        
//        collectionView.reloadData()
        self.model.controller = self
       print(MoneyCoreData.shared.logpath())
//        MoneyCoreData.shared.deleteContext()
        
        view.backgroundColor = .blue
        view.addSubview(topView)
        view.addSubview(collectionView)
//        contr?.delegate = self
        collectionView.dataSource =  self
     
        collectionView.delegate = self
        topView.viewIncome?.delegate = self
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.id)
        
        collectionView.register(HeaderCellCollectionViewCell.self, forSupplementaryViewOfKind: HeaderCellCollectionViewCell.kind, withReuseIdentifier: HeaderCellCollectionViewCell.id)
        
        topView.snp.makeConstraints { make in
            
            make.width.equalTo(view.snp.width).multipliedBy(0.8)
            make.height.equalTo(view.snp.height).multipliedBy(0.2)
            make.top.equalTo(view.snp.top).inset(70)
            make.right.equalTo(view.snp.right).inset(40)
            make.left.equalTo(view.snp.left).inset(40)
            
        }
        topView.backgroundColor = .yellow
        topView.layer.cornerRadius = 4
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(250)
            make.bottom.equalTo(view.snp.bottom)
            make.right.equalTo(view.snp.right)
            make.left.equalTo(view.snp.left)
            
        }
    }
//    override func viewWillAppear(_ animated: Bool) {
//        topView.textNameTotal.
//    }
//    func getsumIncome()  {
//        topView.textTotal.reloadInputViews()
//    }
//    override func loadView() {
//        super.loadView()
//        topView.reloadInputViews()
//    }
    
    func getsumIncome() {
        MoneyCoreData.shared.fetchIncome()
        topView.textNameIncome.reloadInputViews()
    }
    
    func popoverDismissed() {
        self.navigationController?.dismiss(animated: true)
       
            collectionView.reloadData()
        topView.gotSum()
//        print(topView.sumIncome)
//        topView.createText()
//        topView.popoverDismissed()
//        getsumIncome()
//        MoneyCoreData.shared.fetchIncome()
//        MoneyCoreData.shared.updatecontext()
    
    }
    
//    func presentModal() {
//        let vc = AddController()
//        vc.delegate = self
//        present(vc, animated: true)
//    }
//    
//    func reloudCollection(controller: UIViewController) {
//        MoneyCoreData.shared.fetchSpanding()
//        MoneyCoreData.shared.fetchIncome()
//        collectionView.reloadData()
//        topView.reloadInputViews()
//    }
  
    
    func createSectionLayout() -> NSCollectionLayoutSection {
        
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
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        //            item.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 10)
        //MARK: -  group
        
        //            let groupItem = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(0.5))
        //
        let groupItem = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.2)), repeatingSubitem: item, count: 2)
        //            groupItem.edgeSpacing = .init(leading: .fixed(10), top: .fixed(10), trailing: .fixed(10), bottom: .fixed(10))
//        groupItem.interItemSpacing = .fixed(30)
        
        
        //MARK: -  Section
        
        let section = NSCollectionLayoutSection(group: groupItem )
//        section.orthogonalScrollingBehavior = .groupPaging
        section.interGroupSpacing = 5
//        section.contentInsets = .init(top: 10, leading: 10, bottom: 0, trailing: 10)
        //            section.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 0)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: HeaderCellCollectionViewCell.kind, alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
        
        //        default:
        //            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        //            item.contentInsets = .init(top: 2, leading: 2, bottom: 2, trailing: 2)
        //            //MARK: -  group
        //
        //            let groupItem = NSCollectionLayoutGroup.vertical(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),heightDimension: .fractionalHeight(1/10)),subitems: [item])
        //
        //
        //            //MARK: -  Section
        //            let section = NSCollectionLayoutSection(group: groupItem )
        //            section.orthogonalScrollingBehavior = .groupPaging
        //            return section
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: HeaderCellCollectionViewCell.kind, withReuseIdentifier:HeaderCellCollectionViewCell.id, for: indexPath) as! HeaderCellCollectionViewCell
        headerView.textHeader.text = "Расходы"
        headerView.textHeader.font = UIFont(name: "Noto Sans Kannada Bold", size: 24)
        headerView.button.setTitle("Смотреть все", for: .normal)
//        headerView.button.backgroundColor = .blue
        headerView.button.setTitleColor(.black, for: .normal)
        headerView.button.titleLabel?.font = UIFont(name: "Noto Sans Kannada Light", size: 16)
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       print( MoneyCoreData.shared.spend.count)
        
        return MoneyCoreData.shared.spend.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = CollectionViewCell()
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.id, for: indexPath) as! CollectionViewCell
//        cell.image.image = UIImage(systemName: "trash")
        cell.image.image = UIImage(systemName: MoneyCoreData.shared.spend[indexPath.row].image ?? "")
       
            cell.textName.text = MoneyCoreData.shared.spend[indexPath.row].name
            cell.textTotal.text = String(MoneyCoreData.shared.spend[indexPath.row].totalSpend)
        
//            self.collectionView.reloadData()
            
        
//            collectionView.reloadItems(at: [indexPath])
        
        
        return cell
    }
}
