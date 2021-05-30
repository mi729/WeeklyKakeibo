//
//  KakeiboItem+CoreDataProperties.swift
//  WeeklyKakeibo
//
//  Created by nyagoro on 2020/11/30.
//
//

import Foundation
import CoreData


extension KakeiboItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<KakeiboItem> {
        return NSFetchRequest<KakeiboItem>(entityName: "KakeiboItem")
    }

    @NSManaged public var date: Date
    @NSManaged public var week: Int16
    @NSManaged public var itemName: String?
    @NSManaged public var itemPrice: Int16

}

extension KakeiboItem : Identifiable {

}
