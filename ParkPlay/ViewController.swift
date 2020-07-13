//
//  ViewController.swift
//  ParkPlay
//
//  Created by Paul Peelen on 2020-07-06.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

  @IBOutlet weak var mapView: MKMapView!

  private var locationManager: CLLocationManager?

  override func viewDidLoad() {
    super.viewDidLoad()

    let location = CLLocationCoordinate2D(latitude: 59.3293235, longitude: 18.0685808)
    let region = MKCoordinateRegion(center: location, latitudinalMeters: CLLocationDistance(300), longitudinalMeters: 300)
    mapView.setRegion(region, animated: false)

    askForLocation()
  }
}

extension ViewController: MKMapViewDelegate {

}

extension ViewController: CLLocationManagerDelegate {

  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedWhenInUse || status == .authorizedAlways {
      locationManager?.startUpdatingLocation()
    }
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let coordinate = manager.location?.coordinate else { return }
    let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: CLLocationDistance(300), longitudinalMeters: 300)
    mapView.setRegion(coordinateRegion, animated: true)
  }
}

private extension ViewController {

  func askForLocation() {
    locationManager = CLLocationManager()
    locationManager?.delegate = self
    locationManager?.requestAlwaysAuthorization()
  }
}
