//
//  OverpassATMProviderTests.swift
//  ARLocalizerView
//

import XCTest
@testable import ARLocalizerViewSample

class OverpassATMProviderTests: XCTestCase {
    let overpassATMProvider = OverpassATMProvider(
        networkClient: OverpassATMNetworkClient(),
        poiExtractor: OverpassATMExtractor()
    )

    func testFetchingPOIsWithoutLocationBounds() {
        overpassATMProvider.locationBounds = nil
        overpassATMProvider.didUpdate = {
            XCTAssertEqual(self.overpassATMProvider.pois.count, 0)
        }
        triggerUpdateAndGetData()
    }

    func testFetchingPOIsWithError() {
        overpassATMProvider.locationBounds = (south: 12.3, west: 45.6, north: 78.9, east: 1.2)
        overpassATMProvider.didUpdate = {
            XCTAssertEqual(self.overpassATMProvider.pois.count, 0)
        }
        triggerUpdateAndGetData(error: MockError())
    }

    func testFetchingPOIsWithFailedData() {
        overpassATMProvider.locationBounds = (south: 12.3, west: 45.6, north: 78.9, east: 1.2)
        overpassATMProvider.didUpdate = {
            XCTAssertEqual(self.overpassATMProvider.pois.count, 0)
        }
        //This should fail because of App Transport Security:
        triggerUpdateAndGetData(fileURL: URL(string: "http://netguru.com")!)
    }

    func testFetchingPOIs() {
        overpassATMProvider.locationBounds = (south: 12.3, west: 45.6, north: 78.9, east: 1.2)
        overpassATMProvider.didUpdate = {
            XCTAssertEqual(self.overpassATMProvider.pois.count, 58)
        }
        triggerUpdateAndGetData()
    }
}

extension OverpassATMProviderTests {
    func triggerUpdateAndGetData(
        fileURL: URL = Bundle.main.url(forResource: "OverpassSample", withExtension: "xml")!,
        error: Error? = nil
    ) {
        overpassATMProvider.updateAndGetData(
            session: MockSession(
                url: fileURL,
                urlResponse: HTTPURLResponse(
                    url: URL(string: "https://netguru.com")!,
                    statusCode: 200,
                    httpVersion: nil,
                    headerFields: nil
                ),
                error: error
            )
        )
    }
}
