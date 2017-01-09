//
//  ViewController.swift
//  NotifyMe
//
//  Created by Narongsak kongpan on 1/8/2560 BE.
//  Copyright © 2560 Narongsak kongpan. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController,FBSDKLoginButtonDelegate {
    @IBOutlet weak var btnLoginFB: FBSDKLoginButton!
    
    var requestPermission = ["public_profile","email"];
    
    // MARK: - UI Actions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnLoginFB.readPermissions = requestPermission;
        btnLoginFB.delegate = self;
        
        let currentAccessToken:FBSDKAccessToken! = FBSDKAccessToken.current();
        if(currentAccessToken == nil){
            NSLog("%@", "Facebook not login");
        }else{
            NSLog("%@", "Facebook has already login");
            let profile:FBSDKProfile? = FBSDKProfile.current();
            if(profile != nil){
                self.performSegue(withIdentifier: Storyboard.kSegueIdentProfile, sender: profile);
            }else{
                FBSDKLoginManager.init().logOut();
            }
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.FBSDKProfileDidChange, object: nil, queue: nil, using: onProfileDidChange);
    }
    
    private func onProfileDidChange(notification:Notification){
        // User is logged in, do work such as go to next view controller.
        let profile:FBSDKProfile! = FBSDKProfile.current();
        if(profile != nil){
            self.performSegue(withIdentifier: Storyboard.kSegueIdentProfile, sender: profile);
            NSLog("%@", "Facebook has already login");
        }
    }

    // MARK: - FBLoginButton Delegate
    public func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!){
        if(error != nil){
            NSLog("Facebook has login with error : %@", error.localizedDescription);
        }else{
            NSLog("%@", "Facebook has login");
            let granted:Set<AnyHashable> = result.grantedPermissions;
            var count:Int = 0;
            for key in requestPermission{
                if(granted.contains(key)){
                    count += 1;
                }
            }
            if(result.isCancelled){
                NSLog("%@", "User has canceled");
            }
            if(count != requestPermission.count){
                NSLog("%@", "User not allow required permission");
            }
        }
    }
    
    public func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!){
        NSLog("%@", "Facebook has logout");
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == Storyboard.kSegueIdentProfile){
            let profileView:ProfileViewController = segue.destination as! ProfileViewController;
            profileView.currentProfile = sender as! FBSDKProfile;
        }
    }
    
    // MARK: - Others
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
