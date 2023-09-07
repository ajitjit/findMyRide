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
        return vehicles[index]
    }
    
    func vehicleCount() -> Int {
        vehicles.count
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
