//
//  NGFilterStackView.swift
//  UIFilterStack
//
//  Created by Pulkit Rohilla on 25/07/17.
//  Copyright © 2017 PulkitRohilla. All rights reserved.
//

import UIKit

@objc protocol NGFilterStackViewDelegate {
    
    func titleForFilterAtIndex(index : NSInteger) -> String
    func didSelectFilterAtIndex(index : NSInteger)
}

@objc protocol NGFilterStackViewDataSource {

    func numberOfFiltersInFilterView() -> NSInteger
}


@IBDesignable
class NGFilterStackView: UIView {

    @IBOutlet weak var dataSource : AnyObject?
    @IBOutlet weak var delegate : AnyObject?
    
    @IBInspectable var buttonPadding : CGFloat = 10.0
    
    @IBInspectable var textColor : UIColor = UIColor.black
    @IBInspectable var backColor : UIColor = UIColor.white
    @IBInspectable var borderColor : UIColor = UIColor.lightGray

    @IBInspectable var highlightedTextColor : UIColor = UIColor.white
    @IBInspectable var highlightedBackColor : UIColor = UIColor.black
    @IBInspectable var highlightedBorderColor : UIColor = UIColor.lightGray
    
    var buttonStackView : UIStackView!
    var numberOfFilters : NSInteger = 0
    
    override var intrinsicContentSize: CGSize{
        
        return CGSize(width: (self.superview?.bounds.size.width)!, height: (self.superview?.bounds.size.height)!)
    }
    
    override func prepareForInterfaceBuilder() {
    
        let lblText = UILabel.init(frame: self.bounds)
        lblText.backgroundColor = UIColor.lightGray
        lblText.text = "NGFilterStackView"
        lblText.textAlignment = .center
        lblText.textColor = UIColor.darkGray
        
        self.addSubview(lblText)
    }
    
    func reloadData(){
        
        if buttonStackView != nil{
            
            buttonStackView.removeFromSuperview()
        }
        
        
        if dataSource != nil {
            
            initMainStackView()

            numberOfFilters = (dataSource?.numberOfFiltersInFilterView())!
            
            setupView()

        }

    }
    
    func initMainStackView(){
        
        buttonStackView = UIStackView.init()
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fill
        buttonStackView.spacing = 8.0

    }
    
    func setupView(){

        if delegate != nil {
            
            for index in 0...numberOfFilters-1{
                
                let title = delegate?.titleForFilterAtIndex(index: index)
                
                let btnFilter = UIButton.init()
                btnFilter.tag = index;
                btnFilter.setTitle(title, for: .normal)
                btnFilter.setTitleColor(textColor, for: .normal)
                btnFilter.backgroundColor = backColor
                btnFilter.layer.cornerRadius = 5.0
                btnFilter.layer.borderWidth = 0.5
                btnFilter.layer.borderColor = borderColor.cgColor
                
                btnFilter.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -buttonPadding, bottom: 0.0, right: -buttonPadding)
                btnFilter.contentEdgeInsets = UIEdgeInsets(top: 0.0, left: buttonPadding, bottom: 0.0, right: buttonPadding)
                
                btnFilter.addTarget(self, action: #selector(actionFilterClicked), for: .touchUpInside)
                
                buttonStackView.addArrangedSubview(btnFilter)
            }
            
            self.addSubview(buttonStackView)
            self.updateConstraints()
        }

    }
    
    override func updateConstraints() {
        
        super.updateConstraints()
        
        if buttonStackView != nil {
            
            let dictView : [String : UIView] = ["buttonStackView" : buttonStackView]
            let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[buttonStackView]-|",
                                                                       options: .alignAllCenterY,
                                                                       metrics: nil,
                                                                       views: dictView)
            let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[buttonStackView]-|",
                                                                     options: NSLayoutFormatOptions(rawValue: 0),
                                                                     metrics: nil,
                                                                     views: dictView)
            self.addConstraints(horizontalConstraints)
            self.addConstraints(verticalConstraints)
        }

    }

    
    func actionFilterClicked(button : UIButton)
    {
        updateButtonProperty(button: button)
        let filterIndex = button.tag
        
        delegate?.didSelectFilterAtIndex(index: filterIndex)
    }
    
    func updateButtonProperty(button : UIButton){
        
        if button.isSelected {
            
            button.isSelected = false
            button.setTitleColor(textColor, for: .normal)
            button.backgroundColor = backColor
            button.layer.borderColor = borderColor.cgColor
        }
        else
        {
            button.isSelected = true
            button.setTitleColor(highlightedTextColor, for: .normal)
            button.backgroundColor = highlightedBackColor
            button.layer.borderColor = highlightedBorderColor.cgColor
        }
    }
}
