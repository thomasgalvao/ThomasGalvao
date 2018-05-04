//
//  ProductTableViewController.swift
//  ThomasGalvao
//
//  Created by Thomas Galvão on 25/04/2018.
//  Copyright © 2018 Thomas Galvao. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class ProductsTableViewController: UITableViewController {
    var label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 22))
    var fetchedResultController: NSFetchedResultsController<Products>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 106
        tableView.rowHeight = UITableViewAutomaticDimension
        label.text = "Sua lista está vazia!"
        label.textAlignment = .center
        
        loadProducts()
    }
    
    //Indica que dever ordernar por titulo
    func loadProducts() {
        let fetchRequest: NSFetchRequest<Products> = Products.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        do {
            try fetchedResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Table view data source
    
    //Método que define a quantidade de seções de uma tableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Método que define a quantidade de células para cada seção de uma tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = fetchedResultController.fetchedObjects?.count ?? 0
        tableView.backgroundView = count == 0 ? label : nil
        return count
    }
    
    //Método que define a célula que será apresentada em cada linha
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductTableViewCell
        
        guard let product = fetchedResultController.fetchedObjects?[indexPath.row] else{
            return cell
        }
        
        //Carrega o Nome do Produto e o Valor em Dolar
        cell.lbTitle.text = product.title
        cell.lbDolar.text = String(product.dollar)
        //Carrega a Imagem
        if let image = product.cover as? UIImage {
            cell.ivPoster.image = image
        } else {
            cell.ivPoster.image = nil
        }
        
        cell.prepare(with: product)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let product = fetchedResultController.object(at: indexPath)
            context.delete(product)
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - NSFetchedResultsControllerDelegate
extension ProductsTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}

