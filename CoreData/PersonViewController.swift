//
//  PersonViewController.swift
//  CoreData
//
//  Created by Anirudha on 02/11/17.
//  Copyright © 2017 Anirudha Mahale. All rights reserved.
//

import UIKit

class PersonViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var professionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func didTapAdd(_ sender: Any) {
        let item = Person_(name: nameTextField.text!, age: ageTextField.text!, profession: professionTextField.text!)
        Person.addPerson(item) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
