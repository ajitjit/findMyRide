//
//  File.swift
//  RideCellTests
//
//  Created by Ajit Nevhal on 08/09/23.
//

import Foundation
import XCTest
@testable import RideCell

class VehicleViewModelTests: XCTestCase {
    
    var vehicleViewModel: VehicleViewModel!
    
    override func setUp() {
        super.setUp()
        vehicleViewModel = VehicleViewModel()
    }
    
    override func tearDown() {
        vehicleViewModel = nil
        super.tearDown()
    }

    func testFetchVehicles() {
        let vehicles = vehicleViewModel.fetchVehicles()
        XCTAssertNotNil(vehicles, "Vehicle list should not be nil")
        XCTAssertGreaterThan(vehicles.count, 0, "There should be at least one vehicle")
    }
    
    func testVehicleAt() {
        let vehicles = vehicleViewModel.fetchVehicles()
        let index = vehicles.count
        let vehicle = vehicleViewModel.vehicleAt(index)
        XCTAssertEqual(vehicle.id, vehicles[index-1].id)
    }
    
    func testVehicleCount() {
        let count = vehicleViewModel.vehicleCount()
        XCTAssertGreaterThanOrEqual(count, 0, "Vehicle count should be non-negative")
    }
    
    func testGetCoordinateArray() {
        let coordinates = vehicleViewModel.getCoordinateArray()
        XCTAssertNotNil(coordinates, "Coordinates should not be nil")
        
        for coordinate in coordinates {
            XCTAssertNotNil(coordinate.0, "Latitude should not be nil")
            XCTAssertNotNil(coordinate.1, "Longitude should not be nil")
        }
    }
    
    func testFindVehicleIndex() {
        let lat = 37.779816
        let lng = -122.395447
        let index = vehicleViewModel.findVehicleIndex(lat, lng)
        XCTAssertNotNil(index, "Vehicle index should not be nil if found")
    }
    
    func testFindVehicleIndexNotFound() {
        let lat = 999.0
        let lng = 999.0 
        let index = vehicleViewModel.findVehicleIndex(lat, lng)
        XCTAssertNil(index, "Vehicle index should be nil if not found")
    }
}
