//
//  BackgroundSelector.swift
//  Tranquil
//
//  Created by Scott on 02/10/2018.
//  Copyright © 2018 Modulus885. All rights reserved.
//

import Foundation
import UIKit

func backgroundSelector(){
    
    
    if thisSound == 0{
        imageView.loadGif(name: "river2")
    }else if thisSound == 1{
        imageView.loadGif(name: "forestMist")
    }else if thisSound == 2{
        imageView.loadGif(name: "rain2")
    }else if thisSound == 3{
        imageView.loadGif(name: "ocean")
    }
    
}
