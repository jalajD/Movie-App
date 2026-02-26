//
//  TitlePreviewViewControllerViewController.swift
//  Movie-App
//
//  Created by Deotwal, Jalaj | Ronnie on 2025/12/16.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {

    private var currentTitle: Title?

    private let webView: WKWebView = {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()

    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        return label
    }()

    private let downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(downloadButton)
        configureConstraints()
        downloadButton.addTarget(self, action: #selector(downloadButtonTapped), for: .touchUpInside)
    }

    private func configureConstraints() {

        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ]

        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ]

        let overviewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ]

        let downloadButtonConstraints = [
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 30),
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.widthAnchor.constraint(equalToConstant: 150),
            downloadButton.heightAnchor.constraint(equalToConstant: 50)
        ]

        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }

    func configure(with model: TitlePreviewViewModel, title: Title? = nil) {
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        currentTitle = title

        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeVideo.id.videoId)") else { return }
        var request = URLRequest(url: url)
        guard let bundleID = Bundle.main.bundleIdentifier else { return }
        request.setValue("https://\(bundleID)", forHTTPHeaderField: "Referer")
        webView.load(request)
    }

    @objc private func downloadButtonTapped() {
        guard let title = currentTitle else { return }

        DataPersistenceManager.shared.downloadTitleWith(model: title) { [weak self] result in
            switch result {
                case .success(let downloadResult):
                    switch downloadResult {
                        case .added:
                            NotificationCenter.default.post(name: NSNotification.Name("Downloaded"), object: nil)
                            DispatchQueue.main.async {
                                self?.showToast(message: "Added to downloads")
                            }
                        case .alreadyExists:
                            DispatchQueue.main.async {
                                self?.showToast(message: "Already in downloads")
                            }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
