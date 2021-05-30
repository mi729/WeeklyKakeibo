//
//  UserData.swift
//  WeeklyKakeibo
//
//  Created by nyagoro on 2020/11/08.
//

import Combine
import SwiftUI

final class UserData: ObservableObject {
    @Published var date = Date()
    @Published var week = Int16()
    @Published var name = ""
    @Published var price = ""
}

