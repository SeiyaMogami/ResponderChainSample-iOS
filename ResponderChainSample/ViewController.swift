//
//  ViewController.swift
//  ResponderChainSample
//
//  Created by Seiya Mogami on 2018/04/26.
//  Copyright © 2018年 SeiyaMogami. All rights reserved.
//

import UIKit

protocol ViewEvent {
    associatedtype EventHandler
    func notify(to handler: EventHandler)
}

extension UIResponder {
    func notify<E: ViewEvent>(_ event: E) {
        var responder: UIResponder? = self
        while responder != nil {
            if let handler = responder as? E.EventHandler {
                return event.notify(to: handler)
            }
            responder = responder?.next
        }
    }
}

struct SampleModel {
    var title: String
}

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    private var tableSource = [SampleModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "SampleCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "SampleCell")
        tableView.delegate = self
        tableView.dataSource = self

        tableSource.append(contentsOf: [
            SampleModel(title: "カレーライス"),
            SampleModel(title: "ラーメン"),
            SampleModel(title: "からあげ"),
            SampleModel(title: "ぎょうざ")
            ])

        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SampleCell") as! SampleCell
        cell.model = tableSource[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableSource.count
    }
}

extension ViewController: SampleCellDelegate {
    func didTapLikeButton(_ data: SampleModel) {
        label.text = "\(data.title)が好き！"
    }

    func didTapDislikeButton(_ data: SampleModel) {
        label.text = "\(data.title)が嫌い！"
    }
}

