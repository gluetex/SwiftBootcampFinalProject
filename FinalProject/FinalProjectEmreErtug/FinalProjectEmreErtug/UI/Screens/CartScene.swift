//
//  CartScene.swift
//  FinalProjectEmreErtug
//
//  Created by Emre Ertuğ on 31.05.2024.
//

import UIKit
import Kingfisher

class CartScene: UIViewController {
    
    @IBOutlet weak var cartTableView: UITableView!
    
    @IBOutlet weak var labelTotalPrice: UILabel!
    
    var cartProductList = [CartProducts]()
    var viewModel = CartViewModel()
    var detail = Details()
    var totalPrice = 0;
    

    @IBAction func btnConfirmCart(_ sender: Any) {
        func showAlertMsg(title: String, message: String) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

            let dismissAction = UIAlertAction(title: "Ok", style: .default)
            alertController.addAction(dismissAction)

            present(alertController, animated: true)

            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                alertController.dismiss(animated: true)
            }
        }

        
    
        showAlertMsg(title: "Sipariş Alındı", message: "Yemeğiniz kısa bir süre içerisinde kurye tarafından teslim edilecektir")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        cartTableView.delegate = self
        cartTableView.dataSource = self
        
        
        _ = viewModel.cartProductList.subscribe(onNext: { list in
            
            self.cartProductList = list
            DispatchQueue.main.async(){
                
                self.cartTableView.reloadData()

            }
            
            
            
        })
}

    override func viewWillAppear(_ animated: Bool) {
        
        viewModel.loadCartProducts(kullanici_adi: "emre")
        labelTotalPrice.text = "0"
    }



}


extension CartScene : UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartProductList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell") as! CartProductCell
        
        let cartProducts = cartProductList[indexPath.row]
        
        
        cell.labelProductName.text = cartProducts.yemek_adi
        cell.labelBasePrice.text = "₺\(String(cartProducts.yemek_fiyat!))"
        cell.labelProductCount.text = cartProducts.yemek_siparis_adet
        cell.labelProductTotalPrice.text = "₺\(String(Int(cartProducts.yemek_fiyat!)! * Int(cartProducts.yemek_siparis_adet!)!))"
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(cartProducts.yemek_resim_adi!)"){
                
                DispatchQueue.main.async {
                    
                    cell.imgCartProduct.kf.setImage(with:url)
                    
                }
            }

            self.totalPrice = totalPrice + (Int(cartProducts.yemek_fiyat!)! * Int(cartProducts.yemek_siparis_adet!)!)
            self.labelTotalPrice.text = "₺\(String(totalPrice))"
        
        
        return cell
    }
    
  
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){ contexualAction, view, bool in
            
            let cartProduct = self.cartProductList[indexPath.row]
            
            let alert = UIAlertController(title: "Delete", message: "\(cartProduct.yemek_adi!) Will be deleted from cart", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default)
            alert.addAction(cancelAction)
            let deleteAction = UIAlertAction(title: "Yes", style: .destructive){ _ in
                
                self.viewModel.deleteCartProduct(sepet_yemek_id: cartProduct.sepet_yemek_id!, kullanici_adi:"emre")
                self.viewModel.loadCartProducts(kullanici_adi: "emre")
                self.totalPrice = 0
                self.labelTotalPrice.text = "0"

            }
            
            alert.addAction(deleteAction)
            
            self.present(alert, animated: true)
        }
    
        return UISwipeActionsConfiguration(actions: [deleteAction])
        
    }
    
    
    
    
}
