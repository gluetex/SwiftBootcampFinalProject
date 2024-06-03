//
//  ProductRepository.swift
//  FinalProjectEmreErtug
//
//  Created by Emre Ertuğ on 27.05.2024.
//

import Foundation
import RxSwift
import Alamofire
import UIKit

class ProductRepository{
    
    var productList = BehaviorSubject<[Yemekler]>(value: [Yemekler]())
    var cartProductList = BehaviorSubject<[CartProducts]>(value: [CartProducts]())
    
    
    func saveCart(yemek_adi:String,yemek_resim_adi:String,yemek_fiyat:String,yemek_siparis_adet:String, kullanici_adi:String){
        
        let url = URL(string: "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php")!
        
        let params:Parameters = ["yemek_adi":yemek_adi,"yemek_resim_adi":yemek_resim_adi, "yemek_fiyat":yemek_fiyat, "yemek_siparis_adet":yemek_siparis_adet, "kullanici_adi":kullanici_adi]
        
        AF.request(url,method: .post, parameters: params).response{ response in
            
            if let data = response.data{
                
                
                do{
                    
                    let response = try JSONDecoder().decode(CRUDanswer.self, from: data)
                    
                    print("SuccessAdded: \(response.success!)")
                    print("Message: \(response.message!)")
                    
                    
                }catch{
                    
                    print(error.localizedDescription)
                }
                
            }
            
            
        }
        
    }
    
    func deleteCartProduct(sepet_yemek_id:String, kullanici_adi:String){
        
        let url = URL(string: "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php")!
        
        let params:Parameters = ["sepet_yemek_id":sepet_yemek_id, "kullanici_adi":kullanici_adi]
        
        AF.request(url,method: .post, parameters: params).response{ response in
            
            if let data = response.data{
                
                do{
                    
                    let cevap = try JSONDecoder().decode(CRUDanswer.self, from: data)
                    
                    print("Success: \(cevap.success!)")
                    print("Message: \(cevap.message!)")
                    
                    
                }catch{
                    
                    print(error.localizedDescription)
                }
                
            }
            
            
        }
        
    }
    
    
    
    
    func loadProducts(){
        
        let url = URL(string: "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php")!
        
        
        
        AF.request(url,method: .get).response{ response in
            
            if let data = response.data{
                
                do{
                    let response = try JSONDecoder().decode(ProductsAnswer.self, from: data)
                    
                    
                    if let list = response.yemekler{
                        
                        self.productList.onNext(list)
                        
                        
                    }
                    
                }catch{
                    
                    print(error)
                }
                
                
            }
            
            
        }
        
        
    }
    
    
    func loadCartProducts(kullanici_adi:String){
        
        
        let url = URL(string: "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php")!
        
        let params:Parameters = ["kullanici_adi":kullanici_adi]
        
        AF.request(url,method: .post, parameters: params).response{ response in
            
            if let data = response.data{
                
                do{
                    
                let response = try JSONDecoder().decode(CartProductsResponse.self, from: data)
                    
                    
                if let list = response.sepet_yemekler{
                    self.cartProductList.onNext(list)
                        
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
            
        }
        
        
    }
    
    


    
}

