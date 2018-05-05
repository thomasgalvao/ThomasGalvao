//
//  StatesTableViewCell.swift
//  ThomasGalvao
//
//  Created by Thomas Galvão on 04/05/2018.
//  Copyright © 2018 Thomas Galvao. All rights reserved.
//

import UIKit

class StatesTableViewCell: UITableViewCell {

    @IBOutlet weak var lbState: UILabel!
    @IBOutlet weak var lbTax: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with product: Product) {
        lbState.text = product.state?.name ?? ""
        lbTax.text = "U$ \(String(describing: product.state?.tax))"
    }
}
