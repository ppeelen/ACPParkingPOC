//
//  CarPlaySceneDelegate.swift
//  CarPlay
//
//  Created by Paul Peelen on 2020-07-06.
//

import CarPlay

class CarPlaySceneDelegate: UIResponder, CPTemplateApplicationSceneDelegate {

  var interfaceController: CPInterfaceController?

  // CarPlay connected
  func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didConnect interfaceController: CPInterfaceController) {
    self.interfaceController = interfaceController

    let pm1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 59.340582050058785, longitude: 18.030360611273014))
    let p1 = CPPointOfInterest(location: MKMapItem(placemark: pm1),
                               title: NSAttributedString(string: "Gatuparkering"),
                               subtitle: NSAttributedString(string: "23kr/timme 07:00-17:00"),
                               informativeText: NSAttributedString(string: "Gatuparkering"),
                               pinImageSet: nil)

    let pm2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 59.339444063876414, longitude: 18.03675499756452))
    let p2 = CPPointOfInterest(location: MKMapItem(placemark: pm2),
                               title: NSAttributedString(string: "Gatuparkering"),
                               subtitle: NSAttributedString(string: "18kr/timme 07:00-17:00"),
                               informativeText: NSAttributedString(string: "Sankt Eriksplan 17-15, 113 20 Stockholm"),
                               pinImageSet: nil)

    let information = CPInformationTemplate(title: NSAttributedString(string: "Pågående parkering"), labels: nil, actionButtons: nil)
    let poi = CPPointOfInterestTemplate(title: NSAttributedString(string: "Parkeringar"), pointsOfInterest: [p1, p2], selectedIndex: 0)
    poi.pointOfInterestDelegate = self

    let list = getListTemplate()

    let tabBar = CPTabBarTemplate(templates: [poi, list, information])
    interfaceController.setRootTemplate(tabBar, animated: true)

    poi.tabTitle = "Parkeringar"
    poi.tabImage = UIImage(systemName: "mappin.and.ellipse")

    information.tabTitle = "Pågående"
    information.tabImage = UIImage(systemName: "info.circle")

    list.tabTitle = "abc"
    list.tabImage = UIImage(systemName: "car.circle")

    tabBar.updateTemplates([poi, list, information])
  }

  // CarPlay disconnected
  func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene,
                                didDisconnectInterfaceController interfaceController: CPInterfaceController) {
    self.interfaceController = nil
  }

  func getListTemplate() -> CPListTemplate {
    let item = CPListItem(text: "Item One", detailText: "Something detailed")
    item.listItemHandler = { item, completion in
      debugPrint("\(item.text!) selected!")
      completion()
    }

    let section = CPListSection(items: [item])
    let listTemplate = CPListTemplate(title: "First page", sections: [section])

    return listTemplate
  }
}

extension CarPlaySceneDelegate: CPPointOfInterestTemplateDelegate {

  func pointOfInterestTemplate(_ aTemplate: CPPointOfInterestTemplate, didChangeMapRegion region: MKCoordinateRegion) {
    debugPrint("didChangeRegion")
  }
}
