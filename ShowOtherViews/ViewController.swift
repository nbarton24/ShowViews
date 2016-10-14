//
//  ViewController.swift
//  ShowOtherViews
//
//  Created by Nick Barton on 7/14/16.
//  Copyright © 2016 Nick Barton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recre/Users/nbarton/Desktop/ShowOtherViews/ShowOtherViews/SecondViewController.xibated.
    }

    @IBAction func popOver(sender: AnyObject) {
        
        self.performSegueWithIdentifier("show", sender: self)
        
        
    }
    @IBAction func showSecond(sender: AnyObject) {
        
        let secondVC = SecondViewController()
        secondVC.modalPresentationStyle = UIModalPresentationStyle.Popover
        secondVC.preferredContentSize = CGSizeMake(400, 400)
        
        presentViewController(secondVC, animated: false, completion: nil)
        
        let popoverPresentationController = secondVC.popoverPresentationController
        popoverPresentationController?.sourceRect = CGRectMake(0, 0, sender.frame.size.width, sender.frame.size.height)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "show" {
//            let vc = segue.destinationViewController
//            var controller = vc.popoverPresentationController
//            if controller != nil {
//                controller?.delegate = self
//            
//        }
    }

}