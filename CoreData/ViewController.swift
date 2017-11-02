//
//  ViewController.swift
//  CoreData
//
//  Created by Anirudha on 02/11/17.
//  Copyright © 2017 Anirudha Mahale. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func didTapAddPerson(_ sender: UIButton) {
        let popController = storyboard?.instantiateViewController(withIdentifier: "PersonViewController") as! PersonViewController
        popController.modalPresentationStyle = .popover
        popController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        popController.popoverPresentationController?.delegate = self
        popController.preferredContentSize = CGSize(width: 300, height: 200)
        popController.popoverPresentationController?.sourceView = sender
        popController.popoverPresentationController?.sourceRect = sender.bounds
        
        self.present(popController, animated: true, completion: nil)
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}

