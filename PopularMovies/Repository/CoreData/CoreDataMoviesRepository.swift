//
//  CoreDataMoviesRepository.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/5/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

import CoreData

class CoreDataMoviesRepository: MoviesRepository {
    lazy var context: NSManagedObjectContext = {
        return persistentContainer.newBackgroundContext()
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TestApp1")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func add(movies: [Movie], completionHandler: @escaping (Result<Void, Error>) -> Void) {
        
    }
    
    func getAll(completionHandler: @escaping (Result<[Movie], Error>) -> Void) {
        
    }
    
    func clear(completionHandler: @escaping (Result<Void, Error>) -> Void) {
        
    }
    
    func update(movie: Movie, completionHandler: @escaping (Result<Void, Error>) -> Void) {
        
    }
    
    func get(byId id: Int, completionHandler: @escaping (Result<Movie, Error>) -> Void) {
        
    }
}
