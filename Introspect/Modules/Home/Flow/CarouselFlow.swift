//
//  CarouselFlow.swift
//  Introspect
//
//  Created by Andreas Lüdemann on 04/01/2020.
//  Copyright © 2020 Andreas Lüdemann. All rights reserved.
//

import UI
import UIKit

class CarouselFlowLayout: PageCollectionLayout {
    
    static var cellSize: CGSize {
        return CGSize(width: 300, height: 500)
    }
    
    override public init(itemSize: CGSize = CarouselFlowLayout.cellSize) {
        super.init(itemSize: itemSize)
        //scrollDirection = .horizontal
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        itemSize = CarouselFlowLayout.cellSize
        //scrollDirection = .horizontal
    }
}
