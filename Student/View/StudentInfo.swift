//
//  ContentView.swift
//  Student
//
//  Created by TAN PHUC on 03/06/2023.
//

import SwiftUI

struct StudentInfoView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    @State private var name: String = ""
    @State private var phone: String = ""
    @State private var address: String = ""
    @State private var showWelcomeView = false
    
    @ObservedObject var cardListViewModel = StudentListViewModel()
    let studentId: String
    @State var pledgesInProgress = [Student]()
    @State var data: Student? = nil
    
    @State var listBehavior: [Behavior] = []
    
    var body: some View {
        
        NavigationView{
            NavigationLink(destination: NewBehavior(studentId:studentId).navigationBarBackButtonHidden(true), isActive: $showWelcomeView, label: {
                VStack(alignment: .leading) {
                    
                    logo
                    
                    HStack{
                        Text("Student name:").font(
                            .system(size: 18)
                            .weight(.bold)
                            
                        ) .foregroundColor(Color.black).frame(width: 150,alignment: .leading)
                        Spacer().frame(width: 40)
                        Text(data?.name ?? "").font(
                            .system(size: 18)
                            .weight(.bold)
                            
                        ) .foregroundColor(Color.black)
                    }
                    HStack{
                        Text("Phone:").font(
                            .system(size: 18)
                            .weight(.bold)
                            
                        )
                        
                        .foregroundColor(Color.black).frame(width: 150,alignment: .leading)
                        Spacer().frame(width: 40)
                        Text(data?.phone ?? "").font(
                            .system(size: 18)
                            .weight(.bold)
                            
                        ) .foregroundColor(Color.black)
                    }
                    HStack{
                        Text("Address:").font(
                            .system(size: 18)
                            .weight(.bold)
                            
                        ) .foregroundColor(Color.black).frame(width: 150,alignment: .leading)
                        Spacer().frame(width: 40)
                        Text(data?.address ?? "").font(
                            .system(size: 18)
                            .weight(.bold)
                            
                        ) .foregroundColor(Color.black)
                    }
                    
                    Button(action:{
                        self.showWelcomeView = true
                    }) {
                        HStack(alignment: .center) {
                           
                            Text("Add new behavior")
                            
                                .font(
                                    .system(size: 18)
                                    .weight(.bold)
                                    
                                )
                                .padding()
                                .foregroundColor(.white)
                            
                            
                            
                        }
                        
                        .background(Color(hex: "#5A76D9")) // If you have this
                        .cornerRadius(25)
                        
                        
                        
                    }
                    
                    
                    GeometryReader { geometry in
                        VStack {
                            ScrollViewReader { scrollView in
                                ScrollView(.vertical) {
                                    VStack(alignment: .center,spacing: 0) {
                                        TableHeaderView()
                                        ForEach(self.listBehavior , id: \.id) { item in
                                            TableDataView(date:
                                                            item.date
                                                          ,behavior: item.behavior,score: item.score
                                                   
                                            )
                                        }
                                    }
                                }
                                
                            } .frame(height: 350)
                        }
                        .frame(height: 350)
                    } .frame(height: 350)
                    
                    
                   
                    
                    
                    
                    
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
                        
                    }.padding(sides: [.left,.right], value: 20)
                    Spacer().frame(height: 50)
                    
                }
                .padding(sides: [.left,.right], value: 5).task {
                    self.data   =  await   cardListViewModel.getInfo(studentId:studentId);
                    
                    self.listBehavior = data?.behaviorList ?? []
                    print(listBehavior.last?.behavior)
                    self.pledgesInProgress  =  await cardListViewModel.get(classId: data!.classId)
                }
            })}
        
     
    }
    
    var logo: some View{
        HStack(alignment: .top){
            Image("login")
                .resizable()
                .frame(width: 180.0, height: 180.0)
                .imageScale(.small)
            
            Spacer()
        }.padding(EdgeInsets.init(top: 30, leading: 0, bottom: 10, trailing: 0))
    }
    
    struct TableHeaderView: View {
        
        
        
        var body: some View {
            HStack(alignment: .bottom,spacing:0){
                
                ZStack(){
                    Rectangle()
                        .frame(width: 150,height: 55)
                        .foregroundColor(Color(hex: "#50A99A"))
                        .border(width: 1, edges: [.trailing,.bottom], color: Color.gray)
                    
                    Text("Date")
                        .frame(minWidth: 0)
                        .font(
                            .system(size: 15)
                            .weight(.bold)
                            
                        )
                    
                        .foregroundColor(.black)
                    
                }
                ZStack(){
                    Rectangle()
                        .frame(width: 150,height: 55)
                        .foregroundColor(Color(hex: "#50A99A"))
                        .border(width: 1, edges: [.trailing,.bottom], color: Color.gray)
                    
                    Text("Behavior")
                        .frame(minWidth: 0)
                        .font(
                            .system(size: 15)
                            .weight(.bold)
                            
                        )
                        .padding()
                        .foregroundColor(.black)
                    
                }
                
                ZStack(){
                    Rectangle()
                        .frame(width: 70,height: 55)
                        .foregroundColor(Color(hex: "#50A99A"))
                        .border(width: 1, edges: [.bottom], color: Color.gray)
                    
                    Text("Score rating")
                        .frame(minWidth: 0)
                        .font(
                            .system(size: 15)
                            .weight(.bold)
                            
                        )
                    
                        .foregroundColor(.black)
                    
                }
               
                
            }
            
        }
    }

    struct TableDataView: View {
        
        var date:String
        var behavior: String
        var score: String
        
        var body: some View {
            HStack(alignment: .bottom,spacing:0){
                
                ZStack(){
                    Rectangle()
                        .frame(width: 150,height: 55)
                        .foregroundColor(Color(hex: "#D0FFF7"))
                        .border(width: 1, edges: [.trailing,.bottom], color: Color.gray)
                    
                    Text(date)
                        .frame(minWidth: 0)
                        .font(
                            .system(size: 13)
                            .weight(.medium)
                            
                        )
                    
                        .foregroundColor(.black)
                    
                }
                ZStack(){
                    Rectangle()
                        .frame(width: 150,height: 55)
                        .foregroundColor(Color(hex: "#D0FFF7"))
                        .border(width: 1, edges: [.trailing,.bottom], color: Color.gray)
                    
                    Text(behavior)
                        .frame(minWidth: 0)
                        .font(
                            .system(size: 13)
                            .weight(.medium)
                            
                        )
                    
                        .foregroundColor(.black)
                    
                }
                
                ZStack(){
                    Rectangle()
                        .frame(width: 70,height: 55)
                        .foregroundColor(Color(hex: "#D0FFF7"))
                        .border(width: 1, edges: [.bottom], color: Color.gray)
                    
                    Text(score).textCase(.uppercase)
                        .frame(minWidth: 0)
                        .font(
                            .system(size: 13)
                            .weight(.medium)
                            
                        )
                    
                        .foregroundColor(.black)
                    
                }
                
                
            }
            
        }
    }
    
}




struct StudentInfoView_Previews: PreviewProvider {
    static var previews: some View {
        StudentInfoView(studentId:"",data: Student(id: "", name: "", point: "", phone: "", address: "", classId: "",behaviorList: []))
    }
}
