//
//  ContentView.swift
//  Student
//
//  Created by TAN PHUC on 03/06/2023.
//

import SwiftUI

struct LoginView: View {
    
    @State private var user: String = ""
    @State private var pw: String = ""
    @State private var showWelcomeView = false

    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                
                logo
                
                Group{
                    Text("Username").font(
                        .system(size: 18)
                        .weight(.bold)
                       
                    ) .foregroundColor(Color.black)
                    
                    HStack {
                        
                        TextField("", text: $user)  .frame(height: 45)
                            .textFieldStyle(PlainTextFieldStyle())
                        
                        Image("img_230731")
                            .resizable()
                            .frame(width: 32.0, height: 32.0,alignment: .center)
                            .imageScale(.small)
                            .foregroundColor(.accentColor).padding(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 10))
                    }
                    
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                    
                    Spacer()
                        .frame(height: 20)
                    Text("Password").font(
                        .system(size: 18)
                        .weight(.bold)
                       
                        
                    ) .foregroundColor(Color.black)
                    
                    HStack {
                        
                        SecureField("", text: $pw)  .frame(height: 45)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .textFieldStyle(PlainTextFieldStyle())
                        
                        Image("5582931")
                            .resizable()
                            .frame(width: 32.0, height: 32.0,alignment: .center)
                            .imageScale(.small)
                            .foregroundColor(.accentColor).padding(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 10))
                    }
                    
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                }
                Text("Forgot password?").font(
                    .system(size: 15)
                    .weight(.semibold)
                ).foregroundColor(Color(hex:"8236FD")
                                  
                )
                Spacer()
                    .frame(height: 60)
                
                NavigationLink(destination: ClasListView().navigationBarBackButtonHidden(true), isActive: $showWelcomeView, label:{
                    HStack(alignment: .center) {
                        Spacer()
                        Button(action: {
                            if(user.lowercased() == "levi" && pw.lowercased() == "levi")
                            {
                                self.showWelcomeView = true
                            }
                          
                        }) {
                            HStack(alignment: .center) {
                                Text("LOGIN")
                                    .frame(minWidth: 0)
                                    .font(
                                        .system(size: 18)
                                        .weight(.bold)
                                        
                                    )
                                    .padding()
                                    .foregroundColor(.white)
                                
                                Image("152533")
                                    .resizable()
                                    .frame(width: 50.0, height: 50.0,alignment: .leading)
                                
                            }
                            .frame(width: 250)
                            .background(Color(hex:"8236FD")) // If you have this
                            .cornerRadius(25)
                            
                        }
                        Spacer()
                    }
                })
                   
               
                
                bottomRow
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
               
              
                
            }
            .padding(sides: [.left,.right], value: 40)
        }
       
    }
}



var logo: some View{
    HStack(alignment: .top){
        Spacer()
        Image("Screenshot 2023-06-03 at 23.09.09")
            .resizable()
            .frame(width: 180.0, height: 180.0,alignment: .top)
            .imageScale(.small)
            .foregroundColor(.accentColor)
        Spacer()
    }.padding(EdgeInsets.init(top: 0, leading: 0, bottom: 60, trailing: 0))
}

var bottomRow: some View {
    
        HStack {
            Spacer()
            Text("Need an account? SignUp").frame(alignment: .center).font(
                .system(size: 15)
                .weight(.semibold)).foregroundColor(Color(hex:"8236FD"))
            Spacer()
        }
    
   }
    



enum Side: Equatable, Hashable {
    case left
    case right
}

extension View {
    func padding(sides: [Side], value: CGFloat = 8) -> some View {
        HStack(spacing: 0) {
            if sides.contains(.left) {
                Spacer().frame(width: value)
            }
            self
            if sides.contains(.right) {
                Spacer().frame(width: value)
            }
        }
    }
}
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
