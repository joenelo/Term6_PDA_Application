//
//  FeedController.swift
//  PDAInClassApp
//
//  Created by joseph nelson on 2018-05-07.
//  Copyright © 2018 joseph nelson. All rights reserved.
//

import UIKit

final class FeedController: UIViewController {
    @IBOutlet var tableView: UITableView!
}

extension FeedController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedPhotoCell", for: indexPath) as! FeedPhotoCell
        
        
        return cell
    }
}
