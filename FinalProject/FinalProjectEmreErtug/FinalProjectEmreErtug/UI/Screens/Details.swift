//
//  Details.swift
//  FinalProjectEmreErtug
//
//  Created by Emre Ertuğ on 26.05.2024.
//

import UIKit
import Kingfisher

class Details: UIViewController {
    
    var viewModel = DetailsViewModel()
    var price:Int?

    
    var count = 1
    
    @IBOutlet weak var imgProduct: UIImageView!
    
    @IBOutlet weak var labelPrice: UILabel!
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelProductCount: UILabel!
    
    @IBOutlet weak var labelTotalPrice: UILabel!
    
    var product:Yemekler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let p = product {
            
            labelPrice.text = "₺\(String(p.yemek_fiyat!))"
            labelName.text = p.yemek_adi
            labelProductCount.text = String(count)
            labelTotalPrice.text = "₺\(String(p.yemek_fiyat!))"
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(p.yemek_resim_adi!)"){
                    
                    DispatchQueue.main.async {
                        
                        self.imgProduct.kf.setImage(with:url)
                        
                    }
                    
                }
            
            self.price = Int(p.yemek_fiyat!)
            
        }
        

    }
    
    
    @IBAction func btnDecrement(_ sender: Any) {
        if (count==0){
            count = 1
        }
        else{
            count = count - 1
            labelProductCount.text = String(count)
            labelTotalPrice.text = "₺\(String(count * price!))"

        }
    }
    
    @IBAction func btnIncrement(_ sender: Any) {
        count = count + 1
        print(count)
        labelProductCount.text = String(count)
        labelTotalPrice.text = "₺\(String(count * price!))"

    }
    
    @IBAction func btnAddToCart(_ sender: Any) {
        if let p = product {
            
            let name = p.yemek_adi
            let image = p.yemek_resim_adi
            let price = Int(p.yemek_fiyat!)
            let productCount = String(self.count)
            
            viewModel.addToCart(yemek_adi: name!, yemek_resim_adi: image!, yemek_fiyat: String(price!), yemek_siparis_adet: productCount, kullanici_adi: "emre")
            
        }
        
        
    }
    
    
    func returnCount()->Int{
        
        return count
        
    }
    
    
}
