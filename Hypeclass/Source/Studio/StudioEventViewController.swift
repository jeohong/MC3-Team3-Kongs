//
//  StudioEventViewController.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/08/02.
//

import UIKit

class StudioEventViewController: BaseViewController {
    
    //MARK: - Properties
    
    var model: Studio?
    var danceClasses: [DanceClass]?
    
    let tableView: UITableView = {
       let tableView = UITableView()
        tableView.rowHeight = 260
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTable()
        requestClasses()
    }
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    
    func requestClasses() {
        guard let studioID = model?.id else { return }
        Task {
            IndicatorView.shared.show()
            IndicatorView.shared.showIndicator()
            let result = try? await DanceClassManager.shared.requestDanceClassBy(studioID: studioID)
            self.danceClasses = result
            tableView.reloadData()
            IndicatorView.shared.dismiss()
        }
    }
    
    func configureTable(){
        tableView.register(StudioEventCell.self, forCellReuseIdentifier: "StudioEventCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureUI() {
        //레이아웃 구성
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension StudioEventViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return danceClasses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StudioEventCell", for: indexPath) as? StudioEventCell else { return UITableViewCell() }
        guard let danceClass = danceClasses?[indexPath.row] else { return cell }
        cell.titleLabel.text = danceClass.name
        cell.subTitleLabel.text = "\(danceClass.startTime?.hourMinText ?? "")~\(danceClass.endTime?.hourMinText ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 클래스 페이지로 이동
    }
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
