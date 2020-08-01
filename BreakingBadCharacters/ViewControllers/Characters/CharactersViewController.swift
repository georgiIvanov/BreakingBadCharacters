//
//  CharactersViewController.swift
//  BreakingBadCharacters
//
//  Created by Voro on 31.07.20.
//  Copyright © 2020 GeorgiIvanov. All rights reserved.
//

import UIKit
import RxSwift

class CharactersViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: CharactersViewModelProtocol!
    var characters: [BreakingBadCharacter] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        viewModel.fetchCharacters()
        
        viewModel.characters.drive(onNext: { [weak self] (characters) in
            self?.characters = characters
        }).disposed(by: disposeBag)
    }
    
    func setupUI() {
        let layout = ZoomAndSnapFlowLayout()
        let sizePercent: CGFloat = 0.6
        let verticalInset: CGFloat = 20
        let collectionSize = view.frame.size
        layout.itemSize = CGSize(width: collectionSize.width * sizePercent,
                                 height: collectionSize.height * sizePercent - verticalInset)
        
        collectionView.collectionViewLayout = layout
        collectionView.contentInsetAdjustmentBehavior = .always
    }
}

// MARK: - Collection View Datasource

extension CharactersViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell",
                                                            for: indexPath) as? CharacterCell else {
            return UICollectionViewCell()
        }
        
        cell.setup(characters[indexPath.item])
        
        return cell
    }
    
    
}
