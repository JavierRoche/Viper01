//
//  PermissionsView.swift
//  atSistemasApp
//
//  Created by APPLE on 10/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//
//

import UIKit

class PermissionsView: BaseViewController, PermissionsViewContract {
    lazy var backgroundView: UIView = {
        let view: UIView = UIView(frame: self.view.bounds)
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var segmentControl: UISegmentedControl = {
        let segment: UISegmentedControl = UISegmentedControl()
        segment.insertSegment(withTitle: Constants.todo, at: 0, animated: true)
        segment.insertSegment(withTitle: Constants.done, at: 1, animated: true)
        segment.selectedSegmentIndex = 0
        segment.layer.cornerRadius = 4.0
        segment.addTarget(self, action: #selector(changeSegment), for: UIControl.Event.valueChanged)
        return segment
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: UITableView.Style.plain)
        table.register(PermissionsCell.self, forCellReuseIdentifier: String(describing: PermissionsCell.self))
        table.estimatedRowHeight = 40.0
        table.dataSource = self
        table.delegate = self
        table.separatorColor = UIColor.clear
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
	var presenter: PermissionsPresenterContract!

    /// Permission to show / work
    private var currentPermissionList: [Permission] = []
    private var permissionList: [Permission] = []
    /// Computable var set what permissions have to be showed
    private var permissionStateSelected: PermissionState = .todo {
        didSet {
            currentPermissionList = permissionList.filter {
                $0.state == permissionStateSelected.rawValue
            }
        }
    }
    
    
	// MARK: LifeCycle

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        setViewsHierarchy()
        setConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        /// README: nunca consegui colocar un UISegmentedControl por constraints definido por codigo; cualquier intento lo hace desaparecer.
        /// Esto ya me habia peleado con ello hace tiempo y la unica forma que encontre de colocarlo en pantalla fue asi.
        segmentControl.frame = CGRect(x: 64, y: 264, width: (view.bounds.width - 128), height: 31)
    }
    
    
    // MARK: User Interactions
    
    @objc private func changeSegment(sender: UISegmentedControl!) {
        permissionStateSelected = PermissionState(rawValue: segmentControl.selectedSegmentIndex) ?? .todo
        tableView.reloadData()
    }
    
    
    // MARK: Public Functions
    
    func permissionListDidChange(permissionList: [Permission]) {
        self.permissionList = permissionList
        permissionStateSelected = PermissionState(rawValue: segmentControl.selectedSegmentIndex) ?? .todo
        tableView.reloadData()
    }
    
    func permissionRequested(permission: Permission) {
        guard let permissionState = PermissionState(rawValue: Int(permission.state)) else { return }
        
        /// Update model
        permissionList.forEach {
            $0.granted = $0.title == permission.title ? permission.granted : $0.granted
            $0.state = $0.title == permission.title ? Int16(permissionState.rawValue) : $0.state
        }
    }
    
    
    // MARK: Private Functions
    
    fileprivate func setViewsHierarchy() {
        view = UIView()
        
        view.addSubview(backgroundView)
        view.addSubview(segmentControl)
        view.addSubview(tableView)
    }
    
    fileprivate func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: segmentControl.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: segmentControl.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}


// MARK: UITableView Delegate

extension PermissionsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}


// MARK: UITableView DataSource

extension PermissionsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentPermissionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PermissionsCell.self),
                                                       for: indexPath) as? PermissionsCell else {
            fatalError()
        }
        cell.delegate = self
        cell.configureCell(permission: currentPermissionList[indexPath.row])
        
        return cell
    }
}


// MARK: PermissionsCell Delegate

extension PermissionsView: PermissionsCellDelegate {
    func onChangeState(permission: Permission?) {
        /// Get rawValue enumerate from state
        guard let permission = permission else { return }
        
        /// Launch diferent user permissions
        switch permission.title {
        case PermissionType.camera.localizedString:
            presenter.requestForCameraPermission(permission: permission)
            
        case PermissionType.location.localizedString:
            presenter.requestForLocationPermission(permission: permission)
        
        case PermissionType.photosLibrary.localizedString:
            presenter.requestForPhotosLibraryPermission(permission: permission)
        
        default:
            break
        }
        
        /// Update table only if diferent of .todo
        permissionStateSelected = PermissionState(rawValue: segmentControl.selectedSegmentIndex) ?? .todo
        tableView.reloadData()
    }
}
