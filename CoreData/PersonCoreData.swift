//
//  PersonCoreData.swift
//  CoreDataDemo
//
//  Created by Anirudha on 02/11/17.
//  Copyright © 2017 Anirudha Mahale. All rights reserved.
//

import Foundation
import CoreData

class PersonCoreData {
    /// Context
    let context = appDelegate.managedObjectContext!
    
    /// instance of DublCoreData Class
    static let shared = PersonCoreData()
    
    // save changes
    func saveChanges() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getPersons() -> [Person_]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: context)
        fetchRequest.entity = entity
        var returnValue = [Person_]()
        do {
            let result = try context.fetch(fetchRequest)
            if let persons = result as? [Person] {
                for item in persons {
                    let name = item.name ?? ""
                    let profession = item.profession ?? ""
                    
                    returnValue.append(Person_(name: name, profession: profession))
                }
            } else {
                print("Can't convert result as [Person]")
            }
        } catch {
            print(error.localizedDescription)
        }
        return returnValue
    }
    
    func insert(_ item: Person_, completion: ()->()) {
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: context)
        let person = NSManagedObject(entity: entity!, insertInto: context) as! Person
        person.name = item.name
        person.profession = item.profession
        saveChanges()
        
        completion()
    }
}











