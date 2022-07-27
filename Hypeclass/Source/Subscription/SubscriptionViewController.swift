//
//  SubscriptionViewController.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/12.
//

import UIKit

class SubscriptionViewController: BaseViewController{
   
    // MARK: - Properties
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .background
        return tv
    }()
    
    private let dancerTabButton: UIButton = {
        var button = UIButton()
        button.setTitle("댄서", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(dancerTapped), for: .touchUpInside)
        return button
    }()
    
    private let studioTabButton: UIButton = {
        var button = UIButton()
        button.setTitle("스튜디오", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(studioTapped), for: .touchUpInside)
        return button
    }()
    
    private let tabIndicatorView: UIView = UIView()
    
    private var tabIndicator: Separator = {
        let sep = Separator()
        sep.backgroundColor = .white
        return sep
    }()
    
    private var isDancerTab = true
    
    private let cellID = "subscription"
    
    private var dancerIDs = UserDefaults.standard.stringArray(forKey: "SubscribedDancers") ?? ["958DDBD8-689E-49D0-AC60-F7C0EC2611BC", "ADC4A0E1-50DF-4784-9228-EE4622C226E8", "0E36AA46-941C-40B0-9B18-818745EE1FD0"]
    
    private var studioIDs = UserDefaults.standard.stringArray(forKey: "SubscribedStudios") ?? ["81DB67B8-9CAC-4AFE-B261-75BF7EE54534", "E23BD12A-ACDB-4BF6-B7C8-CFFC6BA4D1D4"]
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await requestMyDancers()
            await requestMyStudios()
        }
    }
    
    // MARK: - Selectors
    
    @objc func dancerTapped() {
        if !isDancerTab {
            UIView.animate(withDuration: 0.3) {
                self.tabIndicator.frame.origin.x = 0
            }
            isDancerTab.toggle()
            tableView.reloadData()
        }
    }
    
    @objc func studioTapped() {
        if isDancerTab {
            UIView.animate(withDuration: 0.3) {
                self.tabIndicator.frame.origin.x = Device.width / 2
            }
            isDancerTab.toggle()
            tableView.reloadData()
        }
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        // dancerTabButton
        view.addSubview(dancerTabButton)
        dancerTabButton.translatesAutoresizingMaskIntoConstraints = false
        dancerTabButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        dancerTabButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dancerTabButton.widthAnchor.constraint(equalToConstant: Device.width / 2).isActive = true
        dancerTabButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        // studioTabButton
        view.addSubview(studioTabButton)
        studioTabButton.translatesAutoresizingMaskIntoConstraints = false
        studioTabButton.topAnchor.constraint(equalTo: dancerTabButton.topAnchor).isActive = true
        studioTabButton.leadingAnchor.constraint(equalTo: dancerTabButton.trailingAnchor).isActive = true
        studioTabButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        studioTabButton.bottomAnchor.constraint(equalTo: dancerTabButton.bottomAnchor).isActive = true
        
        // tabIndicatorView
        view.addSubview(tabIndicatorView)
        tabIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        tabIndicatorView.topAnchor.constraint(equalTo: dancerTabButton.bottomAnchor).isActive = true
        tabIndicatorView.leadingAnchor.constraint(equalTo: dancerTabButton.leadingAnchor).isActive = true
        tabIndicatorView.trailingAnchor.constraint(equalTo: studioTabButton.trailingAnchor).isActive = true
        tabIndicatorView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        // Add tabIndicator to tabIndicatorView
        tabIndicatorView.addSubview(tabIndicator)
        tabIndicator.translatesAutoresizingMaskIntoConstraints = false
        tabIndicator.topAnchor.constraint(equalTo: tabIndicatorView.topAnchor).isActive = true
        tabIndicator.leadingAnchor.constraint(equalTo: tabIndicatorView.leadingAnchor).isActive = true
        tabIndicator.trailingAnchor.constraint(equalTo: tabIndicatorView.trailingAnchor, constant: -Device.width / 2).isActive = true
        tabIndicator.bottomAnchor.constraint(equalTo: tabIndicatorView.bottomAnchor).isActive = true
        
        // tableView
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: tabIndicator.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.backgroundColor = .clear
    }
    
    private func configureTableView() {
        tableView.register(ItemCell.self, forCellReuseIdentifier: cellID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 120
    }
    
    // DancerManager.myDancers가 nil이면 Userdefault에 저장된 구독한 댄서 아이디 배열로 firebase에서 댄서 정보를 가져옵니다.
    private func requestMyDancers() async {
        do {
            if DancerManager.myDancers == nil {
                IndicatorView.shared.show()
                IndicatorView.shared.showIndicator()
                DancerManager.myDancers = try await DancerManager.shared.requestDancersBy(dancerIDs: dancerIDs)
                IndicatorView.shared.dismiss()
            }
            tableView.reloadData()
        }
        catch {
            print(error)
        }
    }
    
    // StudioManager.myStudios가 nil이면 Userdefault에 저장된 구독한 스튜디오 아이디 배열로 firebase에서 스튜디오 정보를 가져옵니다.
    private func requestMyStudios() async {
        do {
            if StudioManager.myStudios == nil {
                IndicatorView.shared.show()
                IndicatorView.shared.showIndicator()
                StudioManager.myStudios = try await StudioManager.shared.requestStudiosBy(studioIDs: studioIDs)
                IndicatorView.shared.dismiss()
            }
            tableView.reloadData()
        }
        catch {
            print(error)
        }
    }
}

// MARK: - UICollectionView Extension

extension SubscriptionViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isDancerTab {
            return dancerIDs.count
        } else {
            return studioIDs.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isDancerTab {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ItemCell
            cell.titleLabel.text = DancerManager.myDancers?[indexPath.row].name
            cell.subtitleLabel.text =  "장르"
            cell.detailLabel.text = DancerManager.myDancers?[indexPath.row].id
            // TODO: 댄서 이미지 url로 교체
            cell.profileImage.load(url: URL(string: "https://src.hidoc.co.kr/image/lib/2021/4/28/1619598179113_0.jpg")!)
            cell.backgroundColor = .clear
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ItemCell
            cell.titleLabel.text = StudioManager.myStudios?[indexPath.row].name
            cell.subtitleLabel.text = StudioManager.myStudios?[indexPath.row].description
            cell.detailLabel.text = StudioManager.myStudios?[indexPath.row].id
            // TODO: 스튜디오 이미지 url로 교체
            //cell.profileImage.load(url: URL(string: "https://src.hidoc.co.kr/image/lib/2021/4/28/1619598179113_0.jpg")!)
            cell.profileImage.image = UIImage()
            cell.backgroundColor = .clear
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isDancerTab {
            let dancerDetailVC = DancerDetailViewController()
            dancerDetailVC.dancerID = DancerManager.myDancers?[indexPath.row].id
            self.navigationController?.pushViewController(dancerDetailVC, animated: true)
        } else {
            // TODO: 스튜디오 디테일 페이지로 이동, 스튜디오 ID 넘기기
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if isDancerTab {
                DancerManager.myDancers?.remove(at: indexPath.row)
                dancerIDs.remove(at: indexPath.row)
                // TODO: UserDefault에 변경사항 반영
            } else {
                StudioManager.myStudios?.remove(at: indexPath.row)
                studioIDs.remove(at: indexPath.row)
                // TODO: UserDefault에 변경사항 반영
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - Preview

import SwiftUI

struct SubscriptionViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = SubscriptionViewController

    func makeUIViewController(context: Context) -> SubscriptionViewController {
        return SubscriptionViewController()
    }

    func updateUIViewController(_ uiViewController: SubscriptionViewController, context: Context) {}
}

@available(iOS 13.0.0, *)
struct SubscriptionViewControllerPreview: PreviewProvider {
    static var previews: some View {
        SubscriptionViewControllerRepresentable()
    }
}
