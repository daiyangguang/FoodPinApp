//
//  DetailViewController.swift
//  FoodPinApp
//
//  Created by 随随意 on 16/7/6.
//  Copyright © 2016年 随随意. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var restaurant: Restaurant!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension

        title = restaurant.name
        tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue:
            240.0/255.0, alpha: 0.2)
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.separatorColor = UIColor(red:
            240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0,
            alpha: 0.8)
        restaurantImageView.image = UIImage(data: restaurant.image)
    }
    @IBAction func close(segue: UIStoryboardSegue) {
        
    }
    override func viewWillAppear(animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.hidesBarsOnSwipe = false
            navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMapSegue" {
            let vc = segue.destinationViewController as! MapViewController
            vc.restaurant = restaurant
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! DetailTableViewCell
        switch indexPath.row {
        case 0:
            cell.fieldLable.text = "Name"
            cell.valueLabel.text = restaurant.name
        case 1:
            cell.fieldLable.text = "Type"
            cell.valueLabel.text = restaurant.type
        case 2:
            cell.fieldLable.text = "Location"
            cell.valueLabel.text = restaurant.location
            cell.mapBtn.hidden = false
        case 3:
            cell.fieldLable.text = "Been Here"
            cell.valueLabel.text = restaurant.isVisited.boolValue ? "Yes, I’ve been here before" : "NO"
        default:
            cell.fieldLable.text = ""
            cell.valueLabel.text = ""
        }
        return cell
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
