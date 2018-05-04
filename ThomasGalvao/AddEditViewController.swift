//
//  AddEditViewController.swift
//  ThomasGalvao
//
//  Created by Thomas Galvão on 03/05/2018.
//  Copyright © 2018 Thomas Galvao. All rights reserved.
//

import UIKit

class AddEditViewController: UIViewController {

    
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var ivCover: UIImageView!
    @IBOutlet weak var tfState: UITextField!
    @IBOutlet weak var tfDolar: UITextField!
    @IBOutlet weak var swCard: UISwitch!
    @IBOutlet weak var lbButton: UIButton!
    
    var products: Products!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btAddEditCover(_ sender: UIButton) {
        
    }
    
    @IBAction func addEditProduct(_ sender: UIButton) {
        if products == nil {
            products = Products(context: context)
        }
        
        //seta os dados no coredata
        products.title = tfTitle.text
        if let dolar = Double(tfDolar.text!) {
            products.dollar = dolar
        }
        products.cover = ivCover.image as UIImage?
        products.card = swCard.isOn
        products.states?.name = tfState.text
        
        //Persistes os dados.
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
        navigationController?.popViewController(animated: true)
    }
}
