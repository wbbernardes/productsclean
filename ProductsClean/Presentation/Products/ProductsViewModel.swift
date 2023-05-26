//
//  ProductsViewModel.swift
//  ProductsClean
//
//  Created by Wesley Brito on 21/05/23.
//

import Foundation
import Domain

class ProductsViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var selectedProduct: Product = .empty
    @Published var error: Error?
    
    private let fetchProductsUseCase: FetchProductsUseCaseProtocol
    
    init(fetchProductsUseCase: FetchProductsUseCaseProtocol) {
        self.fetchProductsUseCase = fetchProductsUseCase
    }
    
    func fetchProducts() async {
        Task { @MainActor in
            do {
                self.products = try await fetchProductsUseCase.execute()
            } catch {
                self.error = error
            }
        }
    }
}
