//
//  SearchStoreTableViewController.swift
//  StoreApp
//
//  Created by 林祐辰 on 2022/4/27.
//

import UIKit

class SearchStoreTableViewController: UITableViewController {

    var filterStore:[Store] = []
    var pickedStoreName :String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let searchStoreController = UISearchController()
        navigationItem.searchController = searchStoreController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchStoreController.searchResultsUpdater = self
        
        loadAllStores("stores")
        filterStore = allStores
   
    }

    
    
    func loadAllStores(_ fileName:String){

        let data = loadJsondata(fileName)!
        let storeDatas :StoreData = decodeJsonData(data)

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

    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterStore.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableviewCell", for: indexPath) as? SearchTableviewCell
        let store = filterStore[indexPath.row]
        cell?.shopLabel.text = store.name
        return cell!
    }


    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToCartInfoTableView" {
            let pickedStore = filterStore[tableView.indexPathForSelectedRow!.row]
            pickedStoreName = pickedStore.name
        }
    }
}


extension SearchStoreTableViewController :UISearchResultsUpdating{
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        
        if let searchText = searchController.searchBar.text {
            
            
            if searchText.isEmpty == false {
                
                filterStore = allStores.filter({ store in
                    
                    let containStoreName = store.name.localizedStandardContains(searchText)
                    let containPlaceName = store.address.localizedStandardContains(searchText)
                    
                    if containStoreName || containPlaceName {
                        return true
                    }else{
                        return false
                    }
                    
                })
                
                
            }else{
                
               filterStore = allStores
                
            }
            
            
            
            tableView.reloadData()
        }
        
        
    }
    
    
}

    
 
    

