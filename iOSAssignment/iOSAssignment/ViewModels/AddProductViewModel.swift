//
//  AddProductViewModel.swift
//  iOSAssignment
//
//  Created by Aashish Tyagi on 4/5/22.
//

import Foundation
import CoreData
import UIKit

class AddProductViewModel {
    var name: String = ""
    var description: String = ""
    var salePrice: String = ""
    var regularPrice: String = ""
    var productImage:UIImage = UIImage(named: "placeholderImg")!

    init() {}
    
    func validate() -> Bool {
        if name.isEmpty || description.isEmpty || salePrice.isEmpty || regularPrice.isEmpty {
            return false
        }
        return true
    }
    
    func save(complition: @escaping((_ success:Bool)-> Void)) {
        
        if validate() {
            let product = Product(context: Product.viewContext)
            product.name = name
            product.descriptions = description
            product.salePrice = Double(salePrice) ?? 0.0
            product.regularPrice = Double(regularPrice) ?? 0.0
            product.productImg = productImage.pngData()
            product.save()
            complition(true)
        }
        else {
            complition(false)
            print("Show Error Alert: Fill All Value")
        }
    }
    
    func update(id:NSManagedObjectID,complition: @escaping((_ success:Bool)-> Void)) {
        
        if validate() {
            
            guard let product =  Product.byId(id: id) as? Product else { return }
            product.name = name
            product.descriptions = description
            product.salePrice = Double(salePrice) ?? 0.0
            product.regularPrice = Double(regularPrice) ?? 0.0
            product.productImg = productImage.pngData()
            product.save()
            complition(true)
        }
        else {
            complition(false)
            print("Show Error Alert: Fill All Value")
        }
    }
    
}
