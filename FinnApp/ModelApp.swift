//
//  ModelApp.swift
//  FinnApp
//
//  Created by MAC on 13.05.24.
//

import Foundation
import UIKit

class Model {
    
    weak var viewController : AddController?
    var defaults = UserDefaults.standard
    
//    var imageArray = [ "house",
//                       "network",
//                       "car",
//                       "bus",
//                       "tram",
//                       "bicycle",
//                       "fuelpump",
//                       "ev.charger",
//                       "airplane",
//                       "figure.strengthtraining.traditional",
//                       "gamecontroller",
//                       "figure.cooldown",
//                       "pawprint",
//                       "leaf",
//                       "phone.badge.waveform",
//                       "book.closed",
//                       "graduationcap",
//                       "backpack",
//                       "cart",
//                       "creditcard",
//                       "pianokeys",
//                       "paintbrush",
//                       "paintbrush.pointed",
//                       "hammer",
//                       "stethoscope",
//                       "theatermasks",
//                       "suitcase.cart",
//                       "stroller",
//                       "pill",
//                       "teddybear",
//                       "tshirt",
//                       "shoe",
//                       "comb",
//                       "cup.and.saucer",
//                       "gift",
//                       "av.remote",
//                       "tv"
//    ]
    
//    var iconModel = [Icons]() {
//        didSet {
//            self.viewController?.collectionView.reloadData()
//        }
//    }
    
    init(){}
    
    func addArray(){
//        MoneyCoreData.shared.deleteContextIcons()
        if defaults.bool(forKey: "First Launch") == true {
            
            MoneyCoreData.shared.fetchIcon()

            defaults.setValue(true, forKey: "First Launch")
        }
        else{
            
            MoneyCoreData.shared.createImage(image: "house")
            MoneyCoreData.shared.createImage(image: "network")
            MoneyCoreData.shared.createImage(image: "car")
            MoneyCoreData.shared.createImage(image: "bus")
            MoneyCoreData.shared.createImage(image: "tram")
            MoneyCoreData.shared.createImage(image: "fuelpump")
            MoneyCoreData.shared.createImage(image: "ev.charger")
            MoneyCoreData.shared.createImage(image: "airplane")
            MoneyCoreData.shared.createImage(image: "figure.strengthtraining.traditional")
            MoneyCoreData.shared.createImage(image: "gamecontroller")
            MoneyCoreData.shared.createImage(image: "figure.cooldown")
            MoneyCoreData.shared.createImage(image: "pawprint")
            MoneyCoreData.shared.createImage(image: "leaf")
            MoneyCoreData.shared.createImage(image: "phone.badge.waveform")
            MoneyCoreData.shared.createImage(image: "book.closed")
            MoneyCoreData.shared.createImage(image: "backpack")
            MoneyCoreData.shared.createImage(image: "cart")
            MoneyCoreData.shared.createImage(image: "creditcard")
            MoneyCoreData.shared.createImage(image: "pianokeys")
            MoneyCoreData.shared.createImage(image: "paintbrush")
            MoneyCoreData.shared.createImage(image: "hammer")
            MoneyCoreData.shared.createImage(image: "stethoscope")
            MoneyCoreData.shared.createImage(image: "theatermasks")
            MoneyCoreData.shared.createImage(image: "suitcase.cart")
            MoneyCoreData.shared.createImage(image: "stroller")
            MoneyCoreData.shared.createImage(image: "pill")
            MoneyCoreData.shared.createImage(image: "teddybear")
            MoneyCoreData.shared.createImage(image: "tshirt")
            MoneyCoreData.shared.createImage(image: "shoe")
            MoneyCoreData.shared.createImage(image: "comb")
            MoneyCoreData.shared.createImage(image: "cup.and.saucer")
            MoneyCoreData.shared.createImage(image: "gift")
            MoneyCoreData.shared.createImage(image: "display")
            MoneyCoreData.shared.createImage(image: "phone")
            MoneyCoreData.shared.createImage(image: "wifi")
            MoneyCoreData.shared.createImage(image: "cross.case")
//            MoneyCoreData.shared.createImage(image: "laptopcomputer")
            

            defaults.setValue(true, forKey: "First Launch")
            
        }
    }
}
