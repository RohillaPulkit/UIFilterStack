//
//  ViewController.swift
//  UIFilterStack
//
//  Created by Pulkit Rohilla on 25/07/17.
//  Copyright © 2017 PulkitRohilla. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NGFilterStackViewDelegate, NGFilterStackViewDataSource {

    @IBOutlet weak var filterStackView: NGFilterStackView!
    
    let arrayTitles = ["Filter1","Filter2","Filter3","Filter4","Filter5","Filter6","Filter7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        filterStackView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: FilterStackViewDelegate
    
    func titleForFilterAtIndex(index: NSInteger) -> String {
        
        return arrayTitles[index]
    }
    
    func didSelectFilterAtIndex(index: NSInteger) {
    
        print("Selected filter \(arrayTitles[index])")
    }
    
    //MARK: FilterStackViewDatasource
    
    func numberOfFiltersInFilterView() -> NSInteger {
        
        return arrayTitles.count
    }
}

