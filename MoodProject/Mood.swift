//
//  Task.swift
//  MoodProject
//
//  Created by Anna Podobrii on 28.01.2022.
//

import Foundation
import RealmSwift

class Mood: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId // This is our primary key, and each Task instance can be uniquely identified by the ID
    @Persisted var date:Date = Date.now
    @Persisted var factor:String = ""
    @Persisted var rating:Int = 0
    @Persisted var describeMood:String? = nil
    @Persisted var completed = false
    
}
