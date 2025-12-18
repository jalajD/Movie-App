//
//  APICaller.swift
//  Movie-App
//
//  Created by Deotwal, Jalaj | Ronnie on 2025/12/10.
//

import Foundation

struct Constants {
    static let API_KEY = "************"
    static let baseURL = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = "****************"
    static let YoutubeabaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()

    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {

        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else { return }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data, error == nil else { return }

            do {
                let response = try JSONDecoder().decode(TrendignTitleResponse.self, from: data)
                completion(.success(response.results))

            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }

    func getTrendingTvs(completion: @escaping (Result<[Title], Error>) -> Void) {

        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else { return }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data, error == nil else { return }

            do {
                let response = try JSONDecoder().decode(TrendignTitleResponse.self, from: data)
                completion(.success(response.results))

            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }

    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {

        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)") else { return }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data, error == nil else { return }

            do {
                let response = try JSONDecoder().decode(TrendignTitleResponse.self, from: data)
                completion(.success(response.results))

            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }

    func getPopular(completion: @escaping (Result<[Title], Error>) -> Void) {

        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)") else { return }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data, error == nil else { return }

            do {
                let response = try JSONDecoder().decode(TrendignTitleResponse.self, from: data)
                completion(.success(response.results))

            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }

    func getTopRated(completion: @escaping (Result<[Title], Error>) -> Void) {

        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)") else { return }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data, error == nil else { return }

            do {
                let response = try JSONDecoder().decode(TrendignTitleResponse.self, from: data)
                completion(.success(response.results))

            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }

    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void) {

        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)") else { return }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data, error == nil else { return }

            do {
                let response = try JSONDecoder().decode(TrendignTitleResponse.self, from: data)
                completion(.success(response.results))

            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }

    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void) {

        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }

        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else { return }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data, error == nil else { return }

            do {
                let response = try JSONDecoder().decode(TrendignTitleResponse.self, from: data)
                completion(.success(response.results))

            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }

    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {

        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }

        guard let url = URL(string: "\(Constants.YoutubeabaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else { return }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data, error == nil else { return }

            do {
                let response = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(response.items[0]))

            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
}
