//
//  ContentView.swift
//  Student
//
//  Created by TAN PHUC on 03/06/2023.
//

import SwiftUI

struct NewBehavior: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var cardListViewModel = StudentListRepository()
    
    
    
    
    @State private var date: String = ""
    @State private var behavior: String = ""
    @State private var score: String = ""
    @State private var showWelcomeView = false
    let studentId: String
    @State var data: Student? = nil
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                
                logo
                
                Group{
                    Text("Date:").font(
                        .system(size: 18)
                        .weight(.bold)
                        
                    )
                    
                    HStack {
                        
                        TextField("", text: $date)  .frame(height: 45)
                            .textFieldStyle(PlainTextFieldStyle())
                        
                        
                    }
                    
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                    
                    Spacer()
                        .frame(height: 20)
                    
                    
                    Text("Behavior:").font(
                        .system(size: 18)
                        .weight(.bold)
                        
                    )
                    
                    HStack {
                        
                        
                        
                        TextField("", text: $behavior) .keyboardType(.numberPad)  .frame(height: 45)
                            .textFieldStyle(PlainTextFieldStyle())
                        
                        
                    }
                    
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                    Spacer()
                        .frame(height: 20)
                    Text("Score rating:").font(
                        .system(size: 18)
                        .weight(.bold)
                        
                    )
                    
                    HStack {
                        
                        TextField("", text: $score)  .frame(height: 120)
                            .textFieldStyle(PlainTextFieldStyle())
                        
                        
                    }
                    
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                }
                
                Spacer().frame(height:  50)
                HStack(alignment: .center) {
                    Spacer()
                    NavigationLink(destination: StudentInfoView(studentId:data?.id ?? "" ).navigationBarBackButtonHidden(true)
                                   , isActive: $showWelcomeView, label: {
                        Button(action: addCard) {
                            HStack(alignment: .center) {
                                Text("ADD")
                                    .frame(minWidth:100)
                                    .font(
                                        .system(size: 18)
                                        .weight(.bold)
                                        
                                    )
                                    .padding()
                                    .foregroundColor(.black)
                                
                                
                                
                            }
                            
                                .background(Color(hex: "#9BFF99"))
                            .cornerRadius(25)
                            
                        }
                        
                    })
                    
                    
                    Spacer()
                }
                
                
                Spacer()
                HStack(alignment: .center) {
                    Spacer()
                    Button(action: {
                       
                        self.presentationMode.wrappedValue.dismiss()
                        
                     
                      
                        
                    }) {
                        HStack(alignment: .center) {
                            
                            Image("angle-double-left")
                                .resizable()
                                .frame(width: 50.0, height: 50.0,alignment: .leading)
                            Text("Back")
                                .frame(minWidth: 0)
                                .font(
                                    .system(size: 18)
                                    .weight(.bold)
                                    
                                )
                                .padding()
                                .foregroundColor(.black)
                            
                            
                        }
                        
                        .background(Color(hex: "91D0DF"))
                        .cornerRadius(25)
                        
                    }
                    Spacer().frame(width:  50)
                    
                    Button(action: {
                        exit(0)
                    }) {
                        HStack(alignment: .center) {
                            Text("Exit")
                                .frame(minWidth: 0)
                                .font(
                                    .system(size: 18)
                                    .weight(.bold)
                                    
                                )
                                .padding()
                                .foregroundColor(.red)
                            
                            Image("switch")
                                .resizable()
                                .frame(width: 50.0, height: 50.0,alignment: .leading)
                            
                        }
                        
                        .background(Color.red.opacity(0.1)) // If you have this
                        .cornerRadius(25)
                        
                    }
                    Spacer()
                    
                }
                Spacer().frame(height: 50)
                
            }
            .padding(sides: [.left,.right], value: 20)
        } .navigationViewStyle(.stack).task {
            self.data   =  await   cardListViewModel.getInfo(studentId:studentId);
            print( self.data?.behaviorList ?? "")
        
        }
        
    }
    var logo: some View{
        HStack(alignment: .top){
            Spacer()
            Image("Screenshot 2023-06-04 at 19.51.46")
                .resizable()
                .frame(width: 180.0, height: 30,alignment: .top)
                .imageScale(.small)
                .foregroundColor(.accentColor)
            Spacer()
        }.padding(EdgeInsets.init(top: 0, leading: 0, bottom: 60, trailing: 0))
    }
    
    private func addCard() {
        
        let behavior = Behavior(id: UUID().uuidString, date: date, behavior: behavior, score: score)
        // 1
        
        var list: [Behavior] = self.data?.behaviorList ?? []
        print("lev " + String(list.count))
        var result: [Behavior] =  []
        list.append(behavior!)
        
        result = list
        
        print(result.count)
        var card:Student = self.data!.copy(with: result)
       
           cardListViewModel.update(card)

        var data1: Student? = nil
       Task{
           data1 = await   cardListViewModel.getInfo(studentId:studentId)!;

          await DispatchQueue.main.async {
                               self.data = data1
                           }


       }
        // 3
        presentationMode.wrappedValue.dismiss()
        
    }
    
}







