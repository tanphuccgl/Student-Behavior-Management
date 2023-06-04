//
//  ContentView.swift
//  Student
//
//  Created by TAN PHUC on 03/06/2023.
//

import SwiftUI

struct ClasListView: View {
    
    @State private var user: String = ""
    @State private var pw: String = ""
    @State private var showWelcomeView = false
    @State private var showWelcomeView2 = false
    @State private var showWelcomeView3 = false
    @State private var showWelcomeView4 = false
    
    @ObservedObject var classViewModel = ClassViewModel()
    @State var classList = [ClassModel]()
    @ObservedObject var studentListViewModel = StudentListViewModel()
    
    @State var pledgesInProgress = [Student]()
    
    @State var studentList = [Student]()
    
    var body: some View {
        
        NavigationView{
            VStack(alignment: .leading) {
                
                logo
                
                
                
                CardEvent(title: "Class A" , classId : "class-A", action: {
                    
                    
                    self.showWelcomeView = true
                    
                    
                    
                },showWelcomeView: $showWelcomeView
                          
                          
                          
                       ,destination: AnyView(StudentListView(classId:"class-A" , data:  $pledgesInProgress)) ,count:
                            "Total: " + String(pledgesInProgress.filter { $0.classId == "class-A" }.count)
                )
                
                
               
                
                
                CardEvent(title: "Class B" , classId : "class-B", action: {
                    
                    
                    self.showWelcomeView2 = true
                    
                    
                    
                },showWelcomeView: $showWelcomeView2
                          
                          
                          
                       ,destination: AnyView(StudentListView(classId:"class-B" , data:  $pledgesInProgress)) ,count:
                            "Total: " + String(pledgesInProgress.filter { $0.classId == "class-B" }.count)
                )
                CardEvent(title: "Class C" , classId : "class-C", action: {
                    
                    
                    self.showWelcomeView3 = true
                    
                    
                    
                },showWelcomeView: $showWelcomeView3
                          
                          
                          
                       ,destination: AnyView(StudentListView(classId:"class-C" , data:  $pledgesInProgress)) ,count:
                            "Total: " + String(pledgesInProgress.filter { $0.classId == "class-C" }.count)
                )
                CardEvent(title: "Class D" , classId : "class-D", action: {
                    
                    
                    self.showWelcomeView4 = true
                    
                    
                    
                },showWelcomeView: $showWelcomeView4
                          
                          
                          
                       ,destination: AnyView(StudentListView(classId:"class-D" , data:  $pledgesInProgress)) ,count:
                            "Total: " + String(pledgesInProgress.filter { $0.classId == "class-D" }.count)
                )
                
                
                
                Spacer()
                HStack(alignment: .center) {
                    Spacer()
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
                    
                }
                Spacer().frame(height: 50)
                
            }
            .padding(sides: [.left,.right], value: 40)}.task {
                self.classList   =  await   classViewModel.get();
                self.pledgesInProgress = await studentListViewModel.getAll();
                
                
                
            }
        
    }
    
    var logo: some View{
        HStack(alignment: .top){
            Spacer()
            Image("Screenshot 2023-06-03 at 22.10.35")
                .resizable()
                .frame(width: 180.0, height: 100.0)
                .imageScale(.small)
            
            Spacer()
        }.padding(EdgeInsets.init(top: 30, leading: 0, bottom: 30, trailing: 0))
    }
    
    
    
}

struct CardEvent: View {
    
    var title:String
    var classId: String
    var action: () -> Void
    var showWelcomeView:Binding<Bool>
    
    var destination:AnyView
    var  count:String
    
    
    var body: some View {
        HStack(alignment: .center){
            Text(title).font(
                .system(size: 18)
                .weight(.bold)
                
                
            )
            Spacer()
                .frame(width: 20)
            
            ZStack(alignment: .leading){
                Rectangle()
                    .frame(width: 250,height: 55)
                    .foregroundColor(Color(hex: "6F7CF4"))
                    .cornerRadius(10)
                
                
                NavigationLink(destination:
                                
                                destination.navigationBarBackButtonHidden(true)
                               , isActive: showWelcomeView, label: {
                    Button(action:action) {
                        HStack(alignment: .center) {
                            Text("Edit")
                            
                                .font(
                                    .system(size: 18)
                                    .weight(.bold)
                                    
                                )
                                .padding(EdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                                .foregroundColor(.red)
                            
                            Image("list")
                                .resizable()
                                .frame(width: 30.0, height: 30.0,alignment: .leading)
                            
                        }
                        
                        .background(Color.green) // If you have this
                        .cornerRadius(25)
                        
                        
                        
                    }
                    .padding(EdgeInsets.init(top: 5, leading: 5, bottom: 5, trailing: 0))
                })
                
                
                
                
                HStack(alignment: .lastTextBaseline)
                {
                    Spacer()
                    Text(
                        count
                        
                    )
                    
                    .font(
                        .system(size: 18)
                        .weight(.bold)
                        
                    )
                    .padding()
                    .foregroundColor(.red)
                }
                
            }
            
            
            
            
        }.padding(EdgeInsets.init(top: 20, leading: 0, bottom: 20, trailing: 0))
    }
}





struct ClasListView_Previews: PreviewProvider {
    static var previews: some View {
        ClasListView()
    }
}
