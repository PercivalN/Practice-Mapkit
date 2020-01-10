//
//  ArtworkViews.swift
//  HonoluluArt
//
//  Created by Percy Ngan on 1/10/20.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import MapKit

class ArtworkMarkerView: MKMarkerAnnotationView {
	override var annotation: MKAnnotation? {

		willSet {
			guard let artwork = newValue as? Artwork else { return }

			canShowCallout = true
			calloutOffset = CGPoint(x: -5, y: 5)
			//rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
			let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
			mapsButton.setBackgroundImage(UIImage(named: "Maps-icon"), for: UIControl.State())
			rightCalloutAccessoryView = mapsButton
			markerTintColor = artwork.markerTintColor
			glyphText = String(artwork.discipline.first!)

			let detailLabel = UILabel()
			detailLabel.numberOfLines = 0
			detailLabel.font = detailLabel.font.withSize(12)
			detailLabel.text = artwork.subtitle
			detailCalloutAccessoryView = detailLabel
		}
	}
}
