

import UIKit
import MapKit

class ViewController: UIViewController {

	@IBOutlet weak var mapView: MKMapView!

	// MARK: - Properties
	var artworks: [Artwork] = []

  override func viewDidLoad() {
    super.viewDidLoad()
	let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)

	centerMapOnLocation(location: initialLocation)

	mapView.delegate = self

//	let artwork = Artwork(title: "King David Kalakaua",
//						  locationName: "Waikiki Gateway Park",
//						  discipline: "Sculpture",
//						  coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
//	mapView.addAnnotation(artwork)

	mapView.register(ArtworkMarkerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)

	loadInitialData()
	mapView.addAnnotations(artworks)
  }

	// MARK: -> Helper Methods
	let regionRadius: CLLocationDistance = 1000

	// Centers the map on a desired location with the zoom level
	func centerMapOnLocation(location: CLLocation) {
		let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
		mapView.setRegion(coordinateRegion, animated: true)
	}

	func loadInitialData() {
		guard  let fileName = Bundle.main.path(forResource: "PublicArt", ofType: "json") else { return }

		let optionalData = try? Data(contentsOf: URL(fileURLWithPath: fileName))

		guard let data = optionalData,
			let json = try? JSONSerialization.jsonObject(with: data),
			let dictionary = json as? [String: Any],
		let works = dictionary["data"] as? [[Any]]
			else { return }
		let validWorks = works.compactMap { Artwork(json: $0) }
		artworks.append(contentsOf: validWorks)
	}
}

extension ViewController: MKMapViewDelegate {

	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		guard let annotation = annotation as? Artwork else { return nil }

		let identifier = "marker"
		var view: MKMarkerAnnotationView

		if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
			dequeuedView.annotation = annotation
			view = dequeuedView
		} else {
			view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
			view.canShowCallout = true
			view.calloutOffset = CGPoint(x: -5, y: 5)
			view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
		}
		return view
	}

//	func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
//				 calloutAccessoryControlTapped control: UIControl) {
//		let location = view.annotation as! Artwork
//		let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
//		location.mapItem().openInMaps(launchOptions: launchOptions)
//	}
}

