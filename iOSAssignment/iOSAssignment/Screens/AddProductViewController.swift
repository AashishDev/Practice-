//
//  AddProductViewController.swift
//  iOSAssignment
//
//  Created by Aashish Tyagi on 4/5/22.
//

import UIKit

class AddProductViewController: UIViewController {
    var imagePicker: ImagePicker!

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var salePriceTF: UITextField!
    @IBOutlet weak var regularPriceTF : UITextField!
    @IBOutlet weak var productImgView : UIImageView!

    
    @IBOutlet weak var createButton: UIButton!
    var isEditMode:Bool =  false
    private var addProductVM =  AddProductViewModel()
    var product:ProductViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        createButton.layer.cornerRadius = 4.0
        
        if isEditMode {
            configureEditModeDetails()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    private func configureEditModeDetails(){
        self.title = "Update Product"
        createButton.setTitle("Update", for: .normal)
        
        guard let product = product else {
            return
        }
        
        nameTF.text = product.name
        descriptionTF.text = product.descriptions
        salePriceTF.text = product.salePrice
        regularPriceTF.text = product.regularPrice
        productImgView.image =  product.productImage
    }
    
    
    @IBAction func didSelectProductImage(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    
    @IBAction func createUpdateButtonTapped(_ sender: UIButton) {
        
        addProductVM.name = nameTF.text ?? ""
        addProductVM.description =  descriptionTF.text ?? ""
        addProductVM.salePrice  =  salePriceTF.text ?? ""
        addProductVM.regularPrice =  regularPriceTF.text ?? ""
        addProductVM.productImage = productImgView.image ?? UIImage(named: "placeholderImg")!
        
        isEditMode ? updateProduct() : saveProduct()
    }
    
    private func saveProduct() {
        
        addProductVM.save { [weak self]  success in
            if success {
                self?.navigationController?.popViewController(animated: true)
            }
            else {
                self?.showErrorAlert()
            }
        }
    }
    
    private func updateProduct() {
        guard let product = product else {
            return
        }
        addProductVM.update(id: product.id) { [weak self] success in
            if success {
                self?.navigationController?.popViewController(animated: true)
            }
            else {
                self?.showErrorAlert()
            }
        }
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Alert", message: "Please enter all values", preferredStyle:.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}

extension AddProductViewController: ImagePickerDelegate {
   
    func didSelect(image: UIImage?) {
        guard let image =  image else { return }
        productImgView.image = image
    }
}
