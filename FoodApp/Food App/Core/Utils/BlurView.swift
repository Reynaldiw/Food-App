//
//  BlurView.swift
//  Food App
//
//  Created by Amin faruq on 18/12/20.
//

import SwiftUI

struct BlurView: UIViewRepresentable {

  func makeUIView(
    context: UIViewRepresentableContext<BlurView>
  ) -> UIView {
    let view = UIView()
    view.backgroundColor = .clear
    let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
    let blurView = UIVisualEffectView(effect: blurEffect)
    blurView.translatesAutoresizingMaskIntoConstraints = false
    view.insertSubview(blurView, at: 0)
    NSLayoutConstraint.activate([
      blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
      blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
    ])
    return view
  }

  func updateUIView(
    _ uiView: UIView,
    context: UIViewRepresentableContext<BlurView>
  ) {}

}

