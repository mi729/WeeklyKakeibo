//
//  ContentView.swift
//  WeeklyKakeibo
//
//  Created by nyagoro on 2020/10/17.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        TabView {
            InputView()
                .environment(\.managedObjectContext, self.viewContext)
                .tabItem {
                    VStack {
                        Image(systemName: "pencil.tip.crop.circle.badge.plus")
                        Text("入力")

                    }
                }.tag(1)
            JournalView()
                .environment(\.managedObjectContext, self.viewContext)
                .tabItem {
                    Text("記録")
                }.tag(2)
            
            GraphView()
                .environment(\.managedObjectContext, self.viewContext)
                .tabItem {
                    Text("グラフ")
                }.tag(3)
            SettingView()
                .environment(\.managedObjectContext, self.viewContext)
                .tabItem {
                    Text("設定")
                }.tag(4)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11")
    }
}
