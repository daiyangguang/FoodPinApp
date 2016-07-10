//
//  RestaurantTableViewController.swift
//  FoodPinApp
//
//  Created by 随随意 on 16/7/6.
//  Copyright © 2016年 随随意. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "CafeLoisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier",
        "Bourke Street Bakery", "Haigh’s Chocolate", "Palomino Espresso",
        "Upstate", "Traif", "Graham Avenue Meats And Deli", "Waffle &Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina",
        "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    var restaurantImages = ["cafedeadend.jpg", "homei.jpg", "teakha.jpg", "cafeloisl.jpg",
        "petiteoyster.jpg", "forkeerestaurant.jpg", "posatelier.jpg", "bourkestreetbakery.jpg",
        "haighschocolate.jpg", "palominoespresso.jpg", "upstate.jpg", "traif.jpg",
        "grahamavenuemeats.jpg", "wafflewolf.jpg", "fiveleaves.jpg", "cafelore.jpg",
        "confessional.jpg", "barrafina.jpg", "donostia.jpg", "royaloak.jpg", "thaicafe.jpg"]
    
    var restaurantLocations = ["Hong Kong", "HongKong", "Hong Kong", "Hong Kong", "Hong Kong", "HongKong", "Hong Kong", "Sydney", "Sydney", "Sydney","New York", "New York", "New York", "New York", "NewYork", "New York", "New York", "London", "London",
        "London", "London"]
    
    var restaurantTypes = ["Coffee & Tea Shop",
        "Cafe", "Tea House", "Austrian / Causual Drink",
        "French", "Bakery", "Bakery", "Chocolate", "Cafe",
        "American / Seafood", "American", "American",
        "Breakfast & Brunch", "Coffee & Tea", "Coffee &Tea", "Latin American", "Spanish", "Spanish",
        "Spanish", "British", "Thai"]
    var restaurantIsVisited: [Bool] = Array(count: 21, repeatedValue: false)
    
    //
    var restaurants:[Restaurant] = []
    var searchResults: [Restaurant] = []
    var fetchResultController: NSFetchedResultsController!
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //add searchBar
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        //设置开始搜索时背景显示与否
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        
        //customize searchBar
        searchController.searchBar.tintColor = UIColor.orangeColor()
        searchController.searchBar.placeholder = "Search your restaurant"
        searchController.searchBar.prompt = "Quick Search"
        
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        var fetchRequest = NSFetchRequest(entityName: "Restaurant")
        //排序
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        
        if let managedContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
            }
            catch let error {
                print("\(error)")
            }
            restaurants = fetchResultController.fetchedObjects as! [Restaurant]
            
        }
        
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let detailVC = segue.destinationViewController as! DetailViewController
                detailVC.restaurant = searchController.active ? searchResults[indexPath.row] : restaurants[indexPath.row]
            }
        }
    }
    // search func
    
    func filterContentForSearchText(searchText: String) {
        searchResults = restaurants.filter({ (restaurant) -> Bool in
            let nameMatch = restaurant.name.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            let locationMatch = restaurant.location.rangeOfString(searchText, options: .CaseInsensitiveSearch)
            return nameMatch != nil || locationMatch != nil
        })
    }
    @IBAction func unwindToHomeScreen(segue: UIStoryboardSegue) {}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active {
            return searchResults.count
        }
        else {
            return restaurants.count
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! RestaurantTableViewCell
        let restaurant = searchController.active ? searchResults[indexPath.row] : restaurants[indexPath.row]
        cell.nameLabel?.text = restaurant.name
        cell.thumebnailImageView?.image = UIImage(data: restaurant.image)
        
        cell.thumebnailImageView.layer.cornerRadius = CGRectGetHeight(cell.thumebnailImageView.bounds)/2
        cell.thumebnailImageView.clipsToBounds = true
        cell.locationLable.text = restaurant.location
        cell.categoryLabel.text = restaurant.type
        cell.accessoryType = restaurant.isVisited.boolValue  ? .Checkmark : .None
        return cell
    }
    
    //    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //            let optionMenu = UIAlertController(title: nil, message: "what do you want to do", preferredStyle: .ActionSheet)
    //            optionMenu.addAction(UIAlertAction(title: "Call 123-000-\(indexPath.row)", style: .Default, handler: { (action) -> Void in
    //            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, thecall feature is not available yet. Please retry later.", preferredStyle: .Alert)
    //            alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
    //            self.presentViewController(alertMessage, animated: true, completion: nil)
    //            }))
    //            let title = self.restaurantIsVisited[indexPath.row] ? "Clear my location" : "I'v been here"
    //            optionMenu.addAction(UIAlertAction(title: title, style: .Default, handler: { aciton in
    //            let cell = tableView.cellForRowAtIndexPath(indexPath) as! RestaurantTableViewCell
    //
    //            self.restaurantIsVisited[indexPath.row] = !self.restaurantIsVisited[indexPath.row]
    //            cell.accessoryType = self.restaurantIsVisited[indexPath.row] ? .Checkmark : .None
    //
    //
    //            }))
    //            optionMenu.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
    //            presentViewController(optionMenu, animated: true, completion: nil)
    //            tableView.deselectRowAtIndexPath(indexPath, animated: false)
    //    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            restaurants.removeAtIndex(indexPath.row)
//        }
//        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "删除"
    }
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if searchController.active {
            return false
        }
        else {
            return true
        }
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        //share
        let shareAction = UITableViewRowAction(style: .Default, title: "More") { (action, indexPath) -> Void in
            let shareMenu = UIAlertController(title: nil, message: "Share using",preferredStyle: .ActionSheet)
            let twitterAction = UIAlertAction(title: "Twitter", style:
                UIAlertActionStyle.Default, handler: nil)
            let facebookAction = UIAlertAction(title: "Facebook", style:
                UIAlertActionStyle.Default, handler: nil)
            let emailAction = UIAlertAction(title: "Email", style: .Default,
                handler: nil)
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel,
                handler: nil)
            shareMenu.addAction(twitterAction)
            shareMenu.addAction(facebookAction)
            shareMenu.addAction(emailAction)
            shareMenu.addAction(cancelAction)
            self.presentViewController(shareMenu, animated: true, completion: nil)
        }
        shareAction.backgroundColor = UIColor.lightGrayColor()
        //delete
        let deleteAction = UITableViewRowAction(style: .Default, title: "删除") { (action, indexPath) -> Void in
            if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
                let restaurantToDelete = self.fetchResultController.objectAtIndexPath(indexPath) as! Restaurant
                managedObjectContext.deleteObject(restaurantToDelete)
                
                do {
                    try managedObjectContext.save()
                }
                catch let error {
                    print("after delete error-----\(error)")
                }
                
            }
            
        }
        
        return [deleteAction, shareAction]
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }

    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            if let _newIndexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([_newIndexPath], withRowAnimation: .Fade)
            }
        case .Delete:
            if let _newIndexPath = newIndexPath {
                tableView.deleteRowsAtIndexPaths([_newIndexPath], withRowAnimation: .Fade)
            }
        case .Update:
            if let _newIndexPath = newIndexPath {
                tableView.reloadRowsAtIndexPaths([_newIndexPath], withRowAnimation: .Fade)
            }
        default: tableView.reloadData()
        }
        
        restaurants = controller.fetchedObjects as! [Restaurant]
        
    }
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    //MARK: - UISearchResultsUpdating
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        filterContentForSearchText(searchText)
        tableView.reloadData()
    }
    
}
