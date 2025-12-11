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
                completion(.failure(error))
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
                completion(.failure(error))
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
                completion(.failure(error))
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
                completion(.failure(error))
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
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
