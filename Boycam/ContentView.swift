//
//  ContentView.swift
//  Boycam
//
//  Created by USER on 18/06/22.
//

import SwiftUI
import Alamofire
import SwiftyJSON


struct ContentView: View {

    enum AlertType: Identifiable {
           case first, second, third
           
           var id: Int {
               hashValue
           }
       }
    @State private var isloading=false
    @State var showDetail: Bool = false
       @State var alertType: AlertType?
    let boyprefs = UserDefaults.standard
    @State var isijson:String=""
    @State var username: String = ""
    @State var password: String = ""
    
 
    var body: some View {
    
        NavigationView
          {
           
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
                if(isloading){
                    ZStack{
                        Color(.black)
                            .ignoresSafeArea()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .red)).scaleEffect(3)
                    }
                  
                       
                }
                Text("Selamat Datang Di Linmas BJM")
                    .frame(width:260,height: 40)
                        .font(.system(size: 13))
                        .background(.black)
                        .foregroundColor(.white)
                        .cornerRadius(14)
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
                    .padding(.horizontal,30)
                    .padding(.vertical,20)
                    .background(.black)
                    .cornerRadius(20)
                    NavigationLink(destination: Home(), isActive: self.$showDetail) { EmptyView() }
                        
                  
                   
                   
                    
                    Button("Login") {
                        if(username.isEmpty){
                            alertType = .first
                        }else if(password.isEmpty){
                            alertType = .second
                        }else{
                            let parameters: [String: String] = [
                                "username": username,
                                "password": password
                            ]
                            isloading=true
                            // All three of these calls are equivalent
                            AF.request("https://toelve.com/linmasbjm/mobile/loginIos", method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default).responseData{ response in
                                isloading=false
                                switch response.result {
                                  
                                      case .success(let value):
                                          print(String(data: value, encoding: .utf8)!)
                                    let json=JSON(value)
                                    let status=json["status"].string
                                    
                                    isijson=status!
                                    if(status=="sukses"){
                                        self.boyprefs.set(self.username, forKey: "username")
                                        self.boyprefs.set(self.password, forKey: "password")
                                        self.boyprefs.set(true, forKey: "savelogin")
                                        
                                     //   let savedArray = self.boyprefs.string(forKey: "username")
                                     //   alertType = .third
                                       
                                        self.showDetail = true
                                     
                                        
                                    }else{
                                        alertType = .third
                                    }
                                      case .failure(let error):
                                          print(error)
                                          
                                      }
                               
                            
                            }
                          
                        }
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal,30)
                    .padding(.vertical,20)
                    .background(.blue)
                    .cornerRadius(20)
                    
                } .alert(item: $alertType) { type in
                    switch type {
                    case .first:
                        return Alert(title: Text("Warning!"), message: Text("Username Tidak boleh Kosong"), dismissButton: .default(Text("OK")))
                    case .second:
                        return Alert(title: Text("Warning!"), message: Text("Passowrd Tidak boleh Kosong"), dismissButton: .default(Text("OK")))
                    case .third:
                        return Alert(title: Text("WARNING!"), message: Text(isijson), dismissButton: .default(Text("OK")))
                    }
                }
                Spacer()

            }
         
        }
              
          }.navigationViewStyle(.stack)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("")

     }
    
   
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

