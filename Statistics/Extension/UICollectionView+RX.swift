//
//  UICollectionView+Extension.swift
//  PhotoPicker
//
//  Created by wave on 2018/11/13.
//  Copyright © 2018 wave. All rights reserved.
//

import RxSwift

extension Reactive where Base: UICollectionView {
    
    func items<S: Sequence, Cell: UICollectionViewCell, O : ObservableType>
        (cellType: Cell.Type = Cell.self)
        -> (_ source: O)
        -> (_ configureCell: @escaping (Int, S.Iterator.Element, Cell) -> Void)
        -> Disposable where O.E == S {
            return items(cellIdentifier: String(describing: cellType), cellType: cellType)
    }
    
}
