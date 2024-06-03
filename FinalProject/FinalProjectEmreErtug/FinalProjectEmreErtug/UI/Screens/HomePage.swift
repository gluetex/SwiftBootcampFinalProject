//
//  ViewController.swift
//  FinalProjectEmreErtug
//
//  Created by Emre Ertuğ on 26.05.2024.
//

import UIKit
import Alamofire
import Kingfisher

class HomePage: UIViewController {
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    
    var productList = [Yemekler]()
    var viewModel = HomePageViewModel()
    var searcBar = UISearchBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        
        searcBar.backgroundColor = UIColor.mainTheme
        searcBar.barTintColor = UIColor.mainTheme
                
        _ = viewModel.productList.subscribe(onNext: { list in
            
            self.productList = list
            DispatchQueue.main.async(){
                
                self.productsCollectionView.reloadData()

            }
        })
        
        
        let design = UICollectionViewFlowLayout()
        
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        design.minimumLineSpacing = 10
        
        let screenWidth = UIScreen.main.bounds.width
        
        let itemNum = 2
        
        let itemWidth = (Int(screenWidth)-60) / itemNum
        
        
        design.itemSize = CGSize(width: itemWidth, height: 240)
        
        productsCollectionView.collectionViewLayout = design
    }

    override func viewWillAppear(_ animated: Bool) {
        
        viewModel.loadProducts()
        
      
    }
    
    
    

}




extension HomePage : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCell
        
        let product = productList[indexPath.row]
        
   
            
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(product.yemek_resim_adi!)"){
                
                DispatchQueue.main.async {
                    
                    cell.imageCell.kf.setImage(with:url)
                    
                }
                
            }
            
            
        
        
        cell.nameCell.text = product.yemek_adi
        cell.priceCell.text = "₺\(product.yemek_fiyat!)"

        
        
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.3
        cell.layer.cornerRadius = 10.0
        
        
        
        
        
        return cell
        
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = productList[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: product)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetail"{
            if let product = sender as? Yemekler{
                let vc = segue.destination as! Details
                vc.product = product
            }
            
        }
    }
    
}

