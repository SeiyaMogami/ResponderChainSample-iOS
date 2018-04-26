//
//  SampleCell.swift
//  ResponderChainSample
//
//  Created by Seiya Mogami on 2018/04/26.
//  Copyright © 2018年 SeiyaMogami. All rights reserved.
//

import UIKit

enum SampleCellAction {
    case like(SampleModel)
    case dislike(SampleModel)
}

extension SampleCellAction: ViewEvent {
    func notify(to handler: SampleCellDelegate) {
        switch self {
        case .like(let model):
            handler.didTapLikeButton(model)
        case .dislike(let model):
            handler.didTapDislikeButton(model)
        }
    }
}

protocol SampleCellDelegate {
    func didTapLikeButton(_ data: SampleModel)
    func didTapDislikeButton(_ data: SampleModel)
}

class SampleCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    var model: SampleModel? {
        didSet {
            titleLabel.text = model?.title
        }
    }

    @IBAction func didTapLikeButton(_ sender: Any) {
        if let model = model {
            let action = SampleCellAction.like(model)
            self.notify(action)
        }
    }

    @IBAction func didTapDislikeButton(_ sender: Any) {
        if let model = model {
            let action = SampleCellAction.dislike(model)
            self.notify(action)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
