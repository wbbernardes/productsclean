//
//  ProductsViewModel.swift
//  ProductsClean
//
//  Created by Wesley Brito on 21/05/23.
//

import Foundation
import Domain
import Combine

class ProductsViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var selectedProduct: Product = .empty
    @Published var error: Error?
    
    @Output var test = ""
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

@propertyWrapper
struct Output<Value> {
    var wrappedValue: Value {
        get { subject.value }
        set { subject.send(newValue) }
    }

    var projectedValue: AnyPublisher<Value, Never> {
        subject.eraseToAnyPublisher()
    }

    private let subject: CurrentValueSubject<Value, Never>

    init(wrappedValue: Value) {
        subject = CurrentValueSubject(wrappedValue)
    }
}
