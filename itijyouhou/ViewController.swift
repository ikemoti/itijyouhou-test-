//
//  ViewController.swift
//  itijyouhou
//
//  Created by USER on 2019/12/19.
//  Copyright © 2019 USER. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    //緯度、経度表示するラベル
    @IBOutlet weak var latitude: UILabel!
    
    @IBOutlet weak var lonitude: UILabel!
    //変数設置
    var latitudeNow : String = ""
    var lonitudeNow : String = ""
    
    var locationManager :CLLocationManager!
    
//    let dataList = ["300m","500m","1000m","2000m","3000m"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
       
    }
    
    
    @IBAction func getLocationInfo(_ sender: Any) {
        let status = CLLocationManager.authorizationStatus()
        if  status == .denied{ showAlert()}
        else if status == .authorizedWhenInUse{
            self.latitude.text = latitudeNow
            self.lonitude.text = lonitudeNow
        }
    }
    
    @IBAction func Clearlabel(_ sender: Any) {
        self.latitude.text = "デフォルト"
        self.lonitude.text =  "デフォルト"
    }
    
    func setupLocationManager(){
        locationManager = CLLocationManager()
    //
        guard let locationManager = locationManager else {return}
        locationManager.requestWhenInUseAuthorization()
    //
        let status = CLLocationManager.authorizationStatus()
    //
        if status == .authorizedWhenInUse{locationManager.delegate = self as? CLLocationManagerDelegate }
    //
        locationManager.startUpdatingLocation()
        

    }


func showAlert(){
    let alertTitle = "位置情報が許可されていません"
    let alertMessage = "設定アプリの「プライバシー＞位置情報サービス」から変更してください"
    
    let alert:UIAlertController = UIAlertController(
        title:  alertTitle,
        message: alertMessage,
        preferredStyle: UIAlertController.Style.alert)
    
    let defaultAction:UIAlertAction = UIAlertAction (
        title:"OK",
        style: UIAlertAction.Style.default,
        handler: nil )
    
    alert.addAction(defaultAction)
    
    present (alert , animated: true , completion: nil)
}
}
extension ViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        let latitude = location?.coordinate.latitude
        let longitude = location?.coordinate.longitude
        
        self .latitudeNow = String(latitude!)
        self .lonitudeNow = String(longitude!)
    }
}

