//
//  ShoppingViewController.swift
//  ThomasGalvao
//
//  Created by Thomas Galvão on 18/04/2018.
//  Copyright © 2018 Thomas Galvao. All rights reserved.
//

import UIKit
import CoreMotion

class AddEditViewController: UIViewController {
    
    @IBOutlet weak var tfProductName: UITextField!
    @IBOutlet weak var ivProductImage: UIImageView!
    @IBOutlet weak var tfProductState: UITextField!
    @IBOutlet weak var tfProductPriceInDolar: UITextField!
    @IBOutlet weak var swProductCard: UISwitch!
    @IBOutlet weak var btProductAddEdit: UIButton!
    @IBOutlet weak var btImage: UIButton!
    
    var statesManager = StatesManager.shared
    var product: Products!
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .white
        return pickerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let btSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let btDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.items = [btCancel, btSpace, btDone]
        
        tfProductState.inputAccessoryView = toolbar
        tfProductState.inputView = pickerView
        
        if product != nil {
            title = "Editar Produto"
            
            btProductAddEdit.setTitle("Editar", for: .normal)
            
            tfProductName.text = product.title
            if let image = product.cover as? UIImage {
                ivProductImage.image = image
             }
            tfProductPriceInDolar.text = String(product.dollar)
            
            if let state = product.states, let index = statesManager.states.index(of: state) {
                tfProductState.text = state.name
                pickerView.selectRow(index, inComponent: 0, animated: false)
            }
            swProductCard.isOn = product.card
        }
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tfProductState.text = UserDefaults.standard.string(forKey: "state")
    }
    
    @objc func cancel() {
        tfProductState.resignFirstResponder()
    }
    
    @objc func done() {
        if statesManager.states.count > 0 {
            tfProductState.text = statesManager.states[pickerView.selectedRow(inComponent: 0)].name
        }
        cancel()
    }
    
    // MARK:  Methods
    func selectPicture(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        imagePicker.navigationBar.tintColor = UIColor(named: "main")
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: IBAction
    @IBAction func btAddProduct(_ sender: UIButton) {
        let alert = UIAlertController(title: "Selecionar Imagem", message: "De onde você quer escolher a Imagem?", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Câmera", style: .default, handler: { (action: UIAlertAction) in
                self.selectPicture(sourceType: .camera)
            })
            alert.addAction(cameraAction)
        }
        
        let libraryAction = UIAlertAction(title: "Biblioteca de fotos", style: .default) { (action: UIAlertAction) in
            self.selectPicture(sourceType: .photoLibrary)
        }
        alert.addAction(libraryAction)
        
        let photosAction = UIAlertAction(title: "Álbum de fotos", style: .default) { (action: UIAlertAction) in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        }
        alert.addAction(photosAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    //Adiciona Produtos no CoreData
    @IBAction func addUpdateProduct(_ sender: UIButton) {
        
        if product == nil {
            product = Products(context: context)
        }
        
        product.title = tfProductName.text!
        if let dollar = Double(tfProductPriceInDolar.text!) {
            product.dollar = dollar
        }
        product.cover = ivProductImage.image
        
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}

// MARK: - UIImagePickerControllerDelegate
extension AddEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        ivProductImage.image = image
        dismiss(animated: true, completion: nil)
    }
}

extension AddEditViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return statesManager.states.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent: Int) -> String? {
        let states = statesManager.states[row]
        return states.name
    }
}
