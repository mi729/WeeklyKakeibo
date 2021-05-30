//
//  JournalView.swift
//  WeeklyKakeibo
//
//  Created by nyagoro on 2020/10/18.
//

import SwiftUI
import CoreData

struct JournalView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
//    @FetchRequest(
//        entity: KakeiboItem.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \KakeiboItem.date, ascending: true)],
//        animation: .default
//    )
//
//    var items: FetchedResults<KakeiboItem>
    var body: some View {
        
        List {
            HStack {
                var month = "12月"
                Text(month)
                    .fontWeight(.heavy)
                Spacer()
                Text("¥12650")
                    .multilineTextAlignment(.trailing)
            }
            .font(.title2)
//            ForEach(items.week.count){ num in
//            WeekRow(items: items)
            WeekRow()
        }
        .padding(8)
    }
}

struct WeekRow: View{
//    var items: FetchedResults<KakeiboItem>
    private var startDateOfMonth: Date {
        // 今月のItemだけを取得
        let calendar = Calendar.current
        let comps = calendar.dateComponents([.year, .month], from: Date())
        let startOfMonth = calendar.date(from: comps)!
        return startOfMonth
    }
    var body: some View {
        
        let monthlyCost = 0
        
        ForEach(1 ..< 6) { num in
            HStack {
                Text("\(num)週目")
                Spacer()
                Text("¥\(monthlyCost)")
            }
            .font(.title3)
        }

        
        ForEach(getAllDataByMonth(fromDate: startDateOfMonth)) { kakeiboItem in
            itemRow(item: kakeiboItem)
        }
    }
    
    func getAllDataByMonth(fromDate: Date) -> [KakeiboItem] {
        let persistenceControler = PersistenceController.shared
        let context = persistenceControler.container.viewContext
        
        let request = NSFetchRequest<KakeiboItem>(entityName: "KakeiboItem")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        //crashする
//        let predicate = NSPredicate(format: "date >= %@", fromDate as CVarArg)
//        request.predicate = predicate
        
        do {
            let items = try context.fetch(request)
            return items
        }
        catch {
            fatalError()
        }
    }
}
struct itemRow: View {
    var item: KakeiboItem
    var body: some View {
        HStack {
            Text(item.itemName ?? "no name")
            Spacer()
            Text("￥\(String(item.itemPrice))")
       }
        .font(.subheadline)
    }
}

struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView()
//            .environment(\.managedObjectContext, self.viewContext)
    }
}
