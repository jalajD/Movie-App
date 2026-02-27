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
    private var titleName: String?

    private let shimmerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
        return view
    }()

    private let errorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        view.isHidden = true
        return view
    }()

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No internet connection"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let errorIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "wifi.slash")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
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
        view.addSubview(shimmerView)
        view.addSubview(errorView)
        errorView.addSubview(errorIcon)
        errorView.addSubview(errorLabel)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(downloadButton)
        configureConstraints()
        downloadButton.addTarget(self, action: #selector(downloadButtonTapped), for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let gradientLayer = shimmerView.layer.mask as? CAGradientLayer {
            gradientLayer.frame = CGRect(x: -shimmerView.bounds.size.width, y: 0, width: 3 * shimmerView.bounds.size.width, height: shimmerView.bounds.size.height)
        }
    }

    private func configureConstraints() {

        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ]

        let shimmerViewConstraints = [
            shimmerView.topAnchor.constraint(equalTo: webView.topAnchor),
            shimmerView.leadingAnchor.constraint(equalTo: webView.leadingAnchor),
            shimmerView.trailingAnchor.constraint(equalTo: webView.trailingAnchor),
            shimmerView.bottomAnchor.constraint(equalTo: webView.bottomAnchor)
        ]

        let errorViewConstraints = [
            errorView.topAnchor.constraint(equalTo: webView.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: webView.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: webView.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: webView.bottomAnchor)
        ]

        let errorIconConstraints = [
            errorIcon.centerXAnchor.constraint(equalTo: errorView.centerXAnchor),
            errorIcon.centerYAnchor.constraint(equalTo: errorView.centerYAnchor, constant: -30),
            errorIcon.widthAnchor.constraint(equalToConstant: 60),
            errorIcon.heightAnchor.constraint(equalToConstant: 60)
        ]

        let errorLabelConstraints = [
            errorLabel.topAnchor.constraint(equalTo: errorIcon.bottomAnchor, constant: 16),
            errorLabel.leadingAnchor.constraint(equalTo: errorView.leadingAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: errorView.trailingAnchor, constant: -20)
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
        NSLayoutConstraint.activate(shimmerViewConstraints)
        NSLayoutConstraint.activate(errorViewConstraints)
        NSLayoutConstraint.activate(errorIconConstraints)
        NSLayoutConstraint.activate(errorLabelConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }

    func configure(with title: Title) {
        currentTitle = title
        titleName = title.original_title ?? title.original_name
        titleLabel.text = titleName
        overviewLabel.text = title.overview

        if !NetworkMonitor.shared.checkConnectivity() {
            shimmerView.isHidden = true
            errorView.isHidden = false
            showError(message: "No internet connection", icon: "wifi.slash")
            return
        }

        shimmerView.isHidden = false
        shimmerView.startShimmer()
        errorView.isHidden = true

        guard let name = titleName else { return }
        APICaller.shared.getMovie(with: name + " trailer") { [weak self] result in
            switch result {
                case .success(let videoElement):
                    DispatchQueue.main.async {
                        self?.loadVideo(videoElement: videoElement)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                        self?.shimmerView.stopShimmer()
                        self?.shimmerView.isHidden = true

                        if !NetworkMonitor.shared.checkConnectivity() {
                            self?.showError(message: "No internet connection", icon: "wifi.slash")
                        } else {
                            self?.showError(message: "Failed to load video", icon: "exclamationmark.triangle")
                        }
                    }
            }
        }
    }

    private func loadVideo(videoElement: VideoElement) {
        guard let url = URL(string: "https://www.youtube.com/embed/\(videoElement.id.videoId)") else {
            shimmerView.stopShimmer()
            shimmerView.isHidden = true
            return
        }
        var request = URLRequest(url: url)
        guard let bundleID = Bundle.main.bundleIdentifier else {
            shimmerView.stopShimmer()
            shimmerView.isHidden = true
            return
        }
        request.setValue("https://\(bundleID)", forHTTPHeaderField: "Referer")
        webView.load(request)
    }

    private func showError(message: String, icon: String) {
        errorView.isHidden = false
        errorLabel.text = message
        errorIcon.image = UIImage(systemName: icon)
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

extension TitlePreviewViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        shimmerView.stopShimmer()
        shimmerView.isHidden = true
        errorView.isHidden = true
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        shimmerView.stopShimmer()
        shimmerView.isHidden = true

        if !NetworkMonitor.shared.checkConnectivity() {
            showError(message: "No internet connection", icon: "wifi.slash")
        } else {
            showError(message: "Failed to load video", icon: "exclamationmark.triangle")
        }
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        shimmerView.stopShimmer()
        shimmerView.isHidden = true

        if !NetworkMonitor.shared.checkConnectivity() {
            showError(message: "No internet connection", icon: "wifi.slash")
        } else {
            showError(message: "Failed to load video", icon: "exclamationmark.triangle")
        }
    }
}
