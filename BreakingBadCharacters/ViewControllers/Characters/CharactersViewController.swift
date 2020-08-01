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
    var filterButton: UIButton!
    
    var viewModel: CharactersViewModelProtocol!
    var searchController: UISearchController!
    var characters: [BreakingBadCharacter] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let transitionAnimator = PopAnimator()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFilterButton()
        setupUI()
        bindUI()
        
        viewModel.fetchCharacters()
        
        viewModel.characters.drive(onNext: { [weak self] (characters) in
            print("Chars in season \(characters.count)")
            self?.characters = characters
        }).disposed(by: disposeBag)
    }
    
    func setupUI() {
        let layout = ZoomAndSnapFlowLayout()
        let sizePercent: CGFloat = 0.54
        let verticalInset: CGFloat = 20
        let collectionSize = view.frame.size
        layout.itemSize = CGSize(width: collectionSize.width * sizePercent,
                                 height: collectionSize.height * sizePercent - verticalInset)
        
        collectionView.collectionViewLayout = layout
        collectionView.contentInsetAdjustmentBehavior = .always
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.delegate = self
        
        
        let stackView = UIStackView(arrangedSubviews: [searchController.searchBar, filterButton])
        stackView.axis = .horizontal
        stackView.spacing = 8
        navigationItem.titleView = stackView
        definesPresentationContext = true
        modalPresentationStyle = .overCurrentContext
        
        transitionAnimator.dismissCompletion = { [weak self] in
            guard let selectedIndexPathCell = self?.collectionView.indexPathsForSelectedItems,
                let selectedCell = self?.collectionView.cellForItem(at: selectedIndexPathCell[0]) as? CharacterCell
            else {
              return
          }

          selectedCell.imageView.isHidden = false
        }
    }
    
    func setupFilterButton() {
        let filterButton = UIButton()
        self.filterButton = filterButton
        filterButton.setBackgroundImage(UIImage(named: "baseline_filter_alt_white_48pt"), for: .normal)
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        
        let widthConstraint = NSLayoutConstraint(item: filterButton,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                 multiplier: 1, constant: 30)
        
        let heightConstraint = NSLayoutConstraint(item: filterButton,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil,
                                                  attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1, constant: 30)
        
        filterButton.addConstraints([heightConstraint, widthConstraint])
        filterButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.performSegue(withIdentifier: "filterBySeasonSegue", sender: self)
        }).disposed(by: disposeBag)
    }
    
    func bindUI() {
        searchController.searchBar.rx.text.subscribe(onNext: { [weak self] (text) in
            let searchText = text ?? ""
            self?.viewModel.filterBy(name: searchText)
        }).disposed(by: disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
        searchController.searchBar.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let filterVc = segue.destination as? FilterBySeasonViewController {
            filterVc.currentFilters = viewModel.seasonsFilter
            filterVc.filterBySeasons = { [weak self] (seasons) in
                self?.viewModel.filterBy(seasonAppearance: seasons)
            }
        } else if let detailsVc = segue.destination as? CharacterDetailsViewController,
            let character = sender as? BreakingBadCharacter {
            detailsVc.character = character
            detailsVc.transitioningDelegate = self
            detailsVc.modalPresentationStyle = .fullScreen
        }
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

extension CharactersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchController.searchBar.endEditing(true)
        performSegue(withIdentifier: "characterDetailsSegue", sender: characters[indexPath.item])
    }
}


// MARK: - UISearchBarDelegate

extension CharactersViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = viewModel.nameFilter
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension CharactersViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let selectedIndexPathCell = collectionView.indexPathsForSelectedItems,
            let selectedCell = collectionView.cellForItem(at: selectedIndexPathCell[0]) as? CharacterCell,
          let selectedCellSuperview = selectedCell.superview
          else {
            return nil
        }

        transitionAnimator.originFrame = selectedCellSuperview.convert(selectedCell.frame, to: nil)
        transitionAnimator.originFrame = CGRect(
          x: transitionAnimator.originFrame.origin.x,
          y: transitionAnimator.originFrame.origin.y,
          width: transitionAnimator.originFrame.size.width,
          height: transitionAnimator.originFrame.size.height
        )

        transitionAnimator.presenting = true
        selectedCell.imageView.isHidden = true
        return transitionAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionAnimator.presenting = false
        return transitionAnimator
    }
}
