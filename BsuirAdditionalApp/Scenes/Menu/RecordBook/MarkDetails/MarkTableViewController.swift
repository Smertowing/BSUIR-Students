//
//  MarkTableViewController.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 5/24/20.
//  Copyright © 2020 Kiryl Holubeu. All rights reserved.
//

import UIKit

class MarkTableViewController: UITableViewController {
  private let viewModel = MarkTableViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureMarkTable()
  }
  
  func set(_ mark: MarkCache!, semester: Int!) {
    guard let mark = mark, let semester = semester else {
      return
    }
    
    navigationItem.title = "Семестер".localized + " №\(semester)"
    
    self.viewModel.setCurrentMark(with: mark)
  }
  
  func configureMarkTable() {
    tableView.tableFooterView = UIView()
    tableView.backgroundView = EmptyBackgroundView.instanceFromNib()
    tableView.separatorColor = AppColors.textFieldColor.uiColor()
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.numberOfRows
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "markTableViewCell", for: indexPath) as! MarkTableViewCell
    cell.set(viewModel.value(of: indexPath))
    return cell
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return viewModel.name(of: section)
  }
  
  override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    (view as! UITableViewHeaderFooterView).contentView.backgroundColor = AppColors.backgroundColor.uiColor()
    (view as! UITableViewHeaderFooterView).textLabel?.textColor = AppColors.accentColor.uiColor()
  }
  
  override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 24
  }
  
  override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
    (view as! UITableViewHeaderFooterView).contentView.backgroundColor = AppColors.backgroundColor.uiColor()
    (view as! UITableViewHeaderFooterView).textLabel?.textColor = AppColors.accentColor.uiColor()
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }

}
