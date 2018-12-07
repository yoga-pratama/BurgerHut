//
//  HomeTableCellTableViewCell.swift
//  BurgerHut
//
//  Created by Yoga Pratama on 06/12/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import UIKit

class HomeTableCellTableViewCell: UITableViewCell {
    
    @IBOutlet var homeCollectionView : UICollectionView!
    
   let sharedArray = ArrayCollection.sharedArray
   var TableSize : String!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.homeCollectionView.delegate = self
        self.homeCollectionView.dataSource = self
       
        
      
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  
}

extension HomeTableCellTableViewCell : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var sectionSize : Int!
        switch TableSize {
        case "small_banner":
            sectionSize = self.sharedArray.promoArray.filter{
                $0.promo_type.contains("small")
            }.count
        case "menu_banner" :
            sectionSize = self.sharedArray.menuArray.count
        case "large_banner":
            sectionSize = self.sharedArray.promoArray.filter{
                $0.promo_type.contains("large")
                }.count
        default:
       
            sectionSize = 2
        }
        
        return sectionSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionCell", for: indexPath) as! homeCollectionViewCell
        
        switch TableSize {
        case "small_banner":
            let promoSmall =  sharedArray.promoArray.filter{
                return $0.promo_type.contains("small")
            }
            let promoSmallContent = promoSmall[indexPath.row]
            let image = UIImage(named: promoSmallContent.promo_pic)
            let imageSize = image?.size
            cell.promoImage.image = image
            cell.promoImage.layer.cornerRadius = 5
        case "menu_banner" :
            let menu =  sharedArray.menuArray[indexPath.row]
            let image = UIImage(named: menu.menu_pic)
            cell.promoImage.image = image
            cell.promoImage.layer.cornerRadius = 5
        case "large_banner":
            let promoLarge =  sharedArray.promoArray.filter{
                 return $0.promo_type.contains("large")
            }
            let promoLargeContent = promoLarge[indexPath.row]
            let image = UIImage(named: promoLargeContent.promo_pic)
            cell.promoImage.image = image
            cell.promoImage.layer.cornerRadius = 5
         //   cell.promoImage.frame = CGRect(x: 0, y: 0, width: 100 , height: 100)
        default:
            let promo =  sharedArray.promoArray[indexPath.row]
            let image = UIImage(named: promo.promo_pic)
            cell.promoImage.image = image
            cell.promoImage.layer.cornerRadius = 5
        }
        
        
      
       
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var sizeCell : CGSize!
    
        switch TableSize {
        case "small_banner":
            sizeCell = CGSize(width: 370, height: 150)
        case "menu_banner" :
            sizeCell = CGSize(width: 150, height: 150)
        case "large_banner":
            sizeCell = CGSize(width: 370 , height: 250)
        default:
            sizeCell = CGSize(width: 370, height: 150)
        }
        
        return sizeCell
    }
    
 
}
