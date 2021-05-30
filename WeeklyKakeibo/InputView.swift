//
//  InputView.swift
//  WeeklyKakeibo
//
//  Created by nyagoro on 2020/10/18.
//

import SwiftUI

struct InputView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var ratio: CGFloat = 1.2
    @State private var itemName: String = ""
    @State private var selectedDate = Date()
    @State private var selectedWeek: Int = 1
    @State private var price: String = ""
    @State private var showingAlert = false
    // ダークモードかどうかの検知用
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        ZStack {
            Color.white
                .opacity(colorScheme == .dark ? 0.01 : 0.4)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    UIApplication.shared.closeKeyboard()
                }
            VStack {
            VStack(alignment: .center, spacing: 10, content: {
                HStack {
                    Image("calendarIcon")
                        .resizable()
                        .frame(width: 25, height: 25)
//                    Text("月")
                    DatePicker("日付", selection: $selectedDate, displayedComponents: .date)
                }
                HStack {
                    Text("週").padding()
                    Picker(selection: $selectedWeek, label: Text("週"), content: {
                        ForEach(1 ..< 6) { num in
                            Text("\(num)")
                        }.frame(width: 50)
                    }).labelsHidden()
                }
                
                HStack {
                    Image("moneyIcon")
                        .resizable()
                        .frame(width: 25, height: 25)
                    Text("金額")
                    TextField("いくら使いましたか？", text: $price)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Image("pencilIcon")
                        .resizable()
                        .frame(width: 25, height: 25)
                    Text("内容")
                    TextField("何に使いましたか？", text: $itemName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.trailing)
                    
                }

            })
            .frame(alignment: .center)
            .padding(.horizontal, 40)
            .padding(.vertical, 24)
            .font(Font.system(size: 20, design: .default))
            
            Button(action: {
                self.showingAlert = true
                UIApplication.shared.closeKeyboard()
                self.addItem()
                self.clearTextBox()
            }, label: {
                Text("登録")
                    .font(Font.system(size: 20, design: .default))
                    .frame(width: 330, height: 48, alignment: .center)
                    .foregroundColor(Color.white)
                    .background(Color.red)
                    .cornerRadius(10)
            }).alert(isPresented: $showingAlert) {
                Alert(title: Text("登録しました"))
            }
            }
        }
    }
    private func addItem() {
        let newItem = KakeiboItem(context: viewContext)
        newItem.date = selectedDate
        newItem.week = Int16(selectedWeek)
        newItem.itemName = itemName
        newItem.itemPrice = Int16(price) ?? 0
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    private func clearTextBox() {
        //テキストボックスをクリアする
    }
    
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
    }
}

extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
