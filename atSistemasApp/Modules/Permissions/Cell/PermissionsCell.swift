//
//  PermissionsCell.swift
//  atSistemasApp
//
//  Created by APPLE on 18/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import UIKit
import SnapKit

protocol PermissionsCellDelegate: class {
    func onChangeState(permission: Permission?)
}

class PermissionsCell: UITableViewCell {
    lazy var permissionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.fontStyle17SemiBold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var grantedLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.fontStyle17SemiBold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var permissionSwitch: UISwitch = {
        let switchy: UISwitch = UISwitch()
        switchy.set(width: 65, height: 35)
        switchy.setOn(false, animated: false)
        switchy.onTintColor = UIColor.tangerine
        switchy.addTarget(self, action: #selector(switchStateChanged), for: UIControl.Event.valueChanged)
        switchy.translatesAutoresizingMaskIntoConstraints = false
        return switchy
    }()
    
    weak var delegate: PermissionsCellDelegate?
    private var permission: Permission?
    
    
    // MARK: Lifecycle
    
    override func prepareForReuse() {
        permissionSwitch.setOn(false, animated: false)
        permissionLabel.text = nil
        grantedLabel.text = nil
    }
    
    
    // MARK: User Interactions
    
    @objc private func switchStateChanged(sender: UISwitch!) {
        permission?.state = Int16(permissionSwitch.isOn ? PermissionState.done.rawValue : PermissionState.todo.rawValue)
        delegate?.onChangeState(permission: permission)
    }
    
    
    // MARK: Public Functions
    
    func configureCell(permission: Permission) {
        self.permission = permission
        
        setViewsHierarchy()
        setConstraints()
        configureUI()
    }
    
    
    // MARK: Private Functions
    
    fileprivate func setViewsHierarchy() {
        self.addSubview(permissionLabel)
        self.addSubview(grantedLabel)
        self.addSubview(permissionSwitch)
    }
    
    fileprivate func setConstraints() {
        permissionLabel.snp.remakeConstraints { make in
            make.top.equalTo(snp.top).inset(16.0)
            make.bottom.equalTo(snp.bottom).offset(16.0)
            make.leading.equalTo(snp.leading).inset(8.0)
        }
        
        grantedLabel.snp.remakeConstraints { make in
            make.centerY.equalTo(permissionLabel.snp.centerY)
            make.trailing.equalTo(snp.trailing).offset(-8.0)
        }
        
        permissionSwitch.snp.remakeConstraints { make in
            make.centerY.equalTo(permissionLabel.snp.centerY)
            make.trailing.equalTo(snp.trailing).inset(16.0)
        }
    }
    
    fileprivate func configureUI() {
        permissionLabel.text = permission?.title
        if permission?.state == Int16(PermissionState.done.rawValue) {
            grantedLabel.isHidden = false
            permissionSwitch.isHidden = true
            
            guard let granted = permission?.granted else { return }
            grantedLabel.text = granted ? PermissionInfo.authorized.localizedString : PermissionInfo.notAuthorized.localizedString
            
        } else {
            grantedLabel.isHidden = true
            permissionSwitch.isHidden = false
        }
    }
}
