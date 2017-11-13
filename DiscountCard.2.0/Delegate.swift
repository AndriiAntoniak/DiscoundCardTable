//
//  Delegate.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 11/9/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import Foundation
import UIKit

protocol ScannerResultDelegate{
    func returnStringBarcode(barcode str:String)
}
protocol CardSortDelegate{
    func sortedCardList(by atribute: SortAttribute)
}

protocol CropImageDelegate {
    func croppingImage(_ image: UIImage)
}
