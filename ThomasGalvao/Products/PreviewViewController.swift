//
//  PreviewViewController.swift
//  ThomasGalvao
//
//  Created by Thomas Galvão on 04/05/2018.
//  Copyright © 2018 Thomas Galvao. All rights reserved.
//

import UIKit
import CoreData

class PreviewViewController: UIViewController {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var ivCover: UIImageView!
    @IBOutlet weak var lbState: UILabel!
    @IBOutlet weak var lbDollar: UILabel!
    @IBOutlet weak var lbCardYesNo: UILabel!
    
    var product: Products!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadProducts()
    }
    
    func loadProducts() {
        lbTitle.text = product.title
        
        if let image = product.cover as? UIImage {
            ivCover.image = image
        } else {
            ivCover.image = UIImage(named: "cover")
        }
        
        lbState.text = product.states?.name
        
        let dollar = String(product.dollar)
        lbDollar.text = "US$ \(dollar)"
        
        if product.card {
            lbCardYesNo.text = "Sim"
        } else {
            lbCardYesNo.text = "Não"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddEditViewController
        vc.product = product
    }

}
