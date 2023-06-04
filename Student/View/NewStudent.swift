//
//  ContentView.swift
//  Student
//
//  Created by TAN PHUC on 03/06/2023.
//

import SwiftUI

struct NewStudent: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var cardListViewModel = StudentListViewModel()
    @Binding var data: [Student]
    var classId: String
    
    
    
    @State private var name: String = ""
    @State private var phone: String = ""
    @State private var address: String = ""
    @State private var showWelcomeView = false
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                
                logo
                
                Group{
                    Text("Name:").font(
                        .system(size: 18)
                        .weight(.bold)
                        
                    )
                    
                    HStack {
                        
                        TextField("", text: $name)  .frame(height: 45)
                            .textFieldStyle(PlainTextFieldStyle())
                        
                        
                    }
                    
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                    
                    Spacer()
                        .frame(height: 20)
                    
                    
                    Text("Phone:").font(
                        .system(size: 18)
                        .weight(.bold)
                        
                    )
                    
                    HStack {
                        
                        
                        
                        TextField("", text: $phone) .keyboardType(.numberPad)  .frame(height: 45)
                            .textFieldStyle(PlainTextFieldStyle())
                        
                        
                    }
                    
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                    Spacer()
                        .frame(height: 20)
                    Text("Address:").font(
                        .system(size: 18)
                        .weight(.bold)
                        
                    )
                    
                    HStack {
                        
                        TextField("", text: $address)  .frame(height: 120)
                            .textFieldStyle(PlainTextFieldStyle())
                        
                        
                    }
                    
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                }
                
                Spacer().frame(height:  50)
                HStack(alignment: .center) {
                    Spacer()
                    NavigationLink(destination: StudentListView(classId:classId,data:.constant([])).navigationBarBackButtonHidden(true)
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
        } .navigationViewStyle(.stack)
        
    }
    var logo: some View{
        HStack(alignment: .top){
            Spacer()
            Image("Screenshot 2023-06-04 at 00.41.30")
                .resizable()
                .frame(width: 180.0, height: 30,alignment: .top)
                .imageScale(.small)
                .foregroundColor(.accentColor)
            Spacer()
        }.padding(EdgeInsets.init(top: 0, leading: 0, bottom: 60, trailing: 0))
    }
    
    private func addCard() {
        // 1
        let card = Student(id: UUID().uuidString, name: name, point: "", phone: phone, address: address,classId:classId,behaviorList: [])
        // 2
        cardListViewModel.add(card!)
        
        var data1: [Student] = []
       Task{
           data1 = await   cardListViewModel.get(classId:classId);
          
          await DispatchQueue.main.async {
                               self.data = data1
                           }
           
          
       }
        // 3
        presentationMode.wrappedValue.dismiss()
        
    }
    
}







struct NewStudent_Previews: PreviewProvider {
    static let country: [Student] = [
    
    ]
    static var previews: some View {
        NewStudent(data: .constant(country),classId:"")
    }
}
