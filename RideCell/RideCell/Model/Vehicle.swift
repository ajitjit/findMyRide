import Foundation

struct Vehicle: Codable {
    let id: Int
    let isActive: Bool
    let isAvailable: Bool
    let lat: Double?
    let lng: Double?
    let licensePlateNumber: String
    let pool: String
    let remainingMileage: Int
    let remainingRangeInMeters: Int?
    let transmissionMode: String?
    let vehicleMake: String
    let vehiclePic: String
    let vehiclePicAbsoluteURL: String
    let vehicleType: String
    let vehicleTypeID: Int

    enum CodingKeys: String, CodingKey {
        case id
        case isActive = "is_active"
        case isAvailable = "is_available"
        case lat
        case lng
        case licensePlateNumber = "license_plate_number"
        case pool
        case remainingMileage = "remaining_mileage"
        case remainingRangeInMeters = "remaining_range_in_meters"
        case transmissionMode = "transmission_mode"
        case vehicleMake = "vehicle_make"
        case vehiclePic = "vehicle_pic"
        case vehiclePicAbsoluteURL = "vehicle_pic_absolute_url"
        case vehicleType = "vehicle_type"
        case vehicleTypeID = "vehicle_type_id"
    }
}
