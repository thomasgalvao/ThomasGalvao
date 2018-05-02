//
//  StateTableViewCell.swift
//  ThomasGalvao
//
//  Created by Thomas Galvão on 01/05/2018.
//  Copyright © 2018 Thomas Galvao. All rights reserved.
//

import UIKit

class StateTableViewCell: UITableViewCell {

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

    func prepare(with state: State) {
        lbState.text = state.name
        //lbTax.text = state.tax
    }
}
