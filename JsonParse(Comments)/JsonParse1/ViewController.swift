//
//  ViewController.swift
//  JsonParse1
//
//  Created by Mac on 08/05/1943 Saka.
//

import UIKit

struct Comments: Decodable {
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
}

class ViewController: UIViewController {
    
    var commentArray: [Comments] = []

    @IBOutlet weak var commentTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJson()
    }

    func parseJson()  {
        let str = "https://jsonplaceholder.typicode.com/comments"
        let url = URL(string: str)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                self.commentArray = try JSONDecoder().decode([Comments].self, from: data!)
                    DispatchQueue.main.async {
                        self.commentTable.reloadData()
                    }
                } catch {
                    print("Something went wrong")
                }
            }
        }.resume()
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let comment = commentArray[indexPath.row]
        cell?.textLabel?.text = comment.email
        cell?.detailTextLabel?.text = comment.body
        return cell!
    }
}
