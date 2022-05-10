//
//  CartInfoTableViewController.swift
//  StoreApp
//
//  Created by 林祐辰 on 2022/4/27.
//
import UIKit

class CartInfoTableViewController: UITableViewController {

    
    var order:Order?
    var storeName:String = ""{
        willSet{
            order?.store = newValue
            nameTextField.resignFirstResponder()
            phoneTextField.resignFirstResponder()
            memoTextView.becomeFirstResponder()
            print(newValue)
        }
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var storeTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var memoTextView: UITextView!
    
     override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        phoneTextField.delegate = self
        memoTextView.delegate = self
        nameTextField.becomeFirstResponder()
         
         nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
         phoneTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
         storeTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidBegin)
     }
     
    

    
     @objc func textFieldDidChange(_ textField: UITextField) {
         performSegue(withIdentifier: "unwindToCartInfoView", sender: nil)
     }
    
   
    @IBAction func unwindToCartInfoTableView(_ segue: UIStoryboardSegue) {
        if let source = segue.source as? SearchStoreTableViewController {
            storeName = source.pickedStoreName
            order?.store = storeName
            storeTextField.text = source.pickedStoreName
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    
        if segue.identifier == "unwindToCartInfoView"{
            
            let orderDetailDestination = segue.destination as! CartInfoViewController
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "yyyy-M-d"
            let orderDrinkDate = dateFormater.string(from: Date.now)
            
            order = Order(orderNo: "",
                              name: nameTextField.text!,
                              phone: phoneTextField.text!,
                              store: storeName,
                              date: orderDrinkDate,
                              memo: memoTextView.text!)
            
            orderDetailDestination.order = order!
            
        }
        
    
        
        
    }
    
    // MARK: - Table view data source

    

}



extension CartInfoTableViewController : UITextFieldDelegate,UITextViewDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        textField.resignFirstResponder()
        
        if textField == nameTextField{
            phoneTextField.becomeFirstResponder()
        }else if textField == phoneTextField && storeTextField.text == ""{
            performSegue(withIdentifier: "performSearchStore", sender: nil)
        }        
        
        return true
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            memoTextView.resignFirstResponder()
            performSegue(withIdentifier: "unwindToCartInfoView", sender: nil)
            return true
        }
       return false
    }

    
}

