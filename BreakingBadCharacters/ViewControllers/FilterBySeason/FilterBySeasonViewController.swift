//
//  FilterBySeasonViewController.swift
//  BreakingBadCharacters
//
//  Created by Voro on 1.08.20.
//  Copyright © 2020 GeorgiIvanov. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class FilterBySeasonViewController: UIViewController {
    
    @IBOutlet var seasonFilterButtons: [FilterButton]!
    
    var currentFilters = [Int]()
    var filterBySeasons: (([Int]) -> Void)?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for btn in seasonFilterButtons {
            if currentFilters.contains(btn.season) {
                btn.toggleSelectedState()
            }
            
            btn.rx.tap.subscribe(onNext: { [weak btn, weak self] in
                btn?.toggleSelectedState()
                if let slf = self {
                    slf.filterBySeasons?(slf.createFilterArray())
                }
            }).disposed(by: disposeBag)
        }
    }
    
    func createFilterArray() -> [Int] {
        return seasonFilterButtons.compactMap { btn in
            btn.filterEnabled ? btn.season : nil
        }
    }
}
