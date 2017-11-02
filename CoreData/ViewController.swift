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
    var people = [Person_]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let persons = Person.getPersons() {
            people = persons
            print(people)
            tableView.reloadData()
        }
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

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = people[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonTableViewCell", for: indexPath)
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.profession
        return cell
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        if let persons = Person.getPersons() {
            people = persons
            tableView.reloadData()
        }
    }
}

