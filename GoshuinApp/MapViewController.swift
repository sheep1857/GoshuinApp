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
    

    
    // MKMapViewDelegateのdidSelectメソッドを実装する
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let coordinate = view.annotation?.coordinate else {
            return
        }
        
        // Google Mapsを開くためのURLを作成する
        let urlString = "comgooglemaps://?center=\(coordinate.latitude),\(coordinate.longitude)"
        guard let url = URL(string: urlString) else {
            return
        }
        
        // Google Mapsを開く
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
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


