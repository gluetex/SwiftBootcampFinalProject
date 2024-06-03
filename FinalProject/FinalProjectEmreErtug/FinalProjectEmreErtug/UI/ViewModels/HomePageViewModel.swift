//
//  HomePageViewModel.swift
//  FinalProjectEmreErtug
//
//  Created by Emre Ertuğ on 26.05.2024.
//

import Foundation
import RxSwift


class HomePageViewModel{
    
    var repo = ProductRepository()
    var productList = BehaviorSubject<[Yemekler]>(value: [Yemekler]())
    
    
    init(){
        productList = repo.productList
        
    }
    
    
    func loadProducts(){
        repo.loadProducts()
    }
    
}
