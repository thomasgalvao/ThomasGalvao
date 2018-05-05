//
//  StatesManager.swift
//  ThomasGalvao
//
//  Created by Thomas Galvão on 04/05/2018.
//  Copyright © 2018 Thomas Galvao. All rights reserved.
//
import CoreData

class StatesManager {
    
    static let shared = StatesManager()
    var states: [States] = []
    
    func loadStates(with context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<States> = States.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]   
        do {
            states = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteState(index: Int, context: NSManagedObjectContext) {
        let state = states[index]
        context.delete(state)
       
        do {
            try context.save()
            self.states.remove(at: index)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private init() {
        
    }
    
}
