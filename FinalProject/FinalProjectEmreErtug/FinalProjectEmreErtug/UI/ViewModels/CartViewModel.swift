//
//  CartViewModel.swift
//  FinalProjectEmreErtug
//
//  Created by Emre Ertuğ on 26.05.2024.
//

import Foundation
import RxSwift


class CartViewModel{
    
    var repo = ProductRepository()
    var cartProductList = BehaviorSubject<[CartProducts]>(value: [CartProducts]())
    
    
    init(){
        cartProductList = repo.cartProductList
        
    }
    
    
    func loadCartProducts(kullanici_adi:String){
        repo.loadCartProducts(kullanici_adi: "emre")
    }
    
    func deleteCartProduct(sepet_yemek_id:String, kullanici_adi:String){
        repo.deleteCartProduct(sepet_yemek_id:sepet_yemek_id, kullanici_adi:kullanici_adi)
        repo.loadProducts()
    }
    
}
