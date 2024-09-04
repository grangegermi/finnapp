//
//  MoneyData.swift
//  FinnApp
//
//  Created by Даша Волошина on 24.02.24.
//

import Foundation
import CoreData
import UIKit

class MoneyCoreData: NSObject {
    
    static let shared = MoneyCoreData()
     
    weak var controller: HomeViewController?
    var arrayIcons = [Icons]()
    var spend: [Spending]   = []
//    = [] {
//        didSet {
//            DispatchQueue.main.async {
//                self.controller?.collectionView.reloadData()
//            }
//        }
//    }
    
    var income = [Income]()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FinnModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    override init(){}
    
    func saveContext () {
        let spendContext = persistentContainer.viewContext
        if spendContext.hasChanges {
            do {
                try spendContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
//MARK:// Spending
    
  
    
    func createSpending(name:String,image:String?, totalSpend:Double, date:Date) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Spending", in: persistentContainer.viewContext) else {return}
        
        let spending = Spending(entity:entityDescription, insertInto: persistentContainer.viewContext)
        spending.image = image
        spending.date = date
        spending.totalSpend = totalSpend
        spending.name = name
        
        do {
            try persistentContainer.viewContext.save()
            spend.append(spending)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    func fetchSpanding() {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Spending")
        
        do {
            spend = try! context.fetch(fetchRequest) as! [Spending]
     
           
        }
    }
    
    //MARK:// Image
    
    func createImage(image:String){
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Icons", in: persistentContainer.viewContext) else {return}
         let icon = Icons(entity:entityDescription, insertInto: persistentContainer.viewContext)
        icon.image = image
//        arrayIcons.append(icon)
        fetchIcon()
        do {
            
            try persistentContainer.viewContext.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchIcon(){
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Icons")
       
        do {
             arrayIcons = try! context.fetch(fetchRequest) as! [Icons]
        }
    }
    
//MARK:// INCOME
    
    func createContextIncome(incomeSum:Double, date:Date) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Income", in: persistentContainer.viewContext) else {return}
        
        let income = Income(entity:entityDescription, insertInto: persistentContainer.viewContext)
        income.incomeDate = date
        income.incomeSum = incomeSum
        
        do {
            try persistentContainer.viewContext.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchIncome(){
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Income")
       
        do {
             income = try! context.fetch(fetchRequest) as! [Income]
            
        }
    }
    
    func deleteIncome() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Income")
        
        do {
            let income = try? persistentContainer.viewContext.fetch(fetchRequest) as? [Income]
            income?.forEach { persistentContainer.viewContext.delete($0)}
            
            try persistentContainer.viewContext.save()
        }
        
        catch{
            print(error.localizedDescription)
        }
    }
    
    func updatecontext(){
        
        do{
            try persistentContainer.viewContext.save()
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    func deleteContext() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Spending")
        
        do {
            let spends = try? persistentContainer.viewContext.fetch(fetchRequest) as? [Spending]
            spends?.forEach { persistentContainer.viewContext.delete($0)}
            
            try persistentContainer.viewContext.save()
        }
        
        catch{
            print(error.localizedDescription)
        }
    }
    
    func deleteContextIcons() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Icons")
        
        do {
            let icons = try? persistentContainer.viewContext.fetch(fetchRequest) as? [Icons]
            icons?.forEach { persistentContainer.viewContext.delete($0)}
            
            try persistentContainer.viewContext.save()
        }
        
        catch{
            print(error.localizedDescription)
        }
    }
    
    func logpath(){
        var app = UIApplication.shared.delegate  as! AppDelegate
        if let url = persistentContainer.persistentStoreCoordinator.persistentStores.first?.url{
            print("DB url - \(url)")
        }
    }
}
