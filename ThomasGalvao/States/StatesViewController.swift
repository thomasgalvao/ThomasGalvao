//
//  StatesViewController.swift
//  ThomasGalvao
//
//  Created by Thomas Galvão on 05/05/2018.
//  Copyright © 2018 Thomas Galvao. All rights reserved.
//

import UIKit
import CoreData

class StatesViewController: UIViewController {

    var statesManager = StatesManager.shared
    var label = UILabel()
    var formatter = NumberFormatter()
    let config = Configuration.shared
    var state: State!
    var fetchedResultController: NSFetchedResultsController<State>!
    @IBOutlet weak var tfDollar: UITextField!
    @IBOutlet weak var tfIof: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        formartView()
        loadStates()
    }
    
    @IBAction func addEditState(_ sender: Any) {
        showAlert(with: nil)
        loadStates()
    }
   
    
    func showAlert(with state: State? ) {
        
        let title = state == nil ? "Adicionar " : "Adicionar "
        let alert = UIAlertController(title: title + "Estado", message: nil, preferredStyle: .alert )
        
        alert.addTextField {
            (textField) in textField.placeholder = "Nome do Estado"
            if let name = state?.name {
                textField.text = name
            }
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Imposto"
            textField.keyboardType = .decimalPad
            if let tax = state?.tax {
                textField.text = String(tax)
            }
        }
        
        alert.addAction(UIAlertAction(title: title, style: .default, handler: {
            (action) in
            var erros:String = ""
            
            if(alert.textFields?[0].text?.isEmpty == true){
                erros.append("Campo Estado obrigatório \n")
            }
            
            if(alert.textFields?[1].text?.isEmpty == true){
                erros.append("Campo Imposto Obrigatório \n")
            }
            
            if erros.description != "" && erros.description.isEmpty == false {
                self.showMsg(ptitle: "Erro - Atenção",pMsg: erros.description)
            }
            else
            {
                do
                {
                    let state = state ?? State(context: self.context)
                    guard let tax = self.formatter.number(from: (alert.textFields?[1].text!)!)?.doubleValue else { return }
                    
                    state.tax = tax
                    state.name = alert.textFields?[0].text
                    
                    try self.context.save()
                    self.loadStates()
                }
                catch {
                    print()
                }
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    func showMsg(ptitle: String, pMsg: String) {
        
        let alertController = UIAlertController(title: ptitle, message: pMsg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func formartView() {
        tfDollar.text = formatDouble(value: UserDefaults.standard.string(forKey: "dollar")) //TODO
        tfIof.text = formatDouble(value: UserDefaults.standard.string(forKey: "iof"))
    }
    
    func loadStates() {
        statesManager.loadStates(with: context)
        tableView.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func changeDolarQuotation(_ sender: UITextField) {
        UserDefaults.standard.set(formatDouble(value: tfDollar.text), forKey: "dollar")
    }
    
    @IBAction func changeIOFQuotation(_ sender: UITextField) {
        UserDefaults.standard.set(formatDouble(value: tfIof.text), forKey: "iof")
    }
    
   
}

extension StatesViewController : UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(statesManager.states.count == 0) {
            label.text = "Sua lista de estados está vazia"
            label.textAlignment = .center
            tableView.backgroundView = label
            return 0
        } else {
            label.text = ""
            return statesManager.states.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellState", for: indexPath)
        
        state = statesManager.states[indexPath.row]
        cell.textLabel?.text = state.name
        cell.detailTextLabel?.text = String(format: "%.1f", state.tax)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            statesManager.deleteState(index: indexPath.row, context: context)
            tableView.deleteRows(at: [indexPath], with: .fade);
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let state = statesManager.states[indexPath.row]
        showAlert(with: state)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
    func formatDouble(value:String?) -> String?{
        return value?.replacingOccurrences(of: ",", with: ".")
    }
}
