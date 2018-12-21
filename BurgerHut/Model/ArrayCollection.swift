//
//  ArrayCollection.swift
//  BurgerHut
//
//  Created by Yoga Pratama on 06/12/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import Foundation

class ArrayCollection {
  static let sharedArray = ArrayCollection()
  
  var promoArray : [promo] = []
  var menuArray : [Menu] = []
  var priceArray : [Price] = []
  var cartArray : [cart] = []

}
