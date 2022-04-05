//
//  ProductListViewModel.swift
//  iOSAssignment
//
//  Created by Aashish Tyagi on 4/5/22.
//

import Foundation
import CoreData

class ProductListViewModel {
    private var products = [ProductViewModel]()
    
    init() {}
    
    func fetchProducts( complition: @escaping(()-> Void)) {
        let products: [Product] = Product.all()
        self.products = products.map({ProductViewModel.init(product: $0)})
        complition()
    }
    
    func deleteProduct(product: ProductViewModel) {
        let product: Product? = Product.byId(id: product.id)
        if let product = product {
            product.delete()
        }
    }
}

extension ProductListViewModel {
    
    func numberOfRows() -> Int {
        return self.products.count
    }
    
    func itemAtIndex(index:Int) -> ProductViewModel {
        return self.products[index]
    }
}

