//
//  ContentView.swift
//  Student
//
//  Created by TAN PHUC on 03/06/2023.
//

import SwiftUI

struct StudentListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
     let classId: String
    @ObservedObject var cardListViewModel = StudentListViewModel()
    @State var pledgesInProgress = [Student]()
    
    @Binding var data: [Student]
    
    @State private var showWelcomeView = false
    
    @State private var selectedItem: String? = nil

   
   
    
    
    var body: some View {
       
        
        NavigationView{
            VStack(alignment: .leading) {
                
                logo
                NavigationLink(destination: NewStudent(data:$pledgesInProgress,classId:classId ).navigationBarBackButtonHidden(true), isActive: $showWelcomeView, label: {
                    Button(action:{
                        self.showWelcomeView = true
                    }) {
                        HStack(alignment: .center) {
                            Image("add-user")
                                .resizable()
                                .frame(width: 30.0, height: 30.0,alignment: .leading)
                            Text("Add new student")
                            
                                .font(
                                    .system(size: 18)
                                    .weight(.bold)
                                    
                                )
                                .padding()
                                .foregroundColor(.black)
                            
                            
                            
                        }
                        
                        .background(Color(hex: "#9CFFD0")) // If you have this
                        .cornerRadius(25)
                        
                        
                        
                    }
                    
                })
                
                
                
                
                GeometryReader { geometry in
                    VStack {
                        ScrollViewReader { scrollView in
                            ScrollView(.vertical) {
                                VStack(alignment: .center,spacing: 0) {
                                    TableHeaderView()
                                    ForEach(pledgesInProgress, id: \.id) { item in
                                        TableDataView(name:
                                                        item.name
                                                      ,point: item.behaviorList.isEmpty ?   "" :
                                                        item.behaviorList.first?.score ?? ""
                                                        ,id:item.id,
                                                      cardListViewModel:cardListViewModel,
                                                      onTapGesture: {
                                            cardListViewModel.delete(item.id)
                                            Task {
                                                self.pledgesInProgress   =  await   cardListViewModel.get(classId:classId);
                                            }
                                            
                                        },action: {self.selectedItem = item.id},showWelcomeView: bindingForItem(item:item.id) ,destination: AnyView(StudentInfoView(studentId:item.id))
                                               
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
                        var data1: [Student] = []
                       Task{
                           data1 = await   cardListViewModel.getAll();
                          
                          await DispatchQueue.main.async {
                                               self.data = data1
                                           }
                           print( classId)
                           print( data1.count)
                            
                       }
                        presentationMode.wrappedValue.dismiss()
                        
                        
                    
                      
                        
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
            .padding(sides: [.left,.right], value: 5)}.task {
                self.pledgesInProgress   =  await   cardListViewModel.get(classId:self.classId);
                
            }
        
        
    }
    
    func bindingForItem(item: String) -> Binding<Bool> {
            .init {
                selectedItem == item
            } set: { newValue in
                selectedItem = newValue ? item : nil
            }
        }
    
    
    var logo: some View{
        HStack(alignment: .top){
            Spacer()
            Image("Screenshot 2023-06-04 at 00.41.37")
                .resizable()
                .frame(width: 180.0, height: 100.0)
                .imageScale(.small)
            
            Spacer()
        }.padding(EdgeInsets.init(top: 30, leading: 0, bottom: 30, trailing: 0))
    }
    
    struct TableHeaderView: View {
        
        
        
        var body: some View {
            HStack(alignment: .bottom,spacing:0){
                
                ZStack(){
                    Rectangle()
                        .frame(width: 150,height: 55)
                        .foregroundColor(Color(hex: "#50A99A"))
                        .border(width: 1, edges: [.trailing,.bottom], color: Color.gray)
                    
                    Text("Name")
                        .frame(minWidth: 0)
                        .font(
                            .system(size: 15)
                            .weight(.bold)
                            
                        )
                    
                        .foregroundColor(.black)
                    
                }
                
                ZStack(){
                    Rectangle()
                        .frame(width: 70,height: 55)
                        .foregroundColor(Color(hex: "#50A99A"))
                        .border(width: 1, edges: [.trailing,.bottom], color: Color.gray)
                    
                    Text("Point")
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
                        .border(width: 1, edges: [.bottom], color: Color.gray)
                    
                    Text("Action")
                        .frame(minWidth: 0)
                        .font(
                            .system(size: 15)
                            .weight(.bold)
                            
                        )
                        .padding()
                        .foregroundColor(.black)
                    
                }
                
            }
            
        }
    }
    
    struct TableDataView: View {
        
        var name:String
        var point: String
        var id: String
        var cardListViewModel: StudentListViewModel
        var onTapGesture : () -> Void
        
        var action: () -> Void
        var showWelcomeView:Binding<Bool>
        var destination:AnyView
        
        var body: some View {
            VStack(spacing:0){
                HStack(alignment: .bottom,spacing:0){
                    
                    ZStack(){
                        Rectangle()
                            .frame(width: 150,height: 55)
                            .foregroundColor(Color(hex: "#D0FFF7"))
                            .border(width: 1, edges: [.trailing,.bottom], color: Color.gray)
                        
                        Text(name)
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
                            .border(width: 1, edges: [.trailing,.bottom], color: Color.gray)
                        
                        Text(point).textCase(.uppercase)
                            .frame(minWidth: 0)
                            .font(
                                .system(size: 13)
                                .weight(.bold)
                                
                            )
                        
                            .foregroundColor(.black)
                        
                    }
                    ZStack(alignment: .leading){
                        Rectangle()
                            .frame(width: 150,height: 55)
                            .foregroundColor(Color(hex: "#D0FFF7"))
                            .border(width: 1, edges: [.bottom], color: Color.green)
                        
                        
                        NavigationLink(destination: destination.navigationBarBackButtonHidden(true), isActive: showWelcomeView, label: {
                            
                            HStack{
                                Spacer().frame(width: 5)
                                Button(action:action) {
                                    HStack(alignment: .center) {
                                        Image("search")
                                            .resizable()
                                            .frame(width: 30.0, height: 30.0,alignment: .leading)
                                        Text("View")
                                        
                                            .font(
                                                .system(size: 13)
                                                .weight(.bold)
                                                
                                            )
                                            .padding(EdgeInsets(top: 15, leading: 5, bottom: 15, trailing: 5))
                                            .foregroundColor(.black)
                                        
                                        
                                        
                                    }
                                    
                                    
                                    .background(Color(hex: "91D0DF")) // If you have this
                                    .cornerRadius(25)
                                    
                                    
                                    
                                }
                            }
                        })
                      
                        
                        HStack{
                            Spacer().frame(width: 110)
                            Image("remove")
                                .resizable()
                                .frame(width: 30.0, height: 30.0,alignment: .leading).onTapGesture{
                                    onTapGesture()
                                }
                                  
                                   
                                  
                                
                        }
                        
                        
                    }
                    
                }
            }
            
            
            
        }
    }
    
}


struct User: Identifiable {
    let id: Int
    var name: String
    var point: String
}





extension View {
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}
struct EdgeBorder: Shape {
    var width: CGFloat
    var edges: [Edge]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var x: CGFloat {
                switch edge {
                case .top, .bottom, .leading: return rect.minX
                case .trailing: return rect.maxX - width
                }
            }
            
            var y: CGFloat {
                switch edge {
                case .top, .leading, .trailing: return rect.minY
                case .bottom: return rect.maxY - width
                }
            }
            
            var w: CGFloat {
                switch edge {
                case .top, .bottom: return rect.width
                case .leading, .trailing: return width
                }
            }
            
            var h: CGFloat {
                switch edge {
                case .top, .bottom: return width
                case .leading, .trailing: return rect.height
                }
            }
            path.addRect(CGRect(x: x, y: y, width: w, height: h))
        }
        return path
    }
}


struct StudentListView_Previews: PreviewProvider {
    static let country: [Student] = [
    
    ]
    static var previews: some View {
        StudentListView(classId:"",data: .constant(country))
    }
}
