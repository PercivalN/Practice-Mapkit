//
//  Artwork.swift
//  HonoluluArt
//
//  Created by Percy Ngan on 1/9/20.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class Artwork: NSObject, MKAnnotation {
	let title: String?
	let locationName: String
	let discipline: String
	let coordinate: CLLocationCoordinate2D

	init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
		self.title = title
		self.locationName = locationName
		self.discipline = discipline
		self.coordinate = coordinate

		super.init()
	}

	init?(json: [Any]) {
		self.title = json[16] as? String ?? "No Title"
		self.locationName = json[11] as! String
		self.discipline = json[15] as! String

		if let latitude = Double(json[18] as! String),
			let longitude = Double(json[19] as! String) {
			self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
		} else {
			self.coordinate = CLLocationCoordinate2D()
		}
	}

	var subtitle: String? {
		return locationName
	}

	var markerTintColor: UIColor {
		switch discipline {
		case "Monument":
			return .red
		case "Mural":
			return .cyan
		case "Plaque":
			return .blue
		case "Sculpture":
			return .purple
		default:
			return .green
		}
	}


	// Helper Methods
	func mapItem() -> MKMapItem {
		let addressDict = [CNPostalAddressStreetKey: subtitle]
		let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict as [String : Any])
		let mapItem = MKMapItem(placemark: placemark)
		mapItem.name = title
		return mapItem
	}
}

