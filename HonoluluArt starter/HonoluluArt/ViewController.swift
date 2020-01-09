

import UIKit
import MapKit

class ViewController: UIViewController {

	@IBOutlet weak var mapView: MKMapView!

  override func viewDidLoad() {
    super.viewDidLoad()
	let initialLocation = CLLocation(latitude: 32.957690, longitude: -97.151330)

	centerMapOnLocation(location: initialLocation)
  }

	// MARK: -> Helper Methods
	let regionRadius: CLLocationDistance = 1000

	// Centers the map on a desired location with the zoom level
	func centerMapOnLocation(location: CLLocation) {
		let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
		mapView.setRegion(coordinateRegion, animated: true)
	}

}

