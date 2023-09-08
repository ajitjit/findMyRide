//
//  ViewController.swift
//  RideCell
//
//  Created by Ajit Nevhal on 06/09/23.

import UIKit
import MapKit

class ViewController: UIViewController {
    
    let mapView = MKMapView()
    let vehicleViewModel = VehicleViewModel()
    let scrollView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        view.addSubview(scrollView)
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        updateMapForSelectedvehicle(vehicle:vehicleViewModel.fetchVehicles().first)
        configureCollectionView()
        setupAutoLayoutConstraints()
        addVehicleAnnotations()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        scrollView.collectionViewLayout.invalidateLayout()
    }
    
    func addVehicleAnnotations() {
        let coordinatesArray = vehicleViewModel.getCoordinateArray()
        for (index, coordinate) in coordinatesArray.enumerated() {
            let cordinate = CLLocationCoordinate2D(latitude: coordinate.0, longitude: coordinate.1)
            addPin(cordinate: cordinate,index:index)
        }
    }
    
    private func addPin(cordinate:CLLocationCoordinate2D,index:Int){
        let pin = MKPointAnnotation()
        pin.coordinate = cordinate
        pin.title = "\(vehicleViewModel.vehicleAt(index).vehicleMake)"
        pin.subtitle = String(vehicleViewModel.vehicleAt(index).licensePlateNumber)
        mapView.addAnnotation(pin)
    }
    
    func updateMapForSelectedvehicle(vehicle:Vehicle?){
        guard let vehicle = vehicle else {
            return
        }
        if let latitude = vehicle.lat, let longitude = vehicle.lng {
            let cordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            mapView.setRegion(MKCoordinateRegion(center: cordinate, span:MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1) ), animated: true)
        }
    }
    
    func configureCollectionView(){
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.dataSource = self
        scrollView.register(CarCell.self, forCellWithReuseIdentifier: "Cell")
        scrollView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupAutoLayoutConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0/3.0),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2.0/3.0)
        ])
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        vehicleViewModel.availableVehicleCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CarCell
        let vehicle = vehicleViewModel.vehicleAt(indexPath.row)
        cell.bindViewData(vehicle)
        return cell
    }
}

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(systemName: "car.side.rear.open.fill")
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        let cordinate = (annotation.coordinate.latitude,annotation.coordinate.longitude)
        guard let index = vehicleViewModel.findVehicleIndex(cordinate.0, cordinate.1) else {
            return
        }
        scrollView.contentOffset.x = CGFloat(index)*scrollView.frame.width
    }
}

extension ViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
        let index = currentPage
        let vehile = vehicleViewModel.vehicleAt(index)
        updateMapForSelectedvehicle(vehicle: vehile)
    }
}

