//
//  Detailed_ViewController.swift
//  NoddApp
//
//  Created by Sanjay Mali on 09/10/16.
//  Copyright © 2016 Sanjay. All rights reserved.
//

import UIKit

class Detailed_ViewController: UIViewController {
    
    var nlatlong = ""
    var nEvent = ""
    var nType = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        Loader.inst.startLoading()
        self.navigationItem.title = "DetailedInfo"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(viewText)
        constrain()
        viewText.text = "Event:\(nEvent)\n\n" + "Type:\(nType)\n\n" + "Latitude & Longitude:\(nlatlong)"
        
        
    }
    var viewText:UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func constrain(){
        viewText.leftAnchor.constraint(equalTo:view.leftAnchor,constant:8).isActive = true
        viewText.topAnchor.constraint(equalTo:view.topAnchor,constant:64).isActive = true
        viewText.heightAnchor.constraint(equalTo:view.heightAnchor).isActive = true
        viewText.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
    }
    override func viewWillAppear(_ animated: Bool) {
        Loader.inst.endLoading()
    }
    
}
