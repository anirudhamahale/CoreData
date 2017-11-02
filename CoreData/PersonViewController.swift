//
//  PersonViewController.swift
//  CoreData
//
//  Created by Anirudha on 02/11/17.
//  Copyright © 2017 Anirudha Mahale. All rights reserved.
//

import UIKit

protocol PersonViewControllerDelegate: class {
    func didInsertRecord()
}


class PersonViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var professionTextField: UITextField!
    
    var delegate: PersonViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func didTapAdd(_ sender: Any) {
        let item = Person_(name: nameTextField.text!, profession: professionTextField.text!)
        PersonCoreData.shared.insert(item) {
            delegate?.didInsertRecord()
            self.dismiss(animated: true, completion: nil)
        }
    }
}
