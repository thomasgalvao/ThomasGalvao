//
//  StatesViewController.swift
//  ThomasGalvao
//
//  Created by Thomas Galvão on 04/05/2018.
//  Copyright © 2018 Thomas Galvao. All rights reserved.
//

import UIKit
import CoreData

class StatesViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    var statesManager = StatesManager.shared
    var label = UILabel()
    var formatter = NumberFormatter()
    let config = Configuration.shared
    var states: [States]!
    
    @IBOutlet weak var tfDollar: UITextField!
    @IBOutlet weak var tfIof: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formartView()
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
    
    func formartView() {
        tfDollar.text = UserDefaults.standard.string(forKey: "dollar")
        tfIof.text = UserDefaults.standard.string(forKey: "iof")
    }
    
    func save() {
        UserDefaults.standard.set(tfDollar.text, forKey: "dollar")
        UserDefaults.standard.set(tfIof.text, forKey: "iof")
    }
    
    func loadStates() {
        statesManager.loadStates(with: context)
        //tableView.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        save()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellStates", for: indexPath)
        
        //states = statesManager.states[indexPath.row]
        //cell.prepare(with: states)
        return cell
    }
}


