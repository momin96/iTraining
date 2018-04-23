//
//  ViewController.swift
//  DemoOnCodable
//
//  Created by Nasir Ahmed Momin on 20/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//


// https://medium.com/xcblog/painless-json-parsing-with-swift-codable-2c0beaeb21c1

import UIKit
import Foundation

struct MyGitHub: Codable {
    let name: String
    let location: String
    let followers: Int
    let avatarURL: String
    let repos: Int

    private enum CodinKeys: String, CodingKey {
        case name       = "name"
        case location   = "location"
        case followers   = "followers"
        case repos      = "public_repos"
        case avatarURL  = "avatar_url"
    }
    
    init(from decoder : Decoder) throws{
        let value = try decoder.container(keyedBy: CodinKeys.self)
        name = try value.decode(String.self, forKey: .name)
        location = try value.decode(String.self, forKey: .location)
        avatarURL = try value.decode(String.self, forKey: .avatarURL)
        followers = try value.decode(Int.self, forKey: .followers)
        repos = try value.decode(Int.self, forKey: .repos)
    }
    
}

class ViewController: UIViewController {

    @IBAction func ShowGithubInfo(_ sender: Any) {
        
        let userText = gitUname.text?.lowercased()
        
        guard let gitUrl = URL(string: "https://api.github.com/users/" + userText!) else { return }
        
        URLSession.shared.dataTask(with: gitUrl) { (data, response
            , error) in
            
            
            guard let dt = data else { return }

            do {
                let decoder = JSONDecoder()
                let gitData = try decoder.decode(MyGitHub.self, from: dt)
                print(gitData.name as Any)

                DispatchQueue.main.sync {
                    let data = try? Data(contentsOf: URL(string: gitData.avatarURL)!)
                        let image: UIImage = UIImage(data: data!)!
                        self.gravatarImage.image = image
              
                        self.name.text = gitData.name
          
                        self.location.text = gitData.location
   
                        self.followers.text = String(gitData.followers)

                        self.blog.text = String(gitData.repos)
                    self.setLabelStatus(value: false)
                }
                
                
                
//                let jsonData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
//                print(jsonData)
            }
            catch let err{
                print("catch \(err)")
            }
            
//
//            guard let data = data else { return }
//            do {
//
//                let decoder = JSONDecoder()
//                let gitData = try decoder.decode(MyGitHub.self, from: data)
//
//
//
//
//            } catch let err {
//                print("Err", err)
//            }
            }.resume()
        
        
        
    }
    @IBOutlet weak var gitUname: UITextField!
    var imageUrl: URL?
    var newImage: UIImage?

    @IBOutlet weak var blog: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var gravatarImage: UIImageView!
    
    @IBOutlet weak var gname: UILabel!
    @IBOutlet weak var glocation: UILabel!
    @IBOutlet weak var grepos: UILabel!
    @IBOutlet weak var gfollowers: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelStatus(value: true)
    }
    
    func setLabelStatus(value: Bool) {
        name.isHidden = value
        location.isHidden = value
        followers.isHidden = value
        blog.isHidden = value
        gname.isHidden = value
        glocation.isHidden = value
        gfollowers.isHidden = value
        grepos.isHidden = value
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

