//
//  JsonDataService.swift
//  RideCell
//
//  Created by Ajit Nevhal on 06/09/23.
//

import Foundation

class DataService {
    
    static let shared = DataService()
    var vehicles : [Vehicle] = []
    
    private init(){
        decodeJsonData()
    }
    
    private func decodeJsonData(){
        if let url = Bundle.main.url(forResource: "vehicles_data", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let items = try? JSONDecoder().decode([Vehicle].self, from: data) {
             vehicles = items
        } else {
            print("Error loading or decoding JSON data.")
        }
    }
    
    func fetchVehicles() -> [Vehicle] {
        return vehicles
    }
    
    
}
