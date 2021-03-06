//
//  CharacterDetailsViewController.swift
//  BreakingBadCharacters
//
//  Created by Voro on 1.08.20.
//  Copyright © 2020 GeorgiIvanov. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class CharacterDetailsViewController: UIViewController {
    
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    var character: BreakingBadCharacter!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissButton.alpha = 0
        dismissButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.dismissButton.isHidden = true
            self?.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
                guard let slf = self else {
                    return
                }
                
                slf.tableViewBottomConstraint.constant = -slf.tableView.bounds.size.height
                slf.view.layoutIfNeeded()
            }, completion: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            })
        }).disposed(by: disposeBag)
        
        imageView.kf.setImage(with: character.imageURL)
        
        tableViewBottomConstraint.constant = -(tableView.bounds.size.height + 30)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.tableViewBottomConstraint.constant = 0
            self?.view.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: 0.4, delay: 0.4, options: .curveEaseInOut, animations: { [weak self] in
            self?.dismissButton.alpha = 1
        })
    }
}

// MARK: - Table View Data Source

private struct TableViewMap {
    static let rows = 6
    
    static func nameFor(row: Int, character: BreakingBadCharacter) -> String {
        switch row {
        case 0: return character.name
        case 1: return "Id"
        case 2: return "Birthday"
        case 3: return "Occupation"
        case 4: return "Status"
        case 5: return "Season Appearance"
        case 6: return "Portrayed"
        default: return ""
        }
    }
    
    static func valueFor(row: Int, from character: BreakingBadCharacter) -> String {
        switch row {
        case 0: return character.nickname
        case 1: return "\(character.charId)"
        case 2: return character.birthday
        case 3: return character.joinOccupations()
        case 4: return character.status
        case 5: return character.joinSeasonAppearance()
        case 6: return character.portrayed
        default: return ""
        }
    }
}

extension CharacterDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableViewMap.rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = indexPath.row == 0 ? "characterDetailNameCell" : "characterDetailCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId,
                                                       for: indexPath) as? CharacterDetailCell else {
            return UITableViewCell()
        }
        
        cell.setup(name: TableViewMap.nameFor(row: indexPath.row, character: character),
                   value: TableViewMap.valueFor(row: indexPath.row, from: character))
        
        return cell
    }
    
    
}
