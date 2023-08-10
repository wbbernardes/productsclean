//
//  ProductsViewModel.swift
//  ProductsClean
//
//  Created by Wesley Brito on 21/05/23.
//

import Foundation
import Domain
import Combine

protocol BaseViewModel: ObservableObject {
    associatedtype CoordinatorType: Coordinator
    var coordinator: CoordinatorType { get }
}

class ProductsViewModel: BaseViewModel {
    @Published var products: [Product] = []
    @Published var error: Error?
    
    var coordinator: ProductsCoordinator
    
    private let fetchProductsUseCase: FetchProductsUseCaseProtocol
//    @Output var test = ""
    
    init(
        coordinator: ProductsCoordinator,
        fetchProductsUseCase: FetchProductsUseCaseProtocol
    ) {
        self.coordinator = coordinator
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
    
    func openProductDetail(product: Product) {
        coordinator.startProductDetailFlow(product: product)
    }
}

// this guy need some tests
//@propertyWrapper
//struct Output<Value> {
//    var wrappedValue: Value {
//        get { subject.value }
//        set { subject.send(newValue) }
//    }
//
//    var projectedValue: AnyPublisher<Value, Never> {
//        subject.eraseToAnyPublisher()
//    }
//
//    private let subject: CurrentValueSubject<Value, Never>
//
//    init(wrappedValue: Value) {
//        subject = CurrentValueSubject(wrappedValue)
//    }
//}
