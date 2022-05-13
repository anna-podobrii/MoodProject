//
//  Factors.swift
//  MoodProject
//
//  Created by Anna Podobrii on 07.05.2022.
//

import Foundation
import RealmSwift

class Factors: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId // This is our primary key, and each Task instance can be uniquely identified by the ID
    @Persisted var name:String = ""
    @Persisted var image:String? = ""
    @Persisted var check:Bool = false
}
