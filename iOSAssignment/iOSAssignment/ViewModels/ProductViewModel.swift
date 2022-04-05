//
//  ProductViewModel.swift
//  iOSAssignment
//
//  Created by Aashish Tyagi on 4/5/22.
//

import Foundation
import CoreData
import UIKit

struct ProductViewModel {
    
    let product: Product
    
    var id: NSManagedObjectID {
        return product.objectID
    }
    
    var name: String {
        return product.name ?? ""
    }
    
    var productImage:UIImage {
        guard  let image =  UIImage(data: product.productImg ?? Data()) else { return UIImage(named: "placeholderImg")! }
        return image
    }
    
    var descriptions: String {
        return product.descriptions ?? ""
    }
    
    var salePrice: String {
        return "\(product.salePrice)"
    }
    
    var regularPrice: String {
        return "\(product.regularPrice)"
    }
}
