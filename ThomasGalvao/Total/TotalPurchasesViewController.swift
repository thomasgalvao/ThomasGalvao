//
//  TotalPurchasesViewController.swift
//  ThomasGalvao
//
//  Created by Thomas Galvão on 04/05/2018.
//  Copyright © 2018 Thomas Galvao. All rights reserved.
//

import UIKit
import CoreData

class TotalPurchasesViewController: UIViewController {

    @IBOutlet var lbTotalDollar: UILabel!
    @IBOutlet var lbTotalReal: UILabel!
    
    var totalDollar: Double = 0
    var totalReal: Double = 0
    
    let config = Configuration.shared
    
    var dataSource: [Product] = []
    var format = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadProducts()
        let dollar = UserDefaults.standard.string(forKey: "dollar") 
        let iof = UserDefaults.standard.string(forKey: "iof")
        
        var results = 0.0
        var sumDollar = 0.0
        dataSource.forEach { (product) in
            if let state = product.state {
                var result = product.dollar + calculateStateTax(value: product.dollar, tax: state.tax)
                
                if product.card {
                    result = result + calculateIOFValue(value: (result), iof: Double(iof!)!)
                }
                sumDollar += product.dollar
                results += result
            }
        }
        
        totalDollar = sumDollar
        totalReal = results * Double(dollar!)!
        
        lbTotalReal.text = String(format: "%.2f", totalReal)
        lbTotalDollar.text = String(format: "%.2f", totalDollar)
    }
    
    func calculateStateTax(value: Double, tax: Double) -> Double {
        return value * (tax / 100)
    }
    
    func calculateIOFValue(value: Double, iof: Double) -> Double {
        return value * (iof / 100)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
    func loadProducts() {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            dataSource = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
}
