//
//  DataController.swift
//  MoodProject
//
//  Created by Anna Podobrii on 28.01.2022.
//

import Foundation
import Realm
import RealmSwift
import Combine
import CoreLocation
import CoreGraphics
import UIKit

protocol DataControllerInjectable {
    var dataController: DataController! {get set}
}

protocol LocationChangedProtocol: AnyObject {
    func locationDidChange()
}

class DataController:ObservableObject {
    private(set) var localRealm: Realm?
    @Published var moods: [Mood] = []
    @Published var factors: [Factors] = []

    // On initialize of the class, we'll open a Realm and get the tasks saved in the Realm
    init() {
        openRealm()
//        if isSyncingRealm == false {
        popularFactors()
//        }
        getMoods()
        getFactors()
    }

    // Function to open a Realm (like a box) - needed for saving data inside of the Realm
    func openRealm() {
        do {
            // Setting the schema version
            let config = Realm.Configuration(schemaVersion: 1)

            // Letting Realm know we want the defaultConfiguration to be the config variable
            Realm.Configuration.defaultConfiguration = config

            // Trying to open a Realm and saving it into the localRealm variable
            localRealm = try Realm()
          
            print(Realm.Configuration.defaultConfiguration)
        } catch {
            print("Error opening Realm", error)
        }
    }
    @Published var isSyncingRealm: Bool = false
   

    // Function to add a task
    func addMood(date: Date, factor: String, rating: Int, describe:String) {
        if let localRealm = localRealm { // Need to unwrap optional, since localRealm is optional
            do {
                // Trying to write to the localRealm
                try localRealm.write {
                    // Creating a new Task
                    let newMood = Mood(value: ["date": date, "factor": factor, "rating": rating, "describeMood": describe])
                   
                    // Adding newTask to localRealm
                    localRealm.add(newMood)
                    
                    // Re-setting the tasks array
                    getMoods()
                    print("Added new task to Realm!", newMood)
                }
            } catch {
                print("Error adding task to Realm: \(error)")
            }
        }
    }
    
    // Function to get all tasks from Realm and setting them in the tasks array
    func getMoods() {
        if let localRealm = localRealm {
            
            // Getting all objects from localRealm and sorting them by completed state
            let allMoods = localRealm.objects(Mood.self).sorted(byKeyPath: "completed")
            
            // Resetting the tasks array
            moods = []
            
            // Append each task to the tasks array
            allMoods.forEach { task in
                moods.append(task)
            }
        }
    }

    // Function to update a task's completed state
    func updateMood(id: ObjectId, completed: Bool) {
        if let localRealm = localRealm {
            do {
                // Find the task we want to update by its id
                let moodToUpdate = localRealm.objects(Mood.self).filter(NSPredicate(format: "id == %@", id))
                
                // Make sure we found the task and taskToUpdate array isn't empty
                guard !moodToUpdate.isEmpty else { return }

                // Trying to write to the localRealm
                try localRealm.write {
                    
                    // Getting the first item of the array and changing its completed state
                    moodToUpdate[0].completed = completed
                    
                    // Re-setting the tasks array
                    getMoods()
                    print("Updated task with id \(id)! Completed status: \(completed)")
                }
            } catch {
                print("Error updating task \(id) to Realm: \(error)")
            }
        }
    }

    // Function to delete a task
    func deleteTask(id: ObjectId) {
        if let localRealm = localRealm {
            do {
                // Find the task we want to delete by its id
                let moodToDelete = localRealm.objects(Mood.self).filter(NSPredicate(format: "id == %@", id))
                
                // Make sure we found the task and taskToDelete array isn't empty
                guard !moodToDelete.isEmpty else { return }
                
                // Trying to write to the localRealm
                try localRealm.write {
                    
                    // Deleting the task
                    localRealm.delete(moodToDelete)
                    
                    // Re-setting the tasks array
                    getMoods()
                    print("Deleted task with id \(id)")
                }
            } catch {
                print("Error deleting task \(id) to Realm: \(error)")
            }
        }
    }
    func deleteAllMood() {
        if let localRealm = localRealm {
            do {
                // Find the task we want to delete by its id
                let moodToDelete = localRealm.objects(Mood.self)
                
                // Make sure we found the task and taskToDelete array isn't empty
                guard !moodToDelete.isEmpty else { return }
                
                // Trying to write to the localRealm
                try localRealm.write {
                    
                    // Deleting the task
                    localRealm.delete(moodToDelete)
                    
                    // Re-setting the tasks array
                    getMoods()
                    
                }
            } catch {
                print("Error deleting moods to Realm: \(error)")
            }
        }
    }
    
    func factorImageArray() -> [String] {
        var image:String = ""
        var imagesArray:[String] = []
        for i in 1...5 {
             image = "factor\(i)"
            imagesArray.append(image)
        }
        return imagesArray
    }
    
    func addFactor(name: String, image:String) {
        if let localRealm = localRealm { // Need to unwrap optional, since localRealm is optional
            do {
                // Trying to write to the localRealm
                try localRealm.write {
                    // Creating a new Task
                    let newFactor = Factors(value: ["name": name, "image": image])
                   
                    // Adding newTask to localRealm
                    localRealm.add(newFactor)
                    
                    // Re-setting the tasks array
                    getFactors()
                    print("Added new task to Realm!", newFactor)
                }
            } catch {
                print("Error adding task to Realm: \(error)")
            }
        }
    }
    
    func getFactors() {
        if let localRealm = localRealm {
            
            // Getting all objects from localRealm and sorting them by completed state
            let allFactors = localRealm.objects(Factors.self).sorted(byKeyPath: "name")
            
            // Resetting the tasks array
            factors = []
            
            // Append each task to the tasks array
            allFactors.forEach { item in
               factors.append(item)
            }
        }
    }
    
    func deleteAllFactors() {
       
            do {
                let localRealm = try Realm()
                // Find the task we want to delete by its id
                let factorToDelete = localRealm.objects(Factors.self)
                
                // Make sure we found the task and taskToDelete array isn't empty
                guard !factorToDelete.isEmpty else { return }
                
                // Trying to write to the localRealm
                try localRealm.write {
                    
                    // Deleting the task
                    localRealm.delete(factorToDelete)
                    
                    // Re-setting the tasks array
                   
                }
            } catch {
                print("Error deleting factors to Realm: \(error)")
            }
        
    }
    
    func deleteFactor(id: ObjectId) {
        if let localRealm = localRealm {
            do {
                // Find the task we want to delete by its id
                let factorToDelete = localRealm.objects(Factors.self).filter(NSPredicate(format: "id == %@", id))
                
                // Make sure we found the task and taskToDelete array isn't empty
                guard !factorToDelete.isEmpty else { return }
                
                // Trying to write to the localRealm
                try localRealm.write {
                    
                    // Deleting the task
                    localRealm.delete(factorToDelete)
                    
                    // Re-setting the tasks array
                    getFactors()
                    print("Deleted task with id \(id)")
                }
            } catch {
                print("Error deleting task \(id) to Realm: \(error)")
            }
        }
    }
    
    func popularFactors() {
        lazy var factors: Results<Factors> = { self.localRealm?.objects(Factors.self) }()!
        
        if let localRealm = localRealm {
            // 1
            if factors.count == 0 {
         try! localRealm.write() { // 2
     
             let stateFactors = ["Home":"factor1", "Friends":"factor2", "Pets":"factor3", "Work":"factor4", "Parents":"factor5"]
//                                 Factors(value: ["name": "Friends", "image": "factor2"]),
//                                 Factors(value: ["name": "Pets", "image": "factor3"]),
//                                 Factors(value: ["name": "Work", "image": "factor4"]),
//                                 Factors(value: ["name": "Parents", "image": "factor5"])] // 3
             
          for (key, element) in stateFactors { // 4
            let newFactor = Factors()
              newFactor.name = key
              newFactor.image = element
              localRealm.add(newFactor)
          }
        }
      }
            isSyncingRealm = true
            factors = localRealm.objects(Factors.self)
            print("factors count\(factors.count)")
        }
    }
    
    var isLocalRealm: Bool = false
    var notificationToken: NotificationToken? = nil
    
    func factors(withFactorsId factorId: ObjectId) -> Factors? {
        if let factors = self.localRealm?.objects(Factors.self).filter(NSPredicate(format: "id == %@", factorId)), let factor = factors.first {
            return factor
        }
        return nil
    }
  
    func setSelected(factors: Factors?) {
        guard let factorIdToSelect = factors?.id else {
            notificationToken?.invalidate()
            return
        }
        let activityToSelect = self.factors(withFactorsId: factorIdToSelect)
        selectedFactor = activityToSelect
    }
    
    @Published var selectedFactor: Factors? = nil {
        didSet {
            if !isLocalRealm {
                notificationToken?.invalidate()
                notificationToken = selectedFactor?.observe({ [weak self] (change) in
                    DispatchQueue.main.async {
                        self?.setSelected(factors: self?.selectedFactor)
                    }
                })
            }
        }
    }
    

}
