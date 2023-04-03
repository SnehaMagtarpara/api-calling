//
//  ViewController.swift
//  api
//
//  Created by R93 on 31/03/23.
//

import UIKit

struct Api : Codable
{
    var error : Bool
    var data : [GetApi]
}

struct GetApi : Codable
{
    var srno : String
    var id : String
    var area_name : String
    var city : String
    var stats : String
    var added_by : String
    var date_time : String
    var operation : String
    var is_verified : String
    
}
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
   
    var arr1: [GetApi] = []
    override func viewDidLoad() {
        super.viewDidLoad()
       getdata()
        tableView.reloadData()
    }
        func getdata()
        {
            let url = URL(string:"https://myct.store/Mobile_Services/user/v2/index.php/get_area")
            var ur = URLRequest(url:url!)
            ur.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: ur) {  data, response, error in
                do {
                    if error == nil
                    {
                        let arr = try JSONDecoder().decode(Api.self, from: data!)
                        print(arr)
                        
                        self.arr1 = arr.data
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                       
                        //4self.tableView.reloadData()
                    }
                }
                catch{
                    print(error)
                }
            }.resume()
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.label1.text = "\(arr1[indexPath.row].id)"
        cell.label2.text = "\(arr1[indexPath.row].city)"
   
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }


}

