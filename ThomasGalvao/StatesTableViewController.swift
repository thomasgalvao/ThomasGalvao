//
//  StatesTableViewController.swift
//  ThomasGalvao
//
//  Created by Thomas Galvão on 04/05/2018.
//  Copyright © 2018 Thomas Galvao. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class StatesTableViewController: UITableViewController {
    var label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 22))
    var fetchedResultController: NSFetchedResultsController<States>!
    var statesManager = StatesManager.shared
    var formatter = NumberFormatter()
    let config = Configuration.shared
    var states: [States]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 106
        tableView.rowHeight = UITableViewAutomaticDimension
        
        label.text = "Sua lista está vazia!"
        label.textAlignment = .center
        
        loadStates()
    }
    
    @IBAction func addEditState(_ sender: Any) {
        showAlert(with: nil)
        loadStates()
    }
    
    func showAlert(with state: States? ) {
        
        let title = state == nil ? "Add " : "Edit "
        let alert = UIAlertController(title: title + "State", message: nil, preferredStyle: .alert )
        
        alert.addTextField {
            (textField) in textField.placeholder = "Name Of State"
            if let name = state?.name {
                textField.text = name
            }
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Tax"
            textField.keyboardType = .decimalPad
            if let tax = state?.tax {
                textField.text = String(tax)
            }
        }
        
        alert.addAction(UIAlertAction(title: title, style: .default, handler: {
            (action) in let state = state ?? States(context: self.context)
            state.name = alert.textFields?.first?.text
            
            guard let tax = self.formatter.number(from: (alert.textFields?[1].text!)!)?.doubleValue else { return }
            state.tax = tax
            
            do {
                try self.context.save()
                self.loadStates()
            } catch {
                print(error.localizedDescription)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.view.tintColor = UIColor(named: "second")
        present(alert, animated: true, completion: nil)
        
    }
    
    func loadStates() {
        statesManager.loadStates(with: context)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(statesManager.states.count == 0) {
            label.text = "Sua lista de estados está vazia"
            label.textAlignment = .center
            tableView.backgroundView = label
            return 0
        } else {
            label.text = " "
            tableView.backgroundView = label
            return statesManager.states.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellStates", for: indexPath)
        
        //states = statesManager.states[indexPath.row]
        //cell.prepare(with: states)
        return cell
    }
    //
//    func loadStates() {
//        let fetchRequest: NSFetchRequest<States> = States.fetchRequest()
//        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
//
//        fetchRequest.sortDescriptors = [sortDescriptor]
//        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
//        fetchedResultController.delegate = self
//        do {
//            try fetchedResultController.performFetch()
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
    
    // MARK: - Table view data source
    
    //Método que define a quantidade de seções de uma tableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let states = fetchedResultController.object(at: indexPath)
            context.delete(states)
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
 //   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "viewSegue" {
//            let vc = segue.destination as! StatesViewController
//            if let states = fetchedResultController.fetchedObjects {
//                states = states[tableView.indexPathForSelectedRow!.row]
//            }
//        }


// MARK: - Extensions
