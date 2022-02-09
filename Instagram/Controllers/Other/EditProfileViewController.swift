//
//  EditProfileViewController.swift
//  Instagram
//
//  Created by Admin on 23.01.2022.
//

import UIKit

struct EditProfileFormModel {
    let label: String
    let placeholder: String
    var value: String?
}

final class EditProfileViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        return tableView
    }()
    
    private var models = [[EditProfileFormModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.tableHeaderView = configureHeaderViewOfTableView()
        configureModels()
        tableView.dataSource = self
        self.view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveDidTapped))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDidTapped))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        // name, username, website, bio
        let section1Labels = ["Name","Username","Bio"]
        var section1 = [EditProfileFormModel]()
        for value in section1Labels {
            let newValue = EditProfileFormModel(label: value, placeholder: "Enter \(value)...", value: nil)
            section1.append(newValue)
        }
        models.append(section1)
        //email, phone, gender
        
        let section2Labels = ["Email","Phone","Gender"]
        var section2 = [EditProfileFormModel]()
        for value in section2Labels {
            let newValue = EditProfileFormModel(label: value, placeholder: "Enter \(value)...", value: nil)
            section2.append(newValue)
        }
        models.append(section2)
    }
    
    // MARK: - Tableview
    
    private func configureHeaderViewOfTableView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height / 4).integral)
        
        let size = headerView.height / 1.5
        
        let profilePhoto = UIButton(frame: CGRect(x: (view.width - size)/2, y: (headerView.height-size) / 2, width: size, height: size))
        headerView.addSubview(profilePhoto)
        profilePhoto.tintColor = .label
        profilePhoto.layer.masksToBounds = true
        profilePhoto.layer.cornerRadius = size / 2.0
        profilePhoto.addTarget(self, action: #selector(didTapProfileButton), for: .touchUpInside)
        profilePhoto.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        profilePhoto.layer.borderWidth = 1
        profilePhoto.layer.borderColor = UIColor.systemBackground.cgColor
        
        return headerView
    }
    
    @objc func didTapProfileButton() {
        
    }
    
    @objc private func saveDidTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func cancelDidTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    private func changePhoto() {
        let alertSheet = UIAlertController(title: "Profile Picture", message: "Change Profile Picture", preferredStyle: .actionSheet)
        alertSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            
        }))
        alertSheet.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { _ in
            
        }))
        alertSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alertSheet.popoverPresentationController?.sourceView = view
        alertSheet.popoverPresentationController?.sourceRect = view.bounds
        
        present(alertSheet, animated: true)
    }
    
}

extension EditProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {return nil}
        return "Private Information"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as! FormTableViewCell
        cell.delegate = self
        cell.configureWith(model: model)
        return cell
    }
    
    
}

extension EditProfileViewController: FormTableViewCellDelegate {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel) {
        print(updatedModel.value ?? "nil")
    }
    
    
}
