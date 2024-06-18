//
//  ImagePathModel+CoreDataProperties.swift
//  mida
//
//  Created by Баэль Рыспеков on 12/6/24.
//
//

import Foundation
import CoreData


extension ImagePathModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImagePathModel> {
        return NSFetchRequest<ImagePathModel>(entityName: "ImagePathModel")
    }

    @NSManaged public var id: String?

}

extension ImagePathModel : Identifiable {

}
