//
//  NedsTests.swift
//  NedsTests
//
//  Created by 1 on 2023/6/22.
//

import XCTest
@testable import Neds

final class NedsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testNetwork() {
        let expectation = expectation(description: "testNetwork success!")
        Task {
            do {
                let orginData = try await Network.fetchNextRacesInfo(count: 5)
                print(orginData)
                sleep(30)
                expectation.fulfill()
            } catch {
                print(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 60)
    }
    
    func testRaceFilter(orginData:[String: RaceSummary]) {
//        let filter = filterRaceData(raw: orginData)
//
//        switch filter {
//            case .failure(let error):
//                print(error)
//            case .success(let data):
//                let expection
//        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    

}
