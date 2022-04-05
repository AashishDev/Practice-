//
//  ProductsViewController.swift
//  iOSAssignment
//
//  Created by Aashish Tyagi on 4/5/22.
//

import UIKit

class ProductsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let productListVM = ProductListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchProductsData()
    }
    
    private func fetchProductsData() {
        productListVM.fetchProducts { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    @IBAction func addNewProductButtonTapped(_ sender: UIBarButtonItem) {
        
        guard  let addProductController = self.storyboard?.instantiateViewController(withIdentifier: "AddProductViewController") as? AddProductViewController else  { return }
        self.navigationController?.pushViewController(addProductController, animated: true)
    }
}

extension ProductsViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as? ProductTableViewCell else { return UITableViewCell() }
        
        let product = productListVM.itemAtIndex(index: indexPath.row)
        cell.configure(with: product)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productListVM.numberOfRows()
    }
}


extension ProductsViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let product = productListVM.itemAtIndex(index: indexPath.row)
        moveToUpdateProductScreen(item:product)
    }
   
    private func moveToUpdateProductScreen(item:ProductViewModel) {
        guard  let addProductVC = self.storyboard?.instantiateViewController(withIdentifier: "AddProductViewController") as? AddProductViewController else  { return }
        
        addProductVC.product = item
        addProductVC.isEditMode = true
        self.navigationController?.pushViewController(addProductVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let product = productListVM.itemAtIndex(index: indexPath.row)
        
        if editingStyle == .delete {
            productListVM.deleteProduct(product: product)
            fetchProductsData()
        }
    }
    
}

