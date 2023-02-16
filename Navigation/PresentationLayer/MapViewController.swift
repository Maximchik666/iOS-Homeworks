//
//  MapViewController.swift
//  Navigation
//
//  Created by Maksim Kruglov on 21.01.2023.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
import TinyConstraints

class MapViewController: UIViewController {
    
    weak var coordinator: MapTabCoordinator?
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        return locationManager
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        mapView.mapType = .standard
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        let pointsOfInterestFilter = MKPointOfInterestFilter()
        mapView.pointOfInterestFilter = pointsOfInterestFilter
        
        // Москва
        let initialLocation = CLLocationCoordinate2D(
            latitude: 55.75222,
            longitude: 37.61556
        )
        
        mapView.setCenter(initialLocation, animated: false)
        
        let region = MKCoordinateRegion(
            center: initialLocation,
            latitudinalMeters: 10_000,
            longitudinalMeters: 10_000
        )
        
        mapView.setRegion(region,animated: false)
        
        return mapView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        findUserLocation()
        addTapGestureRecogniser()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        locationManager.requestLocation()
    }
    
    func setConstraints () {
        self.view.addSubview(mapView)
        mapView.edgesToSuperview()
    }
    
    private func findUserLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
    }
    
    func addTapGestureRecogniser () {
        let uilgr = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotation))
        uilgr.minimumPressDuration = 2.0
        self.mapView.addGestureRecognizer(uilgr)
    }
    
    @objc private func addAnnotation(gestureRecognizer:UIGestureRecognizer) {
        
        // Очищаем карту от предыдущих пинов и маршрутов
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        
        // Добавление пина
        var touchPoint = gestureRecognizer.location(in: mapView)
        var newCoordinates = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = newCoordinates
        mapView.addAnnotation(annotation)
        
        // Построение Маршрута
        showRouteOnMap(pickupCoordinate: locationManager.location?.coordinate ?? CLLocationCoordinate2D(
            latitude: 55.75222,
            longitude: 37.61556),
                       destinationCoordinate: newCoordinates)
        
    }
    
    // Метод Расчета маршрута и центрирования Карты на него
    func showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            
            //Выбор одного маршрута
            if let route = unwrappedResponse.routes.first {
                //Показываем на карте
                self.mapView.addOverlay(route.polyline)
                //Центрируем карту на маршруте
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets.init(top: 80.0, left: 20.0, bottom: 100.0, right: 20.0), animated: true)
            }
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.setCenter(location.coordinate, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager,didFailWithError error: Error) {
        print("!!!!!!!!!!! \(error.localizedDescription) !!!!!!!!!!!!!!!!!")
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 5.0
        return renderer
    }
}
