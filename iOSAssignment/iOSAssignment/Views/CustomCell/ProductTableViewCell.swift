//
//  ProductTableViewCell.swift
//  iOSAssignment
//
//  Created by Aashish Tyagi on 4/5/22.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    static let identifier = "ProductTableViewCell"
    
    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var salePriceLabel: UILabel!
    @IBOutlet weak var regularPriceLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 8.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with viewModel:ProductViewModel) {
        
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.descriptions
        salePriceLabel.text = "Sale Price: " + viewModel.salePrice
        regularPriceLabel.text = "Regular Price: " + viewModel.regularPrice
        productImage.image = viewModel.productImage
    }
}
