//
//  ViewController.swift
//  UITableViewLifeCycleTest
//
//  Created by 이병훈 on 12/7/24.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var tableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.rowHeight = 56
        t.delegate = self
        t.dataSource = self
        t.register(SomeCell.self, forCellReuseIdentifier: SomeCell.Constants.identifier)
        return t
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.setupLayout()
    }

    private func setupUI() {
        
    }
    
    private func setupLayout() {
        self.view.addSubview(self.tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }

}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        guard let someCell: SomeCell = tableView.dequeueReusableCell(withIdentifier: SomeCell.Constants.identifier, for: indexPath) as? SomeCell
        else {
            return UITableViewCell()
        }
        
        print("========= cellForRowAt index: \(indexPath.row) ===========")
        someCell.setupUI(indexPathRow: indexPath.row)
        cell = someCell
        return cell
    }
    
}


final class SomeCell: UITableViewCell {
    
    private lazy var label: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = .boldSystemFont(ofSize: 24)
        v.textColor = .black
        return v
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        print("========= Cell init ===========")
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print("========= \(#function) ===========")
    }
    
    func setupUI(indexPathRow: Int) {
        self.label.text = "label row index: \(indexPathRow)"
    }
    
    private func setupLayout() {
        self.contentView.addSubview(self.label)
        
        NSLayoutConstraint.activate([
            self.label.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.label.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
    
}

extension SomeCell {
    
    enum Constants {
        static let identifier: String = "SomeCell"
    }

}
