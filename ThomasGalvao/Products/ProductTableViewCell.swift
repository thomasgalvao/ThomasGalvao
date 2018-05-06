//
//  ProductTableViewCell.swift
//  ThomasGalvao
//
//  Created by Thomas Galvão on 25/04/2018.
//  Copyright © 2018 Thomas Galvao. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var ivCover: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDollar: UILabel!
    
    @IBOutlet weak var viewCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func prepare(with product: Product) {
        
        viewCell.layer.cornerRadius = self.ivCover.frame.size.width / 2

        lbTitle.text = product.title ?? ""
        lbDollar.text = "U$ "+String(format: "%.2f", product.dollar)
        if let image = product.cover as? UIImage{
            ivCover.image = image
        } else {
            ivCover.image = UIImage(named: "cover")
        }
        self.ivCover.layer.cornerRadius = self.ivCover.frame.size.width / 2
        self.ivCover.clipsToBounds = true
    }

}
