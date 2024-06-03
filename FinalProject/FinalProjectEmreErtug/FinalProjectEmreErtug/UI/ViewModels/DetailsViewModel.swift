//
//  DetailsViewModel.swift
//  FinalProjectEmreErtug
//
//  Created by Emre Ertuğ on 26.05.2024.
//

import Foundation
import RxSwift


class DetailsViewModel{
    
    var repo = ProductRepository()
    var cartProductList = BehaviorSubject<[CartProducts]>(value: [CartProducts]())

    
    func addToCart(yemek_adi:String, yemek_resim_adi:String, yemek_fiyat:String, yemek_siparis_adet:String, kullanici_adi:String){
        
        repo.saveCart(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet, kullanici_adi: kullanici_adi)
    }
    
    
    
}
