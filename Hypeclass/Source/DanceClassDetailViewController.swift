//
//  DanceClassDetailViewController.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/30.
//

import UIKit

class DanceClassDetailViewController: BaseViewController {
    
    //MARK: - Properties
    
    var model: DanceClass?
    
    let headerTitles = ["강사", "스튜디오"]
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "아프로 스타일 하우스 클래스"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        
        return label
    }()
    
    private let secondaryLabel: UILabel = {
        let label = UILabel()
        label.text = "6월 29일 수요일 18:20 ~ 21:40"
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .white
        
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 60
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        return tableView
    }()
    
    private let ctaButton: CTAButton = {
        let button = CTAButton(title: "신청하기")
        button.addTarget(self, action: #selector(ctaButtonTap), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
    }
    
    //MARK: - Selectors
    
    @objc func ctaButtonTap() {
        if AuthManager.shared.isLogin {
            // 로그인 되어 있을 시 신청 메서드 작동
            presentAlert(title: "신청하기", message: "신청 후에는 취소, 수강관련안내 문자가 회원님의 핸드폰 번호로 전송됩니다", isCancelActionIncluded: true, preferredStyle: .alert) { action in
                print("DEUBG: 신청하기 로직 연결 필요")
                self.presentBottomAlert(message: "신청이 완료되었습니다.")
            }
        } else {
            let vc = UINavigationController(rootViewController: AuthOnboardViewController())
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    //MARK: - Helpers
    
    func configureTableView() {
        tableView.register(ItemCell.self, forCellReuseIdentifier: "DanceClassDetailCell")
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    func configureUI() {
        //레이아웃 구성
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(coverImageView)
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: view.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            coverImageView.heightAnchor.constraint(equalToConstant: 220)
        ])
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 28),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
        ])
        
        view.addSubview(secondaryLabel)
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondaryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            secondaryLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            secondaryLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: secondaryLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 400)
        ])
        
        view.addSubview(ctaButton)
        ctaButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ctaButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            ctaButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            ctaButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            ctaButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

//MARK: - UITableViewDataSource

extension DanceClassDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Section
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()
        label.text = headerTitles[section]
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  25).isActive = true
        return view
    }
    
    //MARK: - ROW
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DanceClassDetailCell") as? ItemCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .clear
        cell.profileImage.backgroundColor = .systemPink
        
        return cell
    }
}


//MARK: - Preview
import SwiftUI

struct DanceClassDetailViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = DanceClassDetailViewController

    func makeUIViewController(context: Context) -> DanceClassDetailViewController {
        return DanceClassDetailViewController()
    }

    func updateUIViewController(_ uiViewController: DanceClassDetailViewController, context: Context) {}
}

@available(iOS 13.0.0, *)
struct DanceClassDetailViewControllerPreview: PreviewProvider {
    static var previews: some View {
        DanceClassDetailViewControllerRepresentable()
    }
}
