//
//  ViewController.swift
//  TipCalculator
//
//  Created by Roger on 2015/1/24.
//  Copyright (c) 2015年 Roger. All rights reserved.
//

import UIKit

class ViewController: UIKit.UIViewController, UITableViewDataSource {

    var possibleTips = Dictionary<Int, (tipAmt:Double, total:Double)>()
    var sortedKeys:[Int] = []
    
    @IBOutlet var totalTextField: UITextField!
    @IBOutlet var taxPctSlider: UISlider!
    @IBOutlet var taxPctLabel: UILabel!
    @IBOutlet var resultsTextView: UITextView!
    @IBOutlet var tableView: UITableView!
    @IBAction func calculateTapped(sender : AnyObject) {
        tipCalc.total = Double((totalTextField.text as NSString).doubleValue)
        possibleTips = tipCalc.returnPossibleTips()
        sortedKeys = sorted(Array(possibleTips.keys))
        tableView.reloadData()
//        tipCalc.total = Double((totalTextField.text as NSString).doubleValue)
//        let possibleTips = tipCalc.returnPossibleTips()
//        var results = ""
//        for(tipPct, topValue) in possibleTips{
//            results += "\(tipPct)%: \(topValue)\n"
////            results += String(format: "%d%%:%.2f\n", tipPct,topValue)
//        }
//        
//        //sort
////        var keys = Array(possibleTips.keys)
////        sort(&keys)
////        for tipPct in keys {
////            let tipValue = possibleTips[tipPct]!
////            let prettyTipValue = String(format:"%.2f", tipValue)
////            results += "\(tipPct)%: \(prettyTipValue)\n"
////        }
//        
//        resultsTextView.text = results;
    }
    @IBAction func taxPercentageChanged(sender : AnyObject) {
        tipCalc.taxPct = Double(taxPctSlider.value) / 100.0
        refreshUI()
    }
    @IBAction func viewTapped(sender : AnyObject) {
        totalTextField.resignFirstResponder()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refreshUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    let tipCalc = TipCalculatorModel(total: 33.25, taxPct: 0.06)
    
    func refreshUI() {
        // 1
        totalTextField.text = String(format: "%0.2f", tipCalc.total)
        // 2
        taxPctSlider.value = Float(tipCalc.taxPct) * 100.0
        // 3
        taxPctLabel.text = "Tax Percentage (\(Int(taxPctSlider.value))%)"
        // 4
//        resultsTextView.text = ""
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedKeys.count
    }
    
    // 1
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 2
        let cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: nil)
        
        // 3
        let tipPct = sortedKeys[indexPath.row]
        // 4
        let tipAmt = possibleTips[tipPct]!.tipAmt
        let total = possibleTips[tipPct]!.total
        
        // 5
        cell.textLabel.text = "\(tipPct)%:"
        cell.detailTextLabel?.text = String(format:"Tip: $%0.2f, Total: $%0.2f", tipAmt, total)
        return cell
    }
}

