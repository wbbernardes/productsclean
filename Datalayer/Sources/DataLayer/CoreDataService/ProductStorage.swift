//
//  ProductStorage.swift
//  
//
//  Created by Wesley Brito on 18/06/23.
//

import CoreData

public protocol ProductStorageProtocol {
    func fetchProducts() async throws -> [ProductDTO]
    func save(products: [ProductDTO]) async throws
    func deleteAllProducts() async throws
}

class ProductStorage: ProductStorageProtocol {
    private let container: NSPersistentContainer

    init(container: NSPersistentContainer) {
        self.container = container
    }

    func fetchProducts() async throws -> [ProductDTO] {
        let request: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()

        return try await container.viewContext.perform {
            do {
                let results = try self.container.viewContext.fetch(request)
                return results.map { $0.toData() }
            } catch {
                throw error
            }
        }
    }

    func save(products: [ProductDTO]) async throws {
        try await container.viewContext.perform {
            for product in products {
                let entity = ProductEntity(context: self.container.viewContext)
                entity.id = Int64(product.id)
                entity.title = product.title
                entity.price = product.price
                entity.desc = product.description
                entity.image = product.image
                entity.category = product.category
            }
            if self.container.viewContext.hasChanges {
                do {
                    try self.container.viewContext.save()
                } catch {
                    throw error
                }
            }
        }
    }
    
    func deleteAllProducts() async throws {
        let request: NSFetchRequest<NSFetchRequestResult> = ProductEntity.fetchRequest()
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try await container.viewContext.perform {
                try self.container.viewContext.execute(deleteRequest)
                try self.container.viewContext.save()
            }
        } catch {
            throw error
        }
    }
}

public struct ProductStorageFactory {
    public static func makeProductStorage(container: NSPersistentContainer) -> ProductStorageProtocol {
        return ProductStorage(container: container)
    }
}
