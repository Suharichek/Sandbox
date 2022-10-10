//
//  ViewController.swift
//  Sandbox2
//
//  Created by Suharik on 13.09.2022.
//

import Foundation
import UIKit

class ViewController: UIViewController{
    
    private var photos = [Photo]()
    
    private lazy var imageTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    private lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let rightBarButton = UIBarButtonItem(title: "Add photo", style: UIBarButtonItem.Style.plain, target: self, action: #selector(myRightSideBarButtonItemTapped))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.view.addSubview(self.imageTableView)
        self.imageTableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        
        self.imageTableView.dataSource = self
        self.imageTableView.delegate = self
        
        setupLayout()
    }
    
    func getLibraryData() {
        
        self.photos.removeAll()
        
        let manager = FileManager.default
        
        guard
            let docUrl = try? manager.url(for: .documentDirectory,in: .userDomainMask,appropriateFor: nil,create: false),
            let contents = try? FileManager.default.contentsOfDirectory(at: docUrl,includingPropertiesForKeys: nil,options: [.skipsHiddenFiles])
        else { return }
        print(docUrl)
       // var attributes = [FileAttributeKey : Any]()
        for file in contents {
            let filePath = file.path
            do {
                 var attributes = try FileManager.default.attributesOfItem(atPath: filePath)
            } catch let error {
                print (error)
            }
            let image = UIImage(contentsOfFile: filePath) ?? UIImage()
            photos.append(Photo(image: image, filePath: filePath))
        }
    }
    
    @objc func myRightSideBarButtonItemTapped(_ sender:UIBarButtonItem!)
    {
        present(imagePicker, animated: true)
        print("myRightSideBarButtonItemTapped")
    }
    
    private func addPhotoToLibrary(_ image:UIImage) {
        let manager = FileManager.default
        do {
            let docUrl =  try manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileItem = UUID().uuidString
            let imagePath = docUrl.appendingPathComponent("\(fileItem).jpg")
            let data = image.jpegData(compressionQuality: 1.0)
            manager.createFile(atPath: imagePath.path, contents: data)
        } catch let error {
            print(error)
        }
        getLibraryData()
        imageTableView.reloadData()
    }
    
    private func removePhoto (_ filePath: String) {
        do {
            try FileManager.default.removeItem(atPath: filePath)
        } catch {
            print(error)
        }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            imageTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imageTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.imageTableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.imageView?.image = self.photos[indexPath.row].image
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removePhoto(photos[indexPath.row].filePath)
            getLibraryData()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My photos"
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            self.addPhotoToLibrary(image)
            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    }
}


