//
//  PageContentViewController.swift
//  FoodPinApp
//
//  Created by 随随意 on 16/7/10.
//  Copyright © 2016年 随随意. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var subHeadingLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var getStartedButton: UIButton!
    
    @IBOutlet weak var forwardButton: UIButton!
    var index: Int = 0
    var heading = ""
    var subHeading = ""
    var imageFile = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        headingLabel.text = heading
        subHeadingLabel.text = subHeading
        contentImageView.image = UIImage(named: imageFile)
        pageControl.currentPage = index
        getStartedButton.hidden = index == 2 ? false : true
        forwardButton.hidden = index == 2 ? true : false
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(sender: UIButton) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "hasViewedWalkThrough")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func nextScreen(sender: AnyObject) {
        if let pageViewController = parentViewController as? PageViewController {
            pageViewController.forward(index)

        }
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
