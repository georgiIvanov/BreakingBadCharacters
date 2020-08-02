//
//  CharactersViewModelTests.swift
//  BreakingBadCharactersTests
//
//  Created by Voro on 2.08.20.
//  Copyright © 2020 GeorgiIvanov. All rights reserved.
//

import XCTest
import RxSwift

@testable import BreakingBadCharacters

class CharactersViewModelTests: XCTestCase {
    
    let disposeBag = DisposeBag()
    let container = AppDelegate.container

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func testGetAllCharacters() throws {
        let expectation = self.expectation(description: "Get and serialize all characters.")
        
        let vm = container.resolve(CharactersViewModelProtocol.self)!
        vm.fetchCharacters()
        vm.characters.drive(onNext: { (all) in
            XCTAssertEqual(all.count, 57)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testFilterByNameSingleResult() throws {
        let expectation = self.expectation(description: "Get one character.")
        
        let vm = container.resolve(CharactersViewModelProtocol.self)!
        vm.fetchCharacters()
        vm.filterBy(name: "Gu")
        vm.characters.drive(onNext: { (chars) in
            XCTAssertEqual(chars.count, 1)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testFilterByNameAndSeasonNone() throws {
        let expectation = self.expectation(description: "No results.")
        
        let vm = container.resolve(CharactersViewModelProtocol.self)!
        vm.fetchCharacters()
        vm.filterBy(name: "Gu")
        vm.filterBy(seasonAppearance: [1, 5])
        
        vm.characters.drive(onNext: { (chars) in
            XCTAssertEqual(chars.count, 0)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testFilterByNameAndSeasonSingle() throws {
        let expectation = self.expectation(description: "Single result.")
        
        let vm = container.resolve(CharactersViewModelProtocol.self)!
        vm.fetchCharacters()
        vm.filterBy(name: "Tod")
        vm.filterBy(seasonAppearance: [5])
        
        vm.characters.drive(onNext: { (chars) in
            XCTAssertEqual(chars.count, 1)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testAllFromSeasonThree() throws {
        let expectation = self.expectation(description: "Get all characters from season three.")
        
        let vm = container.resolve(CharactersViewModelProtocol.self)!
        vm.fetchCharacters()
        vm.filterBy(seasonAppearance: [3])
        
        vm.characters.drive(onNext: { (chars) in
            XCTAssertEqual(chars.count, 40)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testAllFromSeasonThreeAndFive() throws {
        let expectation = self.expectation(description: "Get intersection of all characters from season three and five.")
        
        let vm = container.resolve(CharactersViewModelProtocol.self)!
        vm.fetchCharacters()
        vm.filterBy(seasonAppearance: [3, 5])
        
        vm.characters.drive(onNext: { (chars) in
            XCTAssertEqual(chars.count, 20)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testFilterByNameAndSeasonMultiple() throws {
        let expectation = self.expectation(description: "Get 3 characters with mar in their name.")
        
        let vm = container.resolve(CharactersViewModelProtocol.self)!
        let searchName = "mar"
        vm.fetchCharacters()
        vm.filterBy(name: searchName)
        vm.filterBy(seasonAppearance: [2])
        
        vm.characters.drive(onNext: { (chars) in
            XCTAssertEqual(chars.count, 3)
            chars.forEach { (char) in
                XCTAssert(char.name.localizedCaseInsensitiveContains(searchName))
            }
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testApplyAndRemoveFilters() throws {
        let expectation = self.expectation(description: "Get all characters.")
        let vm = container.resolve(CharactersViewModelProtocol.self)!
        
        vm.fetchCharacters()
        vm.filterBy(name: "mo")
        vm.filterBy(seasonAppearance: [1])
        vm.filterBy(seasonAppearance: [1, 2])
        vm.filterBy(name: "")
        
        vm.characters.drive(onNext: { (chars) in
            XCTAssertEqual(chars.count, 20)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        waitForExpectations(timeout: 2, handler: nil)
    }
}
