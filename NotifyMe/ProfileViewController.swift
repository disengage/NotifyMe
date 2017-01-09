//
//  ProfileViewController.swift
//  NotifyMe
//
//  Created by Narongsak kongpan on 1/9/2560 BE.
//  Copyright © 2560 Narongsak kongpan. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import AlamofireImage
import FBSDKLoginKit

class ProfileViewController: UIViewController,FBSDKLoginButtonDelegate {

    @IBOutlet weak var btnFBLogin: FBSDKLoginButton!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblProfileName: UILabel!
    @IBOutlet weak var lblProfileEmail: UILabel!
    
    var currentProfile:FBSDKProfile!;
    
    // MARK: - UI Actions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let request:FBSDKGraphRequest! = FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"id,name,email"]);
        request.start { (connection, response, error) in
            if(error == nil){
                let info:NSDictionary = response as! NSDictionary;
                self.lblProfileName.text = info.object(forKey: "name") as! String?;
                self.lblProfileEmail.text = info.object(forKey: "email") as! String?;
            }
        };
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lblProfileName.text = "";
        lblProfileEmail.text = "";
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let profileImage:URL! = currentProfile.imageURL(for: .square, size: CGSize.init(width: 100, height: 100));
        NSLog("Profile URL : %@", profileImage.absoluteString);
        imgProfile.af_setImage(withURL: profileImage);
    }
    
    // MARK: - FBLoginButton Delegate
    public func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!){
        NSLog("%@", "Facebook has login");
    }
    
    public func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!){
        FBSDKLoginManager.init().logOut();
        self.navigationController?.popToRootViewController(animated: true);
        NSLog("%@", "Facebook has logout");
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Others
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
