//
//  TestNetworkService.swift
//  TestTaskTests
//
//  Created by Andrey Bekhtold on 27.06.2021.
//

import XCTest
@testable import TestTask

class TestNetworkService: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        launches = nil
    }

    var launches: [Launch]?
    
    func testEmptyData() throws {
        XCTAssertNoThrow(
            self.launches = try NetworkService.decodeWithISO8601(self.emptyData)
        )
    }
    func testInvalidData() throws {
        XCTAssertThrowsError(
            self.launches = try NetworkService.decodeWithISO8601(self.invalidData)
        )
        
        
    }
    func testDateUTC() throws {
        XCTAssertNoThrow(
            self.launches = try NetworkService.decodeWithISO8601(self.dateUTC)
        )
        let launch = launches?.first
        XCTAssertNotNil(launch)
        XCTAssertNotNil(launch?.date)
        
    }
    func testValidData() throws {
        XCTAssertNoThrow(
            self.launches = try NetworkService.decodeWithISO8601(self.validFullData)
        )
        let launch = launches?.first
        XCTAssertNotNil(launch)
        XCTAssertEqual(launch?.id, 1000)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            try? testValidData() // Пока не разобрался...
        }
    }
    
    // MARK: Mock response JSON
    
    let emptyData: Data? = "[]".data(using: .utf8)
    
    let invalidData: Data? = "🤪".data(using: .utf8)
    
    let dateUTC: Data? = """
        [{
            "flight_number": 10000,
            "name": "Mock Launch",
            "date_utc": "2021-02-04T06:19:00.000Z",
            "date_local": "2021-02-04T01:19:00-05:00"
        }]
    """.data(using: .utf8)
    
    let validFullData: Data? = """
        [{
        "fairings": {
            "reused": true,
            "recovery_attempt": true,
            "recovered": null,
            "ships": [
                "5ea6ed2e080df4000697c908",
                "5ea6ed2e080df4000697c907"
            ]
        },
        "links": {
            "patch": {
                "small": "https://imgur.com/BrW201S.png",
                "large": "https://imgur.com/573IfGk.png"
            },
            "reddit": {
                "campaign": "https://www.reddit.com/r/spacex/comments/jhu37i/starlink_general_discussion_and_deployment_thread/",
                "launch": "https://www.reddit.com/r/spacex/comments/lbjuok/rspacex_starlink18_official_launch_discussion/",
                "media": null,
                "recovery": "https://www.reddit.com/r/spacex/comments/k2ts1q/rspacex_fleet_updates_discussion_thread/"
            },
            "flickr": {
                "small": [],
                "original": [
                    "https://live.staticflickr.com/65535/50908787351_5733229c09_o.jpg",
                    "https://live.staticflickr.com/65535/50908092893_d254477be0_o.jpg",
                    "https://live.staticflickr.com/65535/50908092833_4cb5833fb9_o.jpg",
                    "https://live.staticflickr.com/65535/50908787221_9cf383a2b4_o.jpg",
                    "https://live.staticflickr.com/65535/50908787166_8dde2e29bd_o.jpg"
                ]
            },
            "presskit": null,
            "webcast": "https://youtu.be/fe6HBw1y6bA",
            "youtube_id": "fe6HBw1y6bA",
            "article": null,
            "wikipedia": "https://en.wikipedia.org/wiki/Starlink"
        },
        "static_fire_date_utc": null,
        "static_fire_date_unix": null,
        "tbd": false,
        "net": false,
        "window": null,
        "rocket": "5e9d0d95eda69973a809d1ec",
        "success": true,
        "details": "This mission launches the eighteenth batch of operational Starlink satellites, which are version 1.0, from SLC-40. It is the nineteenth Starlink launch overall. The satellites will be delivered to low Earth orbit and will spend a few weeks maneuvering to their operational altitude. The booster is expected to land on an ASDS.",
        "crew": [],
        "ships": [
            "5ea6ed30080df4000697c913",
            "601742b20c87b90be7bb7e86",
            "5ea6ed2e080df4000697c908",
            "5ea6ed2e080df4000697c907",
            "5ea6ed2f080df4000697c90b"
        ],
        "capsules": [],
        "payloads": [
            "5ff655769257f579ee3a6c64"
        ],
        "launchpad": "5e9e4501f509094ba4566f84",
        "auto_update": true,
        "launch_library_id": "f31702e8-6353-4c9a-932c-5bd104717500",
        "failures": [],
        "flight_number": 1000,
        "name": "FULL VALID NAME",
        "date_utc": "2021-02-04T06:19:00.000Z",
        "date_unix": 1612419540,
        "date_local": "2021-02-04T01:19:00-05:00",
        "date_precision": "hour",
        "upcoming": false,
        "cores": [
            {
                "core": "5ef670f10059c33cee4a826c",
                "flight": 5,
                "gridfins": true,
                "legs": true,
                "reused": true,
                "landing_attempt": true,
                "landing_success": true,
                "landing_type": "ASDS",
                "landpad": "5e9e3032383ecb6bb234e7ca"
            }
        ],
        "id": "5ff6554f9257f579ee3a6c5f"
    }]
""".data(using: .utf8)

}
