//
//  Home.swift
//  Boycam
//
//  Created by USER on 18/06/22.
//

import SwiftUI

struct Home: View {
  
    @State var showDetail: Bool = false
    @State var laporan: Bool = false
    var body: some View {
        let boyprefs = UserDefaults.standard
        
        NavigationView
        {
            ZStack{
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
                    
                    Text("Pilih Menu")
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical,8)
                        .background(.black)
                        .multilineTextAlignment(.center)
                        .cornerRadius(10)
                        .padding()
                       
                    VStack(alignment: .leading,spacing: 15) {
                        NavigationLink(destination: Laporkan(), isActive: self.$laporan) { EmptyView() }
                        Button("Laporkan Kejadian") {
                            self.laporan = true
                        }.frame(width:260,height: 40)
                            .font(.system(size: 13))
                            .background(.white)
                            .foregroundColor(.black)
                            .cornerRadius(14)
                        
                        

                        Button("List Berita") {
                            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                        }.frame(width:260,height: 40)
                            .font(.system(size: 13))
                            .background(.white)
                            .foregroundColor(.black)
                            .cornerRadius(14)

                        
                        NavigationLink(destination: ContentView(), isActive: self.$showDetail) { EmptyView() }
                        Button("Logout") {
                            boyprefs.removeObject(forKey: "username")
                            boyprefs.removeObject(forKey: "password")
                           boyprefs.removeObject(forKey: "savelogin")
                            self.showDetail = true
                          
                        }.frame(width:260,height: 40)
                            .font(.system(size: 13))
                            .background(.red)
                            .foregroundColor(.white)
                            .cornerRadius(14)

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

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
