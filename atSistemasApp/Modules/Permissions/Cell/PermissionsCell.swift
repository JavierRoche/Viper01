//
//  PermissionsCell.swift
//  atSistemasApp
//
//  Created by APPLE on 18/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import UIKit

protocol PermissionsCellDelegate: class {
    func onChangeState(permission: Permission?)
}

class PermissionsCell: UITableViewCell {
    lazy var permissionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var permissionSwitch: UISwitch = {
        let switchy: UISwitch = UISwitch()
        switchy.setOn(false, animated: false)
        switchy.addTarget(self, action: #selector(switchStateChanged), for: UIControl.Event.valueChanged)
        switchy.translatesAutoresizingMaskIntoConstraints = false
        return switchy
    }()
    
    weak var delegate: PermissionsCellDelegate?
    private var permission: Permission?
    
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override func prepareForReuse() {
        permissionSwitch.setOn(false, animated: false)
        permissionLabel.text = nil
    }
    
    
    // MARK: User Interactions
    
    @objc private func switchStateChanged(sender: UISwitch!) {
        permission?.state = Int16(permissionSwitch.isOn ? PermissionState.done.rawValue : PermissionState.todo.rawValue)
        delegate?.onChangeState(permission: self.permission)
    }
    
    
    // MARK: Public Functions
    
    func configureCell(permission: Permission) {
        setViewsHierarchy()
        setConstraints()
        
        self.permission = permission
        permissionLabel.text = permission.title
    }
    
    
    // MARK: Private Functions
        
    fileprivate func setViewsHierarchy() {
        self.addSubview(permissionLabel)
        self.addSubview(permissionSwitch)
    }
    
    fileprivate func setConstraints() {
        NSLayoutConstraint.activate([
            permissionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            permissionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 16),
            permissionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            permissionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            permissionSwitch.centerYAnchor.constraint(equalTo: permissionLabel.centerYAnchor),
            permissionSwitch.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0)
        ])
    }
}




