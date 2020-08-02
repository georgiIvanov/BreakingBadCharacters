//
//  CharactersViewModel.swift
//  BreakingBadCharacters
//
//  Created by Voro on 31.07.20.
//  Copyright © 2020 GeorgiIvanov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol CharactersViewModelProtocol: class {
    func fetchCharacters()
    func filterBy(name: String)
    func filterBy(seasonAppearance: [Int])
    
    var characters: Driver<[BreakingBadCharacter]> { get }
    var nameFilter: String { get }
    var seasonsFilter: [Int] { get }
}

class CharactersViewModel {

    let breakingBadService: BreakingBadApiServiceProtocol
    let disposeBag = DisposeBag()

    let fetchedCharacters = PublishSubject<[BreakingBadCharacter]>()
    let nameFilterSubject = BehaviorSubject<String>(value: "")
    let seasonAppearanceFilterSubject = BehaviorSubject<[Int]>(value: [])

    init(breakingBadService: BreakingBadApiServiceProtocol) {
        self.breakingBadService = breakingBadService
    }
}

extension CharactersViewModel: CharactersViewModelProtocol {
    func fetchCharacters() {
        breakingBadService.fetchCharacters().subscribe(onSuccess: { [weak self] (characters) in
            self?.fetchedCharacters.onNext(characters)
        }, onError: { (error) in
            // TODO: Propagate error
            print(error)
        }).disposed(by: disposeBag)
    }
    
    func filterBy(name: String) {
        nameFilterSubject.onNext(name)
    }
    
    func filterBy(seasonAppearance: [Int]) {
        seasonAppearanceFilterSubject.onNext(seasonAppearance)
    }

    var characters: Driver<[BreakingBadCharacter]> {
        return Observable.combineLatest(fetchedCharacters,
                                        nameFilterSubject,
                                        seasonAppearanceFilterSubject) { (characters, name, seasons) in
                                    // TODO: Remove characters that are only from Better Call Saul
                                    var result = filterCharacters(characters, byName: name)
                                    result = filterCharacters(result, bySeasons: seasons)
                                    return result
        }.asDriver(onErrorJustReturn: [])
    }
    
    var nameFilter: String {
        let value = try? nameFilterSubject.value()
        return value ?? ""
    }
    
    var seasonsFilter: [Int] {
        let value = try? seasonAppearanceFilterSubject.value()
        return value ?? []
    }
}

private func filterCharacters(_ characters: [BreakingBadCharacter], byName name: String) -> [BreakingBadCharacter] {
    guard name.isEmpty == false else {
        return characters
    }
    
    return characters.filter { (char) -> Bool in
        char.name.localizedCaseInsensitiveContains(name)
    }
}

private func filterCharacters(_ characters: [BreakingBadCharacter],
                              bySeasons seasonAppearance: [Int]) -> [BreakingBadCharacter] {
    guard seasonAppearance.isEmpty == false else {
        return characters
    }
    
    return characters.filter { (char) -> Bool in
        for app in seasonAppearance {
            if char.appearance.contains(app) == false {
                return false
            }
        }
        return true
    }
}
