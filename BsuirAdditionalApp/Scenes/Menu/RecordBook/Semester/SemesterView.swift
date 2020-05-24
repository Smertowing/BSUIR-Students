//
//  SemesterView.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/12/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

class SemesterView: UIView {
  private let cellId = "MarkCellId"

  class func instanceFromNib() -> SemesterView {
    return UINib(nibName: "Semester", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SemesterView
  }

  @IBOutlet weak var semesterNumberLabel: UILabel!
  @IBOutlet weak var averageMarkLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!

  var currentSem: SemesterCache?
  weak var parent: UIViewController!
  
  func set(_ semester: SemesterCache?) {
    guard let semester = semester else {
      return
    }
    
    self.currentSem = semester

    semesterNumberLabel.text = "\(semester.number)"
    averageMarkLabel.text = String(format: "%.2f", semester.averageMark)
    tableView.reloadData()
  }
  
  func addParent(parent: UIViewController) {
    self.parent = parent
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.tableFooterView = UIView()
    tableView.backgroundView = UIView()
    tableView.separatorColor = AppColors.textFieldColor.uiColor()

    let nib = UINib.init(nibName: "MarkCell", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: cellId)
  }
}

extension SemesterView: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    let number = currentSem?.marks.count ?? 0
    if number == 0 {
      tableView.backgroundView?.isHidden = false
    } else {
      tableView.backgroundView?.isHidden = true
    }
    return number
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let storyBoard = UIStoryboard(name: "Menu", bundle: nil)
    let markTableViewController = storyBoard.instantiateViewController(withIdentifier: "markTableVC") as! MarkTableViewController
    markTableViewController.set(currentSem?.marks[indexPath.row] ?? nil, semester: currentSem?.number ?? nil)
    parent.show(markTableViewController, sender: self)
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MarkCell

    cell.set(currentSem?.marks[indexPath.row] ?? nil)

    cell.layer.borderColor = AppColors.backgroundColor.cgColor()
    cell.layer.borderWidth = 4.0
    cell.layer.masksToBounds = true

    return cell
  }
}
