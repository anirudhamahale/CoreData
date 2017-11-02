//
//  ViewController.swift
//  CoreData
//
//  Created by Anirudha on 02/11/17.
//  Copyright © 2017 Anirudha Mahale. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var people = [Person_]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        configureRefreshControl()
        
        if let results = PersonCoreData.shared.getPersons() {
            people = results
            tableView.reloadData()
        }
    }
    
    private func configureRefreshControl() {
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(self.didStartRefresh(sender:)), for: .valueChanged)
    }
    
    
    @objc func didStartRefresh(sender: UIRefreshControl) {
        if let temp = PersonCoreData.shared.getPersons() {
            people = temp
            tableView.reloadData()
        }
        sender.endRefreshing()
    }
    
    @IBAction func didTapAddPerson(_ sender: UIButton) {
        let popController = storyboard?.instantiateViewController(withIdentifier: "PersonViewController") as! PersonViewController
        popController.modalPresentationStyle = .popover
        popController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        popController.delegate = self
        popController.popoverPresentationController?.delegate = self
        popController.preferredContentSize = CGSize(width: 300, height: 150)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.profession
        return cell
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}

extension ViewController: PersonViewControllerDelegate {
    func didInsertRecord() {
        if let persons = PersonCoreData.shared.getPersons() {
            people = persons
            tableView.reloadData()
        }
    }
}

