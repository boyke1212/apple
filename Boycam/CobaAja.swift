//
//  CobaAja.swift
//  Boycam
//
//  Created by USER on 18/06/22.
//

import SwiftUI



    
    struct CobaAja: View {
        @State var username: String = ""
        @State var password: String = ""
        var body: some View {
            ZStack
            {
                        Image("back")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .edgesIgnoringSafeArea(.top)
                VStack{
                    Image("logo")
                        .resizable()
                        .frame(width: 150.0, height: 150.0)
                        .cornerRadius(10)
                               .overlay(RoundedRectangle(cornerRadius: 10)
                                   .stroke(Color.orange, lineWidth: 4))
                               .shadow(radius: 10)
                               .padding()
                    
                    Text("Selamat Datang Di Linmas BJM 2")
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical,8)
                        .background(.black)
                        .multilineTextAlignment(.center)
                        .cornerRadius(10)
                        .padding()
                        .padding()
                    VStack(alignment: .leading) {
                        TextField("Enter username...", text: $username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.all,5)
                        TextField("Enter Password...", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.all,5)
                    }.padding(.all,25)
                   
                    HStack(spacing: 20){
                        Button("Signup") {
                            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal,50)
                        .padding(.vertical,20)
                        .background(.black)
                        .cornerRadius(20)
                        
                        Button("Login") {
                            print(username)
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal,50)
                        .padding(.vertical,20)
                        .background(.blue)
                        .cornerRadius(20)
                        
                    }
                    Spacer()
                }
               
            }
         }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    

