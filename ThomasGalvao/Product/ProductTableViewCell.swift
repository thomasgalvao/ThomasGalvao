//
//  ProductTableViewCell.swift
//  ThomasGalvao
//
//  Created by Thomas Galvão on 25/04/2018.
//  Copyright © 2018 Thomas Galvao. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDolar: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with product: Product) {
        lbTitle.text = product.title ?? ""
        //lbDolar. = Double(product.dolar!)!
        
        if let image = product.poster as? UIImage{
            ivPoster.image = image
        } else {
            ivPoster.image = UIImage(named: "product")
        }
    }

}
