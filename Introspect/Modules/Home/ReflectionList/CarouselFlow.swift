//
//  CarouselFlow.swift
//  Introspect
//
//  Created by Andreas Lüdemann on 04/01/2020.
//  Copyright © 2020 Andreas Lüdemann. All rights reserved.
//

import UIKit

class CarouselFlowLayout: PageCollectionLayout {
    
    // MARK: - Public properties
    
    public static var cellSize: CGSize {
        return CGSize(width: 300, height: 500)
    }
    
    // MARK: - Init
    
    override public init(itemSize: CGSize = CarouselFlowLayout.cellSize) {
        super.init(itemSize: itemSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        itemSize = CarouselFlowLayout.cellSize
    }
}
