//
//  GraphView.swift
//  WeeklyKakeibo
//
//  Created by nyagoro on 2020/10/18.
//

import SwiftUI

struct GraphView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        Text("貯金額を設定しましょう！")
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView()
    }
}
