//
//  ViewController.swift
//  ToolBox
//
//  Created by Murph on 2022/7/22.
//

import UIKit

class ViewController: UIViewController {
    
    let toolList = [
        (title: "Rec In Web Page", imageName: "camera.badge.ellipsis", action: #selector(enterWebpageRec))
    ]
    
    @IBOutlet weak var toolBoxList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContent()
    }
    
    private func setupContent() {
        toolBoxList.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        toolBoxList.delegate = self
        toolBoxList.dataSource = self
        title = "TOOLBOX"
    }
    
    @objc func enterWebpageRec() {
        navigationController?.pushViewController(RecViewController(), animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toolList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = toolList[indexPath.row].title
        cell.imageView?.image = UIImage(systemName: toolList[indexPath.row].imageName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.perform(toolList[indexPath.row].action)
    }
}
