//
//  FilePOIProviderTests.swift
//  ARLocalizerView
//

import XCTest
@testable import ARLocalizerView

class FilePOIProviderTests: XCTestCase {
    func testFilePOIProvider() {
        let fileURL = Bundle.main.url(forResource: "NetguruOffices", withExtension: "json")!
        let filePOIProvider = FilePOIProvider(fileURL: fileURL)
        XCTAssert(filePOIProvider.pois.count == 9)
    }
}
