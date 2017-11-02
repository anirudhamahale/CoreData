//
//  PersonCoreData.swift
//  CoreDataDemo
//
//  Created by Anirudha on 02/11/17.
//  Copyright © 2017 Anirudha Mahale. All rights reserved.
//

import Foundation
import CoreData

let context = appDelegate.managedObjectContext

extension Person {
    static let entityName = "Person"
    
     static func getPersons() -> [Person_]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        var returnValue: [Person_]?
        do {
            let result = try context.fetch(fetchRequest)
            if let persons = result as? [Person] {
                for item in persons {
                    let name = item.name ?? ""
                    let age = item.age ?? ""
                    let profession = item.profession ?? ""
                    
                    returnValue?.append(Person_(name: name, age: age, profession: profession))
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return returnValue
    }
    
    static func addPerson(_ item: Person_, completion: ()->()) {
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        if let person = NSManagedObject(entity: entity!, insertInto: context) as? Person {
            person.name = item.age
            person.profession = item.profession
            person.age = item.age
            
            do {
                try context.save()
            } catch {
                print("Failed to insert person record.")
                print(error.localizedDescription)
            }
        }
        completion()
    }
}











