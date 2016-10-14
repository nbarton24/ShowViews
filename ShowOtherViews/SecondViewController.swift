//
//  SecondViewController.swift
//  ShowOtherViews
//
//  Created by Nick Barton on 7/14/16.
//  Copyright © 2016 Nick Barton. All rights reserved.
//
//
// NOTES:
//      - The three text fields have been linked to the view controller using delegation
//          - Control dragged from TF to the "FILE OWNER" in xib

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {

    var c = false
    var kbHeight: CGFloat!
    var animated = false
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var errorLabel1: UILabel!
    
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var errorLabel2: UILabel!
    
    @IBOutlet weak var moveTF: UITextField!
    @IBOutlet weak var otherMoveTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //textField1.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SecondViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SecondViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doCancel(sender: AnyObject) {
        if moveTF.isFirstResponder() {
            moveTF.resignFirstResponder()
        }else if textField1.isFirstResponder() {
            textField1.resignFirstResponder()
        }else if textField2.isFirstResponder() {
            textField2.resignFirstResponder()
        }
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func doOK(sender: AnyObject) {
        c = check()
        if c {
            self.dismissViewControllerAnimated(false, completion: nil)
        }
    }
    
    func animateTextField(up: Bool) {
        //Maybe look into only getting maxY from first responder. could save memory?
        let frRect = findFirstResponder()
        if let bounds = frRect{
            if bounds.maxY > kbHeight {
                let offset = (-bounds.maxY + ((self.view.bounds.maxY - kbHeight)-8))
                let oppoOffset = (bounds.maxY - (self.view.bounds.maxY - kbHeight)+8)
                let change = (up ? offset:oppoOffset)
                UIView.animateWithDuration(0.3, animations: {
                    self.view.frame = CGRectOffset(self.view.frame, 0, change)
                })
                animated = true
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if moveTF.isFirstResponder() {
            moveTF.resignFirstResponder()
            return true
        }
        if otherMoveTF.isFirstResponder() {
            otherMoveTF.resignFirstResponder()
            return true
        }
        if textField1.isFirstResponder() {
            textField2.becomeFirstResponder()
        }else if textField2.isFirstResponder() {
            textField2.resignFirstResponder()
            c = check()
        }
        if c {
            self.dismissViewControllerAnimated(false, completion: nil)
        }
        return true
    }
    
    func check() -> Bool{
        if textField1.text! == "" && textField2.text! == ""{
            errorLabel1.text = "ERROR: Must Specify Name"
            errorLabel2.text = "ERROR: Must Specify Other Thing"
            //print("Need Both")
            return false
        }
        if textField1.text! == "" {
            errorLabel1.text = "ERROR: Must Specify Name"
            return false
        }
        if textField2.text! == "" {
            errorLabel2.text = "ERROR: Must Specify Other Thing"
            return false
        }
        return true
    }
    
    func findFirstResponder() -> CGRect? {
        for v in self.view.subviews {
            if v.isFirstResponder() {
                print("found it")
                let bounds = v.frame
                return bounds
            }
        }
        return nil
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize =  (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                kbHeight = keyboardSize.height
                self.animateTextField(true)

            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if animated{
            self.animateTextField(false)
            animated = false
        }
    }
    

}
