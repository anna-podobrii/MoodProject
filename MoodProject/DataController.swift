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

    // On initialize of the class, we'll open a Realm and get the tasks saved in the Realm
    init() {
        openRealm()
        getMoods()
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
        } catch {
            print("Error opening Realm", error)
        }
    }

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
    
}
