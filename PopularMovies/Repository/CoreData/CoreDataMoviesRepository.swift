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
        let container = NSPersistentContainer(name: "PopularMovies")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func add(movies: [Movie], completionHandler: @escaping (Result<Void, Error>) -> Void) {
        context.perform {
            for movie in movies {
                let cdMovie = NSEntityDescription.insertNewObject(forEntityName: "Movie", into: self.context) as! CDMovie
                cdMovie.fillWith(movie: movie)
            }
            do {
                try self.context.save()
                DispatchQueue.main.async {
                    completionHandler(.success(()))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            }
        }
    }
    
    func getAll(completionHandler: @escaping (Result<[Movie], Error>) -> Void) {
        context.perform {
            let fetchRequest = NSFetchRequest<CDMovie>(entityName: "Movie")
            do {
                let cdMovies = try self.context.fetch(fetchRequest)
                let movies = cdMovies.map({ cdMovie in
                    return MovieDTO.fromCDMovie(cdMovie: cdMovie)
                })
                DispatchQueue.main.async {
                    completionHandler(.success(movies))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            }
        }
    }
    
    func clear(completionHandler: @escaping (Result<Void, Error>) -> Void) {
        context.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try self.context.execute(deleteRequest)
                try self.context.save()
                DispatchQueue.main.async {
                    completionHandler(.success(()))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            }
        }
    }
    
    func update(movie: Movie, completionHandler: @escaping (Result<Void, Error>) -> Void) {
        context.perform {
            let fetchRequest = NSFetchRequest<CDMovie>(entityName: "Movie")
            fetchRequest.predicate = NSPredicate(format: "id == %d", movie.id)
            do {
                let cdMovie = try self.context.fetch(fetchRequest).first!
                cdMovie.fillWith(movie: movie)
                try self.context.save()
                DispatchQueue.main.async {
                    completionHandler(.success(()))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            }
        }
    }
    
    func get(byId id: Int, completionHandler: @escaping (Result<Movie, Error>) -> Void) {
        context.perform {
            let fetchRequest = NSFetchRequest<CDMovie>(entityName: "Movie")
            fetchRequest.predicate = NSPredicate(format: "id == %d", id)
            do {
                let cdMovie = try self.context.fetch(fetchRequest).first!
                let movie = MovieDTO.fromCDMovie(cdMovie: cdMovie)
                DispatchQueue.main.async {
                    completionHandler(.success(movie))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            }
        }
    }
}
