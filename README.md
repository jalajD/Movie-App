# Movie App

A Netflix-inspired iOS app for discovering movies and TV shows, watching trailers, and saving titles for later.

## Demo

<!-- Demo video here-->

## Features

- **Home Feed** — Browse trending movies, trending TV shows, popular titles, upcoming releases, and top-rated content in a horizontally scrollable feed
- **Hero Banner** — Featured movie at the top of the home screen with Play and Download actions
- **Upcoming** — Dedicated tab listing movies releasing soon
- **Search** — Real-time search for any movie or TV show with a grid of results
- **Trailers** — Watch YouTube trailers embedded directly in the app via WebKit
- **Downloads** — Save titles locally with Core Data and access them offline
- **Duplicate Prevention** — Adding an already-saved title shows a toast instead of saving again
- **Network Awareness** — Detects connectivity loss and shows appropriate error states
- **Shimmer Loading** — Skeleton animations while images and videos load
- **Long-Press Context Menu** — Quick-download any title without opening its detail page

## Screenshots

<!-- Add screenshots here once you have them -->

## Tech Stack

| Category | Technology |
|---|---|
| Language | Swift |
| UI Framework | UIKit (programmatic, no Storyboard) |
| Local Storage | Core Data |
| Video Playback | WebKit (WKWebView) |
| Image Loading | SDWebImage |
| Networking | URLSession |
| Connectivity | Network (NWPathMonitor) |
| Min iOS Version | iOS 14+ |

## Architecture

The app follows **MVC** with a **Manager** layer for business logic:

```
Controllers/
├── Core/               # Tab view controllers (Home, Upcoming, Search, Downloads)
└── General/            # Detail/modal screens (TitlePreview, SearchResults)

Views/                  # Reusable UIView subclasses and UITableView/UICollectionView cells
ViewModels/             # Lightweight structs for cell configuration
Models/                 # Codable structs for API responses
Managers/
├── APICaller           # All TMDB + YouTube API calls (singleton)
├── DataPersistenceManager  # Core Data CRUD operations (singleton)
└── NetworkMonitor      # NWPathMonitor wrapper (singleton)
Resources/              # Extensions (shimmer, toast, string helpers)
```

## APIs Used

- [The Movie Database (TMDB)](https://www.themoviedb.org/documentation/api) — movie and TV show data, poster images
- [YouTube Data API v3](https://developers.google.com/youtube/v3) — trailer search and embedding

## Setup

### Prerequisites

- Xcode 14 or later
- iOS 14+ simulator or device
- CocoaPods (for SDWebImage)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/YOUR_USERNAME/Movie-App.git
   cd Movie-App
   ```

2. Install dependencies:
   ```bash
   pod install
   ```

3. Open the workspace (not the `.xcodeproj`):
   ```bash
   open Movie-App.xcworkspace
   ```

4. Add your API keys in `Constants.swift` (or wherever they are stored):
   ```swift
   let tmdbAPIKey = "YOUR_TMDB_API_KEY"
   let youtubeAPIKey = "YOUR_YOUTUBE_API_KEY"
   ```
   > **Note:** Never commit real API keys to a public repository. Consider using a `.xcconfig` file or environment variables.

5. Build and run on a simulator or device (`Cmd + R`).

## Project Structure

```
Movie-App/
├── Movie-App.xcodeproj/
├── Movie-App/
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   ├── MainTabBarViewController.swift
│   ├── Controllers/
│   │   ├── Core/
│   │   │   ├── HomeViewController.swift
│   │   │   ├── UpcomingViewController.swift
│   │   │   ├── SearchViewController.swift
│   │   │   └── DownloadsViewController.swift
│   │   └── General/
│   │       ├── TitlePreviewViewController.swift
│   │       └── SearchResultsViewController.swift
│   ├── Views/
│   │   ├── HeroHeaderUIView.swift
│   │   ├── CollectionViewTableViewCell.swift
│   │   ├── TitleCollectionViewCell.swift
│   │   └── TitleTableViewCell.swift
│   ├── ViewModels/
│   │   ├── TitleViewModel.swift
│   │   └── TitlePreviewViewModel.swift
│   ├── Models/
│   │   ├── Title.swift
│   │   └── YoutubeSearchResponse.swift
│   ├── Managers/
│   │   ├── APICaller.swift
│   │   ├── DataPersistenceManager.swift
│   │   └── NetworkMonitor.swift
│   ├── Resources/
│   │   ├── Extensions.swift
│   │   ├── UIViewController+Extension.swift
│   │   └── UIView+Shimmer.swift
│   └── MovieAppModel.xcdatamodeld/
└── Podfile
```

---
