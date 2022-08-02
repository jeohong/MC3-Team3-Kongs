//
//  StudioEventViewController.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/08/02.
//

import UIKit

class StudioEventViewController: BaseViewController {
    
    //MARK: - Properties
    let tableView: UITableView = {
       let tableView = UITableView()
        return tableView
    }()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    //MARK: - Selectors
    //MARK: - Helpers
    
    func configureTable(){
        self.tableView.register(StudioEventCell.self, forCellReuseIdentifier: "StudioEventCell")
    }
    
    func configureUI() {
        //레이아웃 구성
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            tableView.trailingAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension StudioEventViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StudioEventCell", for: indexPath) as? StudioEventCell else { return UITableViewCell() }
        return cell
        
    }
}

class StudioEventCell: UITableViewCell {
    
}

//MARK: - Preview
import SwiftUI

struct StudioEventViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = StudioEventViewController

    func makeUIViewController(context: Context) -> StudioEventViewController {
        return StudioEventViewController()
    }

    func updateUIViewController(_ uiViewController: StudioEventViewController, context: Context) {}
}

@available(iOS 13.0.0, *)
struct StudioEventViewControllerPreview: PreviewProvider {
    static var previews: some View {
        StudioEventViewControllerRepresentable()
    }
}
