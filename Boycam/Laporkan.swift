//
//  Laporkan.swift
//  Boycam
//
//  Created by USER on 18/06/22.
//

import SwiftUI
import MapKit
class LocationModel: NSObject, ObservableObject,CLLocationManagerDelegate{
    @Published var alamatambil:String=""
    @Published var latitude:Double=4.0
    @Published var longitude:Double=5.0
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?
    var locationmanager:CLLocationManager?
    
    func Checklocation(){
        if(CLLocationManager.locationServicesEnabled()){
          
            locationmanager=CLLocationManager()
            locationmanager!.desiredAccuracy=kCLLocationAccuracyBest
            locationmanager!.delegate=self
            locationmanager!.requestWhenInUseAuthorization()
            locationmanager!.startUpdatingLocation()
            locationpermision()
            print(alamatambil)
        }else{
            print("aktifkan Location")
        }
    }
    
    func locationpermision(){
        guard let locationmanager = locationmanager else {
            return
        }
        switch locationmanager.authorizationStatus{
            
        case .notDetermined:
            locationmanager.requestWhenInUseAuthorization()
        case .restricted:
            print("your location is restricted")
        case .denied:
            print("you have denied the location")
        case .authorizedAlways, .authorizedWhenInUse:
            latitude=locationmanager.location?.coordinate.latitude ?? 1.0
            longitude=locationmanager.location?.coordinate.longitude ?? 3.0
            print("lat\(latitude)")
            let geocoder=CLGeocoder()
            geocoder.reverseGeocodeLocation(locationmanager.location!) { [self] (placemarks,error) in
                let place = placemarks! as [CLPlacemark]
                                if place.count > 0 {
                                    let place = placemarks![0]
                                    var adressString : String = ""
                                    if place.thoroughfare != nil {
                                        adressString = adressString + place.thoroughfare! + " - "
                                        alamatambil = alamatambil +  place.thoroughfare! + " - "
                                    }
                                    if place.subThoroughfare != nil {
                                        adressString = adressString + place.subThoroughfare! + ", "
                                        alamatambil = alamatambil  + place.subThoroughfare! + ", "
                                    }
                                    if place.locality != nil {
                                        adressString = adressString + place.locality! + " - "
                                        alamatambil = alamatambil + place.locality! + " - "
                                    }
                                    if place.postalCode != nil {
                                        adressString = adressString + place.postalCode! + ", "
                                        alamatambil = alamatambil + place.postalCode! + ", "
                                    }
                                    if place.subAdministrativeArea != nil {
                                        adressString = adressString + place.subAdministrativeArea! + " - "
                                        alamatambil = alamatambil +  place.subAdministrativeArea! + " - "
                                    }
                                    if place.country != nil {
                                        adressString = adressString + place.country!
                                      
                                    }
                                    alamatambil = adressString
                                }
            }
                                
        @unknown default:
            break
        }
    }
    private func locationManager(_manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            locationStatus = status
           
        }
    private func locactionManagerDidChangeAuthorization(_manager:CLLocationManager){
            locationpermision()
        }
        
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        latitude = locations.first?.coordinate.latitude ?? 1.1
        longitude = locations.first?.coordinate.longitude ?? 2.0
        print("long\(longitude)")
        if let location = locations.last {
        


            let geocoder=CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { [self] (placemarks,error) in
                let place = placemarks! as [CLPlacemark]
                if place.count > 0 {
                    let place = placemarks![0]
                    var adressString : String = ""
                    if place.thoroughfare != nil {
                        adressString = adressString + place.thoroughfare! + " - "
                        alamatambil = alamatambil +  place.thoroughfare! + " - "
                    }
                    if place.subThoroughfare != nil {
                        adressString = adressString + place.subThoroughfare! + ", "
                        alamatambil = alamatambil  + place.subThoroughfare! + ", "
                    }
                    if place.locality != nil {
                        adressString = adressString + place.locality! + " - "
                        alamatambil = alamatambil + place.locality! + " - "
                    }
                    if place.postalCode != nil {
                        adressString = adressString + place.postalCode! + ", "
                        alamatambil = alamatambil + place.postalCode! + ", "
                    }
                    if place.subAdministrativeArea != nil {
                        adressString = adressString + place.subAdministrativeArea! + " - "
                        alamatambil = alamatambil +  place.subAdministrativeArea! + " - "
                    }
                    if place.country != nil {
                        adressString = adressString + place.country!
                       
                    }
                    alamatambil=adressString
                }
            }
            
        }
    }
    
}
struct Laporkan: View {
    @StateObject private var viewmodel=LocationModel()
    @State var showDetail: Bool = false
    @State var laporan: String = ""
  
    var body: some View {
        // let boyprefs = UserDefaults.standard
        NavigationView
        {
            
            ZStack{
                Image("back")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.top)
                
                VStack{
                  
                    Image("ambil")
                        .resizable()
                        .frame(width: 240.0, height: 220.0)
                        .cornerRadius(10)
                               .overlay(RoundedRectangle(cornerRadius: 10)
                                   .stroke(Color.orange, lineWidth: 4))
                               .shadow(radius: 10)
                 
                        VStack {
                                    Text(viewmodel.alamatambil)
                                        .lineLimit(nil)
                                        .frame(width:290,height: 60)
                                            .font(.system(size: 13))
                                            .background(.white)
                                            .disabled(true)
                                            .foregroundColor(.black)
                                            .cornerRadius(8)
                                        
                                            .multilineTextAlignment(.leading)
                                            .padding(.all,5)
                                }.frame(maxWidth: .infinity)
//                    TextEditor(text:  $viewmodel.alamatambil)
//                        .frame(width:290,height: 60)
//                            .font(.system(size: 13))
//                            .background(.white)
//                            .disabled(true)
//                            .foregroundColor(.black)
//                            .cornerRadius(8)
//
//                            .multilineTextAlignment(.leading)
//                            .padding(.all,5)
                    
                    TextEditor( text:  $laporan)
                        .frame(width:290,height: 100)
                            .font(.system(size: 13))
                            .background(.white)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                            .multilineTextAlignment(.leading)
                            .padding(.all,5)
                              
                        Button("Submit") {
                           // var //kok:String=String(viewmodel.latitude)
                          //  print(kok)
                        }.frame(width:300,height: 40)
                            .font(.system(size: 13))
                            .background(.blue)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .cornerRadius(9)
                       Spacer()
                    }
                               
            
            }.onAppear(){
                viewmodel.Checklocation()
                print($viewmodel.longitude)
              
                }
            }
        }
    }


struct Laporkan_Previews: PreviewProvider {
    static var previews: some View {
        Laporkan()
    }
}
