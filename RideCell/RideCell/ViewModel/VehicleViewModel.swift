//
//  VehicleViewModel.swift
//  RideCell
//
//  Created by Ajit Nevhal on 07/09/23.
//

import Foundation

class VehicleViewModel {
    
    private var vehicles : [Vehicle] = DataService.shared.fetchVehicles()
    
    func fetchVehicles() -> [Vehicle] {
        return vehicles
    }
    
    func vehicleAt(_ index:Int) -> Vehicle {
        if index < vehicles.count {
            return vehicles[index]
        } else {
            let index = vehicles.count - 1
            return vehicles[index] //last Vehicle
        }
    }
    
    func vehicleCount() -> Int {
        vehicles.count
    }
    
    func availableVehicleCount() -> Int {
        return getCoordinateArray().count
    }
    
    func getCoordinateArray() -> [(Double,Double)] {
        let coordinatesArray: [(Double, Double)] = vehicles.compactMap { (vehicle) -> (Double, Double)? in
            if let latitude = vehicle.lat, let longitude = vehicle.lng {
                return (latitude, longitude)
            } else {
                return nil
            }
        }
        return coordinatesArray
    }
    
    func findVehicleIndex(_ lat: Double,_ lng: Double) -> Int?{
        for i in 0..<vehicles.count {
            if vehicles[i].lat == lat && vehicles[i].lng == lng {
                return i
            }
        }
        return nil
    }
    
}
