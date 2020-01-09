

import UIKit
import MapKit

class ViewController: UIViewController {

	@IBOutlet weak var mapView: MKMapView!

  override func viewDidLoad() {
    super.viewDidLoad()
	let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)

	centerMapOnLocation(location: initialLocation)

	let artwork = Artwork(title: "King David Kalakaua",
						  locationName: "Waikiki Gateway Park",
						  discipline: "Sculpture",
						  coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
	mapView.addAnnotation(artwork)
  }

	// MARK: -> Helper Methods
	let regionRadius: CLLocationDistance = 1000

	// Centers the map on a desired location with the zoom level
	func centerMapOnLocation(location: CLLocation) {
		let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
		mapView.setRegion(coordinateRegion, animated: true)
	}

}

