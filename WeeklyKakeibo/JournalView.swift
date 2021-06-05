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
    
    @FetchRequest(
        entity: KakeiboItem.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \KakeiboItem.date, ascending: true)],
        animation: .default
    )

    var items: FetchedResults<KakeiboItem>
    var dateFormat: DateFormatter {
        let dformat = DateFormatter()
        dformat.dateFormat = "M"
        return dformat
    }
//    var monthlyCost: Double {
//        var priceTotal: Double = 0
//        let calendar = Calendar.current
//        let comps = calendar.dateComponents([.year, .month], from: Date())
//        let startOfMonth = calendar.date(from: comps)!
//
//        let expression = NSExpressionDescription()
//        expression.expression = NSExpression(forFunction: "sum:", arguments: [NSExpression(forKeyPath: "itemPrice")])
//        expression.name = "priceTotal"
//        expression.expressionResultType = .doubleAttributeType
//
//        let persistenceControler = PersistenceController.shared
//        let context = persistenceControler.container.viewContext
//
//        let request = NSFetchRequest<KakeiboItem>(entityName: "KakeiboItem")
//        request.returnsObjectsAsFaults = false
//        request.propertiesToFetch = [expression]
//        request.resultType = .dictionaryResultType
//
//        let predicate = NSPredicate(format: "date >= %@", startOfMonth as CVarArg)
//        request.predicate = predicate
//
//        do {
//            let results = try context.fetch(request)
//            let data = results.map { (result) -> (Double)}
//            let resultMap = results[0] as! [String:Double]
//            priceTotal = resultMap["priceTotal"]!
//        }
//        catch {
//            NSLog("Error when summing amounts: \(error.localizedDescription)")
//        }
//        return priceTotal
//    }
    
    var body: some View {
        
        List {
            HStack {
                Text("\(dateFormat.string(from: Date()))月")
                    .fontWeight(.heavy)
                Spacer()
                Text("¥0")
                    .multilineTextAlignment(.trailing)
            }
            .font(.title2)
            WeekRow(items: items)
        }
        .padding(8)
    }
}

struct WeekRow: View{
    var items: FetchedResults<KakeiboItem>
//    var weeklyCost: Int {}
    private var startDateOfMonth: Date {
        // 今月のItemだけを取得
        let calendar = Calendar.current
        let comps = calendar.dateComponents([.year, .month], from: Date())
        let startOfMonth = calendar.date(from: comps)!
        return startOfMonth
    }
    var body: some View {
        
        let weeklyCost = 0
        ForEach(1 ..< 6) { num in
            VStack{
                HStack {
                    Text("\(num)週目")
                    Spacer()
                    Text("¥\(weeklyCost)")
                }
                .font(.title3)
                
                ForEach(getAllDataByMonth(fromDate: startDateOfMonth, week: num)) { kakeiboItem in
                    
                    itemRow(item: kakeiboItem)
                }
            }
        }
    }
    
    func getAllDataByMonth(fromDate: Date, week: Int) -> [KakeiboItem] {
        let persistenceControler = PersistenceController.shared
        let context = persistenceControler.container.viewContext
        
        let request = NSFetchRequest<KakeiboItem>(entityName: "KakeiboItem")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        let predicate = NSPredicate(format: "date >= %@ AND week == %d", fromDate as CVarArg, week)
        request.predicate = predicate
        
        do {
            let items = try context.fetch(request)
            return items
        }
        catch {
            fatalError()
        }
    }
    
    //weekごとの合計Priceを取得
//    func getWeeklyCost() -> [KakeiboItem]{
//        let persistenceControler = PersistenceController.shared
//        let context = persistenceControler.container.viewContext
//
//        let request = NSFetchRequest<KakeiboItem>(entityName: "KakeiboItem")
//        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
//
//        let predicate = NSPredicate(format: "date >= %@ AND week == %d", fromDate as CVarArg, week)
//        request.predicate = predicate
//
//        do {
//            let items = try context.fetch(request)
//            return items
//        }
//        catch {
//            fatalError()
//        }
//    }
    
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
