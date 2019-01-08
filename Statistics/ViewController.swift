//
//  ViewController.swift
//  Statistics
//
//  Created by wave on 2019/1/8.
//  Copyright © 2019 wave. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import SwifterSwift

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let items = BehaviorRelay<[Int]>(value: [0,1,2,3])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StatisticsManager.shared.reportEventId = { eventId in
            debugPrint("eventId--->: \(eventId)")
        }

        configureCollectionView()
    }
}

private extension ViewController {
    
    func configureCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 50)
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.backgroundColor = .blue
        
        collectionView.register(nibWithCellClass: CollectionViewCell.self)
        
        items
            .bind(to: collectionView.rx.items(cellType: CollectionViewCell.self)) { ip, item, cell in
            }
            .disposed(by: rx.disposeBag)
        
        collectionView.rx.itemSelected
            .statistics(ids: ["123", "321", "ewq"])
            .subscribe(onNext: { ip in
            })
            .disposed(by: rx.disposeBag)
    }
    
    func configureTableView() {
    }
}
