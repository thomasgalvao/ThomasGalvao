//
//  StateViewController.swift
//  ThomasGalvao
//
//  Created by Thomas Galvão on 02/05/2018.
//  Copyright © 2018 Thomas Galvao. All rights reserved.
//

import UIKit

enum CategoryType {
    case add
    case edit
}

class StateViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: [State] = []
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - UITableViewDelegate
extension StateViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellState", for: indexPath)
        let state = dataSource[indexPath.row]
        cell.textLabel?.text = state.name
        cell.accessoryType = .none
        if product != nil {
            if let state = state.name, state.contains(state) {
                cell.accessoryType = .checkmark
            }
        }
        return cell
    }
}


