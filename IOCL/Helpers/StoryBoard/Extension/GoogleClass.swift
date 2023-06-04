//
//  GoogleClass.swift
//  Door2Door
//
//  Created by OS on 05/08/21.
//

import Foundation
import UIKit

final public class GoogleMapsURIConstructor {

  public enum NavigationType: String {

    case driving
    case transit
    case walking
  }

  public class func prepareURIFor(latitude lat: Double,
                                  longitude long: Double,
                                  fromLatitude fromLat: Double? = nil,
                                  fromLongitude fromLong: Double? = nil,
                                  navigation navigateBy: NavigationType) -> URL? {
    if let googleMapsRedirect = URL(string: "comgooglemaps://"),
      UIApplication.shared.canOpenURL(googleMapsRedirect) {

      if let fromLat = fromLat,
        let fromLong = fromLong {

        let urlDestination = URL(string: "comgooglemaps-x-callback://?saddr=\(fromLat),\(fromLong)?saddr=&daddr=\(lat),\(long)&directionsmode=\(navigateBy.rawValue)")
        return urlDestination

      } else {

        let urlDestination = URL(string: "comgooglemaps-x-callback://?daddr=\(lat),\(long)&directionsmode=\(navigateBy.rawValue)")
        return urlDestination
      }
    } else {
      if let fromLat = fromLat,
        let fromLong = fromLong {

        let urlDestination = URL(string: "https://www.google.co.in/maps/dir/?saddr=\(fromLat),\(fromLong)&daddr=\(lat),\(long)&directionsmode=\(navigateBy.rawValue)")
        return urlDestination

      } else {

        let urlDestination = URL(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(lat),\(long)&directionsmode=\(navigateBy.rawValue)")
        return urlDestination
      }
    }
  }
}
