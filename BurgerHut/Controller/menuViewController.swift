//
//  menuViewController.swift
//  BurgerHut
//
//  Created by Yoga Pratama on 05/12/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import UIKit

class menuViewController: UIViewController {
    
    @IBOutlet var menuTableView : UITableView!
    
    let shareArray = ArrayCollection.sharedArray
    var filterMenu = [Menu]()
    let searchController = UISearchController(searchResultsController: nil)
    let helperClass = helper()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Menu"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func searchBarIsEmpty() ->Bool{
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
       // let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty())
    }
    
    
    func filterContentForSearchText(_ searchText: String){
   
        if searchBarIsEmpty() {
        }else{
            filterMenu = shareArray.menuArray.filter({( menu  : Menu ) -> Bool in
                return  menu.menu_name.lowercased().contains(searchText.lowercased())
            })
            print("filter : \(filterMenu)")
           
        }
        

        menuTableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "menuDetail" {
            if let indexPath = menuTableView.indexPathForSelectedRow {
                var menu_id : String
                var menu_pic : String
                var menu_name : String
                if isFiltering(){
                    menu_id  = filterMenu[indexPath.row].menu_id
                    menu_pic = filterMenu[indexPath.row].menu_pic
                    menu_name = filterMenu[indexPath.row].menu_name
                }else{
                     menu_id = shareArray.menuArray[indexPath.row].menu_id
                    menu_pic = shareArray.menuArray[indexPath.row].menu_pic
                    menu_name = shareArray.menuArray[indexPath.row].menu_name
                }
                
               let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
               controller.MenuId = menu_id
               controller.menuName = menu_name
               controller.picID  = menu_pic
               controller.navigationItem.leftItemsSupplementBackButton = true
                
                print("menu_id : \(menu_id)")
            }
        }
    }
    

    

}


extension menuViewController : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  isFiltering(){
             return filterMenu.count
        }else{
          return shareArray.menuArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "menuTableViewCell") as! menuTableViewCell
        
        if  isFiltering(){
            var menuArray = filterMenu[indexPath.row]
            var image = UIImage(named: menuArray.menu_pic)
            
            var price =  shareArray.priceArray.filter{
                return $0.price_id == menuArray.menu_id && $0.size_id == 1
            }
            
            cell.menuimageView.image = image
            cell.menuimageView.clipsToBounds = true
            cell.menuimageView.layer.cornerRadius = 10
            cell.menuText.text =  menuArray.menu_name
            if  price.count != 0 {
                var priceValue  = price[0].price_value as NSNumber
                let formatValue = helperClass.formatter(value:  priceValue)
                cell.menuStartFrom.text = "Start From \(formatValue)"
            }else{
                cell.menuStartFrom.text = "Start From "
            }
            
        }else{
            var menuArray = shareArray.menuArray[indexPath.row]
            var image = UIImage(named: menuArray.menu_pic)
            
            var price =  shareArray.priceArray.filter{
                return $0.price_id == menuArray.menu_id && $0.size_id == 1
            }
            
            cell.menuimageView.image = image
            cell.menuimageView.clipsToBounds = true
            cell.menuimageView.layer.cornerRadius = 10
            cell.menuText.text =  menuArray.menu_name
            if  price.count != 0 {
             var priceValue  = price[0].price_value as NSNumber
             let formatValue = helperClass.formatter(value:  priceValue)
              cell.menuStartFrom.text = "Start From \(formatValue)"
            }else{
                cell.menuStartFrom.text = "Start From "
            }
        }
       
        return cell
    }
    
    
    
}

extension menuViewController : UISearchResultsUpdating , UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    
}
