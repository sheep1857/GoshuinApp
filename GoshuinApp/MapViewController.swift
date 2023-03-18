//
//  MapViewController.swift
//  GoshuinApp
//
//  Created by 木村美希 on 2023/03/16.
//

import UIKit
import CoreLocation
import MapKit


class MapViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    
    // LocationManager宣言
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // LocationManagerのセットアップ
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager!.requestWhenInUseAuthorization()
        
        // 現在地に照準を合わせる 0.01が距離の倍率
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        // mapView.userLocation.coordinateで現在地の情報が取得できる
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: span)
        // 照準合わせる
        mapView.region = region
        
    }
    
    // 許可を求めるためのdelegateメソッド
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            // 許可されてない場合
        case .notDetermined:
            // 許可を求める
            manager.requestWhenInUseAuthorization()
            // 拒否されてる場合
        case .restricted, .denied:
            // 何もしない
            break
            // 許可されている場合
        case .authorizedAlways, .authorizedWhenInUse:
            // 現在地の取得を開始
            manager.startUpdatingLocation()
            break
        default:
            break
        }
    }
    
    //ジオコーディング
    func reverseGeoCording(lat: Double,long: Double, completion: @escaping (String) -> Void ) {
        
        // 住所を取得したい位置情報を宣言
        let location = CLLocation(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long))
        // 位置情報から住所を取得
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first, error == nil else { return }
            // 市区町村より下の階層が出力
            print(placemark.name!)
            // 都道府県
            print(placemark.administrativeArea!)
            // なんとか郡とかがあれば(ない場合もあるのでnull回避)
            print(placemark.subAdministrativeArea ?? "")
            // 市区町村
            print(placemark.locality!)
            
            let address = placemark.administrativeArea! + placemark.locality! + placemark.name!
            
            // クロージャの実行
            completion(address)
        }
    }
}
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


