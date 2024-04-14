//
//  MoneyData.swift
//  FinnApp
//
//  Created by Даша Волошина on 24.02.24.
//

import Foundation
import CoreData
import UIKit

class MoneyCoreData {
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context:NSManagedObjectContext  {
     appDelegate.persistentContainer.viewContext
    }
    
    func saveContext () {
        guard let entity = NSEntityDescription.entity(forEntityName: "Money", in: context) else {return}
        let moneyObjeck = Money(entity: entity, insertInto: context)
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    func readContext() -> [Money] {
        
        let fetchRequest = Money.fetchRequest()
        
        do {
           return try context.fetch(fetchRequest)
        }
        catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func createContext(name: String, spending: Double) {
        let money = Money(context: context)
        money.nameSpending = name
        money.spendig = spending
        
        do {
            try context.save()
        }
        catch {
         print(error.localizedDescription)
        }
    }
    
    func updatecontext(){
        
        do{
            try context.save()
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    func deleteContext(money:Money) {
        
       context.delete(money)
        do {
            try context.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    
}
