//
//  StoreViewController.swift
//  StoreApp
//
//  Created by 林祐辰 on 2022/4/16.
//

import UIKit

class StoreViewController: UIViewController{

    var stores : [Store] =  []
    @IBOutlet var locateButtons:[UIButton]!
    @IBOutlet weak var storeTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storeTableView.delegate = self
        storeTableView.dataSource = self
        loadAllStores("stores")
        stores = allStores
        changeCategoryColor(buttons:locateButtons,selectedButton:locateButtons[0])
    }
    

    func loadAllStores(_ fileName:String){
        
        let loadDatas = loadJsondata(fileName)!
        let storeDatas : StoreData = decodeJsonData(loadDatas)
        
        for storeData in storeDatas.storeItems {
            
            let mapLink = storeData.mapUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
            let store = Store(name: storeData.name,
                              address: storeData.address,
                              mapURL: URL(string: mapLink!),
                              phone: storeData.phone,
                              openingHours: storeData.openingHours)
           allStores.append(store)
            
        }
    }
    
    func loadLocationStores(location:String){
        
        stores = []
        
        for store in allStores{
            
            if store.name.contains(location){
                stores.append(store)
            }
            
        }
        
        storeTableView.reloadData()
        
    }
    
    
    // MainColor

 
    func changeCategoryColor(buttons:[UIButton],selectedButton:UIButton){
        
        for button in buttons {
            button.configuration?.baseBackgroundColor = UIColor(named: "SecondaryColor")
            button.configuration?.baseForegroundColor = UIColor(named: "MainColor")
        }
        
        selectedButton.configuration?.baseBackgroundColor = UIColor(named: "MainColor")
        selectedButton.configuration?.baseForegroundColor = .white
    }
    
    @IBAction func pickStore(_ sender: UIButton) {
   
        let location = sender.titleLabel!.text!
        loadLocationStores(location: location)
        changeCategoryColor(buttons: locateButtons, selectedButton: sender)
        
    }
}

extension StoreViewController : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stores.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreTableViewCell", for: indexPath) as? StoreTableViewCell
        let store = stores[indexPath.row]
        cell?.storeName.text = store.name
        cell?.storeTelephoneNumber.text = store.phone
        cell?.storeAddress.text = store.address
        cell?.storeTime.text = store.openingHours
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let mapLink = stores[indexPath.row].mapURL{
            UIApplication.shared.open(mapLink)
        }
    
        
    }
    
}
